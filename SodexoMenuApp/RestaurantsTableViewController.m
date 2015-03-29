//
//  RestaurantsTableViewController.m
//
//
//  Created by Kirill Pahnev on 1.9.2014.
//
//

#import "RestaurantsTableViewController.h"
#import "SWRevealViewController.h"


@interface RestaurantsTableViewController ()

@end

@implementation RestaurantsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    
    NSLog(@"selected country: %@", [self jsonArrayForSelectedCountry]);
    NSLog(@"titles in country: %@", [self getTitleArray]);
    NSLog(@"urls in country: %@", [self getUrlArray]);

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

-(void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.tableView forKey:@"tableView"];
    [super encodeRestorableStateWithCoder:coder];
}
-(void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    self.tableView = [coder decodeObjectForKey:@"tableView"];
    [super decodeRestorableStateWithCoder:coder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self getTitleArray]count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.text = [[self getTitleArray] objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark - Helpers
-(NSArray *)jsonArrayForSelectedCountry
{
    NSArray *myArray = [self.jsonDataDictionary[@"cities"] valueForKey:_cityName];
    return myArray;
}

-(NSArray *)getTitleArray
{
    NSArray *titleArray = [[self jsonArrayForSelectedCountry] valueForKey:@"title"];
    
    return titleArray;
}

-(NSArray *) getUrlArray
{
    NSArray *urlArray = [[self jsonArrayForSelectedCountry] valueForKey:@"url"];

    return urlArray;
}

- (void)loadData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [[Factory sharedInstance] fetchDataInBackgroundWithCompletionHandler:^(BOOL success, NSDictionary *data, NSError *error) {
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Oh no! Something went wrong!", nil)
                                                            message:error.localizedDescription
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            NSLog(@"error");
            self.jsonDataDictionary = [userDefaults objectForKey:@"cities"];
        } else {
            self.jsonDataDictionary = data;
            [userDefaults setObject:self.jsonDataDictionary forKey:@"cityJson"];
            [userDefaults synchronize];
        }
        self.cityArray = self.jsonDataDictionary[@"cities"];
        self.title = _cityName;
        
        NSArray *array = [self.jsonDataDictionary[@"cities"] allKeys];
//        NSLog(@"%@", array);
        if ([userDefaults objectForKey:@"cityName"]) {
            self.cityName = [userDefaults objectForKey:@"cityName"];
            NSLog(@"cityname should be %@", [userDefaults objectForKey:@"cityName"]);

        } else {
            self.cityName = [array sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)][0];

        }

        [self.tableView reloadData];
        
    }];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMenu"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MenuTableViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.url = [self getUrlArray][indexPath.row];
        destinationViewController.title = destinationViewController.restaurantName;
    }
}


@end
