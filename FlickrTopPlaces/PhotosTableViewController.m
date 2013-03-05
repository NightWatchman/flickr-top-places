#import "PhotosTableViewController.h"
#import "FlickrFetcher.h"
#import "PhotoViewController.h"


@interface PhotosTableViewController ()

@property (nonatomic) dispatch_queue_t downloadQueue;

@end


@implementation PhotosTableViewController

@synthesize photos = _photos;
- (void)setPhotos:(NSArray *)photos {
  _photos = photos;
  [self.tableView reloadData];
}

@synthesize downloadQueue = _downloadQueue;
- (dispatch_queue_t) downloadQueue {
  if (!_downloadQueue)
    _downloadQueue = dispatch_queue_create("Thumbnail Download", NULL);
  return _downloadQueue;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
}

- (void)viewDidUnload {
  [super viewDidUnload];
  dispatch_release(self.downloadQueue);
}

- (void)didReceiveMemoryWarning {
  dispatch_release(self.downloadQueue);
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
  dispatch_async(self.downloadQueue, ^{
    UIImage *img = [self thumbnailForPhoto:photo];
    dispatch_async(dispatch_get_main_queue(), ^{
      cell.imageView.image = img;
    });
  });
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
