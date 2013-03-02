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
  return [RecentPictures recentPictures];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}

@end
