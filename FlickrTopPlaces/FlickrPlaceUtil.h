#import <Foundation/Foundation.h>


#define FLICKR_PLACE_NAME_CITY_KEY @"city"
#define FLICKR_PLACE_NAME_REGION_KEY @"region"


@interface FlickrPlaceUtil : NSObject

+ (NSDictionary *)nameForPlace: (NSDictionary *)place;

@end
