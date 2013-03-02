#import <UIKit/UIKit.h>
#import "TopPlacesViewController.h"
#import "FlickrFetcher.h"
#import "PlacePhotosViewController.h"
#import "FlickrPlaceUtil.h"


@interface TopPlacesViewController ()

@property (nonatomic, strong) NSArray *topPlaces;

@end


@implementation TopPlacesViewController

@synthesize topPlaces;

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.clearsSelectionOnViewWillAppear = NO;
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.topPlaces = [FlickrFetcher topPlaces];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"View Photo"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSDictionary *place = [self.topPlaces objectAtIndex:indexPath.row];
    PlacePhotosViewController *dest = segue.destinationViewController;
    dest.place = place;
  }
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [self.topPlaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSDictionary *place = [self.topPlaces objectAtIndex:indexPath.row];
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
