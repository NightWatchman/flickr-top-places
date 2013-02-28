#import "PhotoViewController.h"
#import "FlickrFetcher.h"


@interface PhotoViewController ()

@end


@implementation PhotoViewController

@synthesize photo = _photo;
@synthesize imageView = _imageView;

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.title = [self.photo objectForKey:FLICKR_PHOTO_TITLE];
  self.imageView.image = [self imageForPhoto];
}

- (UIImage *)imageForPhoto {
  NSURL *url = [FlickrFetcher urlForPhoto:self.photo
                                   format:FlickrPhotoFormatLarge];
  NSData *bin = [NSData dataWithContentsOfURL:url];
  return [UIImage imageWithData:bin];
}

@end
