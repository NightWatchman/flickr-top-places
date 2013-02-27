#import "RecentPhotosViewController.h"
#import "FlickrFetcher.h"
#import "RecentPictures.h"


#define NSUserDefaultsRecentPictures @"RECENT_PICTURES"


@interface RecentPhotosViewController ()

@property (nonatomic, strong) NSArray *photos;

@end


@implementation RecentPhotosViewController

@synthesize photos = _photos;
- (NSArray *)photos
{
  if (!_photos)
    _photos = [RecentPictures recentPictures];
  return _photos;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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
  UITableViewCell *cell =
  [self.tableView dequeueReusableCellWithIdentifier:@"Picture Summary"];
  if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:@"Picture Summary"];
  cell.textLabel.text = @"";
  cell.detailTextLabel.text = @"";
  return cell;
}

- (NSArray *)recentPhotos {
  return [[NSUserDefaults standardUserDefaults]
          arrayForKey:NSUserDefaultsRecentPictures];
}

@end
