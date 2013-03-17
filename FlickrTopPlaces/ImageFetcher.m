#import "ImageFetcher.h"


@interface ImageFetcher ()

@property (nonatomic, strong, readonly) NSString *cachePath;

@end


@implementation ImageFetcher

@synthesize cachePath = cachePath_;
- (NSString *)cachePath
{
  if (!cachePath_) {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *cacheDirs = [fileManager URLsForDirectory:NSCachesDirectory
                                             inDomains:NSLocalDomainMask];
    cachePath_ = [[cacheDirs lastObject] absoluteString];
  }
  return cachePath_;
}

- (id)init
{
  self = [super init];
  return self;
}

- (UIImage *)imageWithUrl:(NSURL *)url
{
  [self cacheImage:[[UIImage alloc] init] withUrl:[NSURL URLWithString:@""]];
  NSData *imgBits = [NSData dataWithContentsOfURL:url];
  return [UIImage imageWithData:imgBits];
}

- (void)cacheImage:(UIImage *)image withUrl:(NSURL *)url
{
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSDictionary *attrs = [fileManager attributesOfItemAtPath:self.cachePath
                                                      error:nil];
  if (attrs.fileSize > 10000000)
    [self trimCache];
  [NSString path]
  [UIImageJPEGRepresentation(image, 1.0)]
}

- (void)trimCache
{
  NSLog(@"Trimming cache");
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSURL *cachePath = [NSURL URLWithString:self.cachePath];
  NSArray *includeKeys = [NSArray arrayWithObjects:NSFileModificationDate, nil];
  // TODO: Error handling for cache recent pic enumeration
  NSDirectoryEnumerator *cacheFiles = [fileManager
                                       enumeratorAtURL:cachePath
                                       includingPropertiesForKeys:includeKeys
                                       options:NSDirectoryEnumerationSkipsSubdirectoryDescendants
                                       errorHandler:nil];
  NSURL *file = [cacheFiles nextObject];
  NSURL *oldestFile = file;
  if (!oldestFile)
    return;
  NSDate *oldestDate = [self modificationDateOfFile:oldestFile];
  NSDate *fileDate;
  while (file = [cacheFiles nextObject]) {
    fileDate = [self modificationDateOfFile:file];
    if ([fileDate compare:oldestDate] == NSOrderedAscending) {
      oldestFile = file;
      oldestDate = [self modificationDateOfFile:file];
    }
  }
  // TODO: Error handling for cache deleting item notification
  [fileManager removeItemAtURL:file error:nil];
}

- (NSDate *)modificationDateOfFile:(NSURL *)file
{
  NSString *path = [file absoluteString];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSDictionary *attrs = [fileManager attributesOfItemAtPath:path
                                                          error:nil];
  return [attrs fileModificationDate];
}

@end
