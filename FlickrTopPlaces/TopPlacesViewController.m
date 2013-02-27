#import <UIKit/UIKit.h>
#import "TopPlacesViewController.h"
#import "FlickrFetcher.h"


@interface TopPlacesViewController ()

@property (nonatomic, strong) NSArray *topPlaces;

@end


@implementation TopPlacesViewController

@synthesize topPlaces;

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.topPlaces = [FlickrFetcher topPlaces];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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
