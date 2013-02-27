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
}

@end
