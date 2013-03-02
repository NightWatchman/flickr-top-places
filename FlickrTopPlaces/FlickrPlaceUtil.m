#import "FlickrPlaceUtil.h"
#import "FlickrFetcher.h"


@implementation FlickrPlaceUtil

+ (NSDictionary *)nameForPlace: (NSDictionary *)place {
  NSString *placeName = [place objectForKey:FLICKR_PLACE_NAME];
  NSString *city = [[placeName componentsSeparatedByString:@","] objectAtIndex:0];
  NSString *region = [placeName substringFromIndex:city.length + 2];
  return [NSDictionary dictionaryWithObjectsAndKeys:
          city, FLICKR_PLACE_NAME_CITY_KEY,
          region, FLICKR_PLACE_NAME_REGION_KEY, nil];
}

@end
