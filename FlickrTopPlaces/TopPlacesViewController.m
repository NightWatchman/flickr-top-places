#import <UIKit/UIKit.h>
#import "TopPlacesViewController.h"
#import "FlickrFetcher.h"
#import "PlacePhotosViewController.h"
#import "FlickrPlaceUtil.h"


@interface TopPlacesViewController ()

@property (nonatomic, strong) NSArray *places;

@end


@implementation TopPlacesViewController

@synthesize places = _places;
- (void)setPlaces:(NSArray *)places {
  _places = places;
  [self.tableView reloadData];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.clearsSelectionOnViewWillAppear = NO;
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  dispatch_queue_t downloadQueue = dispatch_queue_create("Place Download", NULL);
  dispatch_async(downloadQueue, ^{
    NSArray *places = [FlickrFetcher topPlaces];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.places = places;
    });
  });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"View Photo"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSDictionary *place = [self.places objectAtIndex:indexPath.row];
    NSDictionary *placeName = [FlickrPlaceUtil nameForPlace:place];
    PhotosTableViewController *dest = segue.destinationViewController;
    dest.title = [[placeName objectForKey:FLICKR_PLACE_NAME_CITY_KEY]
                  stringByAppendingString:@" Pictures"];
  }
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSDictionary *place = [self.places objectAtIndex:indexPath.row];
  NSDictionary *placeName = [FlickrPlaceUtil nameForPlace:place];
  UITableViewCell *cell =
  [self.tableView dequeueReusableCellWithIdentifier:@"Geographical Place"];
  if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:@"Geographical Place"];
  cell.textLabel.text = [placeName objectForKey:FLICKR_PLACE_NAME_CITY_KEY];
  cell.detailTextLabel.text = [placeName
                               objectForKey:FLICKR_PLACE_NAME_REGION_KEY];
  return cell;
}

@end
