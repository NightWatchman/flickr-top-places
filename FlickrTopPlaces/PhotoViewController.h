#import <UIKit/UIKit.h>


@interface PhotoViewController : UIViewController

@property (strong, nonatomic) NSDictionary *photo;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
