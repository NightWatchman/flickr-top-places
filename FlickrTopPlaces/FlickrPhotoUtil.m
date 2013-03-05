#import "FlickrPhotoUtil.h"
#import "FlickrFetcher.h"


@implementation FlickrPhotoUtil

+ (NSString *)displayNameForPhoto:(NSDictionary *)photo {
  NSString *name = [photo objectForKey:FLICKR_PHOTO_TITLE];
  if (!name || name.length == 0)
    name = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
  if (!name || name.length == 0)
    name = @"Unknown";
  return name;
}

@end
