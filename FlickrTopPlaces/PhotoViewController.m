#import "PhotoViewController.h"
#import "FlickrFetcher.h"
#import "RecentPictures.h"
#import "FlickrPhotoUtil.h"


@interface PhotoViewController ()


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) dispatch_queue_t downloadQueue;

@end


@implementation PhotoViewController

@synthesize photo = _photo;
- (void)setPhoto:(NSDictionary *)photo
{
  _photo = photo;
  self.title = [FlickrPhotoUtil displayNameForPhoto:self.photo];
  [RecentPictures addRecentPicture:photo];
  dispatch_async(self.downloadQueue, ^{
    UIImage *img = [self imageForPhoto];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self presentImage:img];
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

- (UIImage *)imageForPhoto
{
  NSURL *url = [FlickrFetcher urlForPhoto:self.photo
                                   format:FlickrPhotoFormatLarge];
  NSData *bin = [NSData dataWithContentsOfURL:url];
  return [UIImage imageWithData:bin];
}

- (void)presentImage:(UIImage *)image
{
  self.imageView.image = image;
  self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
  self.scrollView.zoomScale = [self zoomLevelForPhoto:image];
  self.scrollView.contentSize = self.imageView.frame.size;
}

- (double)zoomLevelForPhoto:(UIImage *)photo
{
  CGSize photoSize = photo.size;
  CGSize scrollViewSize = self.scrollView.bounds.size;
  double widthZoom = scrollViewSize.width / photoSize.width;
  double heightZoom = scrollViewSize.height / photoSize.height;
  return MAX(widthZoom, heightZoom);
}

#pragma UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.scrollView.delegate = self;
}

- (void)viewDidUnload
{
  [self setImageView:nil];
  [self setScrollView:nil];
  [super viewDidUnload];
  dispatch_release(self.downloadQueue);
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  dispatch_release(self.downloadQueue);
}

#pragma UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return self.imageView;
}

@end
