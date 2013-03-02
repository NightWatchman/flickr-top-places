#import "PlacePhotosViewController.h"
#import "FlickrFetcher.h"
#import "FlickrPlaceUtil.h"


@interface PlacePhotosViewController ()

@end


@implementation PlacePhotosViewController

@synthesize place = _place;

- (void)viewDidLoad
{
  [super viewDidLoad];
  NSDictionary *placeName = [FlickrPlaceUtil nameForPlace:self.place];
  NSString *city = [placeName objectForKey:FLICKR_PLACE_NAME_CITY_KEY];
  self.title = [city stringByAppendingString:@" Photos"];
  self.photos = [FlickrFetcher photosInPlace:self.place maxResults:50];
}

@end
