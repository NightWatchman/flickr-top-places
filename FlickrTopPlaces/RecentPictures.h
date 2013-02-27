#import <UIKit/UIKit.h>


@interface RecentPictures : NSObject

+ (NSArray *)recentPictures;
+ (void)addRecentPicture:(NSDictionary *)picture;

@end
