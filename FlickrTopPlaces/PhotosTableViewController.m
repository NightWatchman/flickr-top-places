#import "PhotosTableViewController.h"



@interface PhotosTableViewController ()

@property (nonatomic, strong) NSArray *photos;

@end


@implementation PhotosTableViewController

@synthesize photos = _photos;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell =
  [self.tableView dequeueReusableCellWithIdentifier:@"Picture Summary"];
  if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:@"Picture Summary"];
  cell.textLabel.text = @"";
  cell.detailTextLabel.text = @"";
  return cell;
}

@end
