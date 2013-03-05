#import "PhotoViewController.h"
#import "FlickrFetcher.h"
#import "RecentPictures.h"
#import "FlickrPhotoUtil.h"


@interface PhotoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) dispatch_queue_t downloadQueue;

@end


@implementation PhotoViewController

@synthesize photo = _photo;
- (void)setPhoto:(NSDictionary *)photo {
  _photo = photo;
  self.title = [FlickrPhotoUtil displayNameForPhoto:self.photo];
  [RecentPictures addRecentPicture:photo];
  dispatch_async(self.downloadQueue, ^{
    UIImage *img = [self imageForPhoto];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.imageView.image = img;
    });
  });
}

@synthesize downloadQueue = _downloadQueue;
- (dispatch_queue_t)downloadQueue
{
  if (!_downloadQueue)
    _downloadQueue = dispatch_queue_create("Photo Download", nil);
  return _downloadQueue;
}

@synthesize imageView = _imageView;

- (void)viewDidUnload
{
  [super viewDidUnload];
  dispatch_release(self.downloadQueue);
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  dispatch_release(self.downloadQueue);
}

- (UIImage *)imageForPhoto {
  NSURL *url = [FlickrFetcher urlForPhoto:self.photo
                                   format:FlickrPhotoFormatLarge];
  NSData *bin = [NSData dataWithContentsOfURL:url];
  return [UIImage imageWithData:bin];
}

@end
