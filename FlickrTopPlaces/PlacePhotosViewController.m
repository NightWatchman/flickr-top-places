#import "PlacePhotosViewController.h"
#import "FlickrFetcher.h"
#import "FlickrPlaceUtil.h"


@interface PlacePhotosViewController ()

@property (nonatomic) dispatch_queue_t downloadQueue;

@end


@implementation PlacePhotosViewController

@synthesize place = _place;
- (void)setPlace:(NSDictionary *)place {
  _place = place;
  NSDictionary *placeName = [FlickrPlaceUtil
                             nameForPlace:self.place];
  NSString *city = [placeName objectForKey:FLICKR_PLACE_NAME_CITY_KEY];
  self.title = [city stringByAppendingString:@" Photos"];
  dispatch_async(self.downloadQueue, ^{
    NSArray *photos = [FlickrFetcher photosInPlace:self.place maxResults:50];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.photos = photos;
    });
  });
}

@synthesize downloadQueue = _downloadQueue;
- (dispatch_queue_t)downloadQueue
{
  if (!_downloadQueue)
    _downloadQueue = dispatch_queue_create("Place Photos Download", nil);
  return _downloadQueue;
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  dispatch_release(self.downloadQueue);
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  dispatch_release(self.downloadQueue);
}

@end
