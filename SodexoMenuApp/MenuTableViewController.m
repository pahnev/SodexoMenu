//
//  TableViewController.m
//
//
//  Created by Kirill Pahnev on 31.5.2014.
//
//

#import "MenuTableViewController.h"
static NSString *const SessionManagerBaseUrlString = @"http://www.sodexo.fi/ruokalistat/output/daily_json/";

@interface MenuTableViewController () {
    NSString *price;
}

@property(strong, nonatomic) NSArray *data;
@property(strong, nonatomic) NSArray *locationName;
@property(strong, nonatomic) NSString *date;
@property(nonatomic, retain) NSDateFormatter *formatter;

@end

@implementation MenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self setupFeedbackMe];

    self.navigationController.navigationBar.translucent = NO;

    self.date = [self currentDate];
    //self.date = @"2014/09/18";
    NSDictionary *size = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:16.0]};

    self.navigationController.navigationBar.titleTextAttributes = size;
    //self.navigationItem.prompt = [NSString stringWithFormat:@"%@", self.date];
    [self downloadMenu];

    [self.navigationController.navigationBar
        setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
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
    NSDictionary *data = self.data[indexPath.row];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];

    NSString *myLanguage = [NSLocale preferredLanguages][0];
    if ([myLanguage isEqualToString:@"en"]) {
        titleLabel.text = data[@"title_en"];
        if (data[@"title_en"] == 0) {
            titleLabel.text = data[@"title_fi"];
        }

    } else {
        titleLabel.text = data[@"title_fi"];
    }

    UILabel *categoryNameLabel = (UILabel *)[cell viewWithTag:101];
    categoryNameLabel.text = data[@"category"];
    UILabel *propertyNameLabel = (UILabel *)[cell viewWithTag:102];
    propertyNameLabel.text = data[@"properties"];
    UILabel *PriceNameLabel = (UILabel *)[cell viewWithTag:103];

    price = data[@"price"];
    price = [price stringByReplacingOccurrencesOfString:@"/" withString:@"€"];
    price = [price stringByAppendingString:@" €"];
    PriceNameLabel.text = price;

    return cell;
}

#pragma mark - Network methods
- (void)downloadMenu
{
    self.url = _url;
    NSString *baseURL = [NSString stringWithFormat:@"http://www.sodexo.fi/ruokalistat/output/daily_json/%@/%@/fi", self.url, self.date];
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc] init];
    
    __weak AFHTTPRequestOperationManager *weakManager = manager;
    weakManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.titleView = aiView;
    [aiView startAnimating];

    [manager GET:baseURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.navigationItem.titleView = nil;
        [aiView stopAnimating];

        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject objectForKey:@"courses"] count] == 0) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Oh no!", nil)
                                                             message:NSLocalizedString(@"There is no menu today.", nil)
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
                [av show];
                
            } else {
                self.data = [responseObject objectForKey:@"courses"];
                self.title = responseObject[@"meta"][@"ref_title"];
            }
            
            [self.tableView reloadData];
//            [LBFeedbackMe eventFired:@"DATA_LOADED"];

        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        NSString *errorString = [NSString stringWithFormat:@"%@", [error localizedDescription]];
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Oh no! Something went wrong!", nil)
                                                     message:NSLocalizedString(errorString, nil)
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
    self.formatter = [[DFDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"YYYY/MM/dd"];

    NSString *dateString = [self.formatter stringFromDate:currentDate];


    return dateString;
}

- (void) setupFeedbackMe {
    [LBFeedbackMe setupWithAppStoreId:@"id916274230" openFeedbackViewBlock:^{
        UIViewController *actualViewController; //Get current view controller from AppDelegate or other place
        UIViewController *feedbackViewController = [UIViewController new]; //Instantiate your custom feedback view controller
        [actualViewController presentViewController:feedbackViewController animated:true completion:nil];
    }];
    [LBFeedbackMe waitForEvent:@"DATA_LOADED" times:@1];

}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.data forKey:@"data"];
    [coder encodeObject:self.title forKey:@"title"];
    NSLog(@"Encoding");
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    self.data = [coder decodeObjectForKey:@"data"];
    self.title = [coder decodeObjectForKey:@"title"];
    NSLog(@"Decoding");
    [super decodeRestorableStateWithCoder:coder];
}

@end