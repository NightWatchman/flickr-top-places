#import "PlacePhotosViewController.h"
#import "FlickrFetcher.h"


@interface PlacePhotosViewController ()

@property (nonatomic, strong) NSArray *photos;

@end


@implementation PlacePhotosViewController

@synthesize photos = _photos;
@synthesize place = _place;

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.photos = [FlickrFetcher photosInPlace:self.place maxResults:50];
  NSString *placeName = [self.place objectForKey:FLICKR_PLACE_NAME];
  NSString *city = [[placeName componentsSeparatedByString:@","]
                    objectAtIndex:0];
  self.title = [city stringByAppendingString:@" Pictures"];
//  [self.tableView reloadData];
}

@end
