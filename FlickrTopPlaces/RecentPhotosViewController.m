#import "RecentPhotosViewController.h"
#import "FlickrFetcher.h"
#import "RecentPictures.h"


#define NSUserDefaultsRecentPictures @"RECENT_PICTURES"


@interface RecentPhotosViewController ()

@end


@implementation RecentPhotosViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.photos = [RecentPictures recentPictures];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.photos = [RecentPictures recentPictures];
}

@end
