//
//  TableViewController.m
//
//
//  Created by Kirill Pahnev on 31.5.2014.
//
//

#import "TableViewController.h"
#import "MenuTableViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

#import "Factory.h"
static NSString *const SessionManagerBaseUrlString = @"http://www.sodexo.fi/ruokalistat/output/daily_json/";

@interface TableViewController () {
    NSString *price;
}

@property(strong, nonatomic) NSArray *data;
@property(strong, nonatomic) NSArray *locationName;
@property(strong, nonatomic) NSString *date;
@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.date = [self currentDate];

    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue" size:16.0], NSFontAttributeName, nil];

    self.navigationController.navigationBar.titleTextAttributes = size;
    //self.navigationItem.prompt = [NSString stringWithFormat:@"%@", self.date];
	[self sessionManager];
	
	// Pull to refresh
	UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
	refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
	[refresh addTarget:self
				action:@selector(refreshView:)
	  forControlEvents:UIControlEventValueChanged];
	self.refreshControl = refresh;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"detailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *data = [self.data objectAtIndex:indexPath.row];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    titleLabel.text = [data objectForKey:@"title_fi"];

    UILabel *categoryNameLabel = (UILabel *)[cell viewWithTag:101];
    categoryNameLabel.text = [data objectForKey:@"category"];
    UILabel *propertyNameLabel = (UILabel *)[cell viewWithTag:102];
    propertyNameLabel.text = [data objectForKey:@"properties"];
    UILabel *PriceNameLabel = (UILabel *)[cell viewWithTag:103];

    price = [data objectForKey:@"price"];
    price = [price stringByReplacingOccurrencesOfString:@"/" withString:@"€"];
    price = [price stringByAppendingString:@" €"];
    PriceNameLabel.text = price;

    return cell;
}

#pragma mark - Network methods

- (void)sessionManager
{
    SessionManager *sessionManager = [SessionManager sharedClient];

    // Configure Request Operation Manager
    [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];

    sessionManager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;

    self.url = _url;
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/en", self.url, self.date];
    //Remember to delete

    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.titleView = aiView;
    [aiView startAnimating];

    // Send Request
    [sessionManager GET:urlString
        parameters:nil
        success:^(NSURLSessionDataTask *task, id responseObject) {
					
					// NSLog(@"Success, %@", responseObject);
					[aiView stopAnimating];
					self.navigationItem.titleView = nil;
					self.data = [responseObject objectForKey:@"courses"];
					self.title = responseObject[@"meta"][@"ref_title"];
					
					[self.tableView reloadData];
        }
        failure:^(NSURLSessionDataTask *task, NSError *error) {
					NSString *errorString = [NSString stringWithFormat:@"%@",
											 [error localizedDescription]];
					UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Oops! Something went wrong!"
																 message:errorString
																delegate:nil
													   cancelButtonTitle:@"OK"
													   otherButtonTitles:nil];
					[av show];
					[aiView stopAnimating];
        }];
}

#pragma mark - Helper methods
- (NSString *)currentDate
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];

    return dateString;
}

-(void)refreshView:(UIRefreshControl *)refresh {
	
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    [self sessionManager];
    
	[[self tableView] reloadData];
    
    [refresh endRefreshing];
}

- (void)removeAllCachedResponses
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSLog(@"Removing cache");
}

@end
