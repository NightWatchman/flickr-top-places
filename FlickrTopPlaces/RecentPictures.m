#import "RecentPictures.h"


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
  [savedPics insertObject:picture atIndex:0];
  if (savedPics.count > NSUserDefaultsRecentPicturesMaxLength) {
    savedPics = [[savedPics subarrayWithRange:NSMakeRange
                 (0, NSUserDefaultsRecentPicturesMaxLength)] mutableCopy];
  }
  [prefs setObject:picture forKey:NSUserDefaultsRecentPictures];
  [prefs synchronize];
}

@end
