#import <UIKit/UIKit.h>
#import "TopPlacesViewController.h"
#import "FlickrFetcher.h"
#import "PlacePhotosViewController.h"


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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"View Photo"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    PlacePhotosViewController *dest = segue.destinationViewController;
    dest.place = [self.topPlaces objectAtIndex:indexPath.row];
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
  NSString *placeName = [place valueForKey:FLICKR_PLACE_NAME];
  NSString *city = [[placeName componentsSeparatedByString:@","] objectAtIndex:0];
  NSString *placeDetails = [placeName substringFromIndex:city.length + 2];
  UITableViewCell *cell =
  [self.tableView dequeueReusableCellWithIdentifier:@"Geographical Place"];
  if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:@"Geographical Place"];
  cell.textLabel.text = city;
  cell.detailTextLabel.text = placeDetails;
  return cell;
}

@end
