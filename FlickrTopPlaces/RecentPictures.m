#import "RecentPictures.h"


#define NSUserDefaultsRecentPictures @"RECENT_PICTURES"


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
  [prefs setObject:picture forKey:NSUserDefaultsRecentPictures];
  [prefs synchronize];
}

@end
