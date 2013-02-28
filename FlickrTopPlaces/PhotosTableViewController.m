#import "PhotosTableViewController.h"
#import "FlickrFetcher.h"
#import "PhotoViewController.h"


@interface PhotosTableViewController ()

@property (nonatomic, strong) NSArray *photos;

@end


@implementation PhotosTableViewController

@synthesize photos = _photos;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
  UITableViewCell *cell =
  [self.tableView dequeueReusableCellWithIdentifier:@"Photo Summary"];
  if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:@"Photo Summary"];
  cell.textLabel.text = [self displayNameForPhoto:photo];
  cell.detailTextLabel.text = [photo objectForKey:FLICKR_PHOTO_DESCRIPTION];
  cell.imageView.image = [self thumbnailForPhoto:photo];
  return cell;
}

- (NSString *)displayNameForPhoto:(NSDictionary *)photo {
  NSString *title = [photo objectForKey:FLICKR_PHOTO_TITLE];
  if (!title)
    title = [photo objectForKey:FLICKR_PHOTO_DESCRIPTION];
  if (!title)
    title = @"Unknown";
  return title;
}

- (UIImage *)thumbnailForPhoto:(NSDictionary *)photo {
  NSURL *url = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatSquare];
  NSData *bin = [NSData dataWithContentsOfURL:url];
  return [UIImage imageWithData:bin];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"View Image"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    PhotoViewController *dest = segue.destinationViewController;
    dest.photo = photo;
  }
}

@end
