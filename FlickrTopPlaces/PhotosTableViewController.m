#import "PhotosTableViewController.h"
#import "FlickrFetcher.h"


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
  NSString *title = [photo objectForKey:FLICKR_PHOTO_TITLE];
  if (!title)
    title = [photo objectForKey:FLICKR_PHOTO_DESCRIPTION];
  if (!title)
    title = @"Unknown";
  cell.textLabel.text = title;
  cell.detailTextLabel.text = [photo objectForKey:FLICKR_PHOTO_DESCRIPTION];
  return cell;
}

@end
