#import "RecentPictures.h"
#import "FlickrFetcher.h"


#define NSUserDefaultsRecentPictures @"RECENT_PICTURES"
#define NSUserDefaultsRecentPicturesMaxLength 20


@implementation RecentPictures

+ (NSArray *)recentPictures
{
  return [[NSUserDefaults standardUserDefaults]
          arrayForKey:NSUserDefaultsRecentPictures];
}

+ (void)addRecentPicture:(NSDictionary *)picture
{
  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  NSMutableArray *savedPics = [[prefs
                               arrayForKey:NSUserDefaultsRecentPictures]
                               mutableCopy];
  if (!savedPics)
    savedPics = [[NSMutableArray alloc] initWithCapacity:1];
  
  NSString *picId = [picture objectForKey:FLICKR_PHOTO_ID];
  for (NSDictionary *pic in savedPics) {
    if ([picId isEqualToString:[pic objectForKey:FLICKR_PHOTO_ID]])
      return;
  }
  
  [savedPics insertObject:picture atIndex:0];
  if (savedPics.count > NSUserDefaultsRecentPicturesMaxLength) {
    savedPics = [[savedPics subarrayWithRange:NSMakeRange
                 (0, NSUserDefaultsRecentPicturesMaxLength)] mutableCopy];
  }
  [prefs setObject:savedPics forKey:NSUserDefaultsRecentPictures];
  [prefs synchronize];
}

@end
