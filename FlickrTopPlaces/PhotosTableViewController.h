#import <UIKit/UIKit.h>


@interface PhotosTableViewController : UITableViewController
    <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *photos; // of flickr places NSDictionaries

@end
