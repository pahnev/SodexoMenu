//
//  MenuTableViewController.m
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 29.8.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import "CitiesTableViewController.h"

@interface CitiesTableViewController ()

@property(nonatomic, strong) NSDictionary *jsonDictionary;
@property(nonatomic, strong) NSArray *cityArray;

@end

@implementation CitiesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];

    [self factoryLoad];
    if (![self.cityArray count] == 0) {
        self.navigationItem.leftBarButtonItem = nil;

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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.cityArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    // Configure the cell...

    // First sort the array alphabetically and then put each string *city
//    NSString *city = [[self.cityArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.row];

    cell.textLabel.text =
    [[self.cityArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.row];

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showRestaurants"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RestaurantsTableViewController *destinationViewController = (RestaurantsTableViewController *)[[segue destinationViewController] topViewController];

//        RestaurantsTableViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.cityName = [[self.cityArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.row];
        destinationViewController.title = destinationViewController.cityName;
        destinationViewController.jsonDataDictionary = self.jsonDictionary;
        [userDefaults setObject:[[self.cityArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.row] forKey:@"cityName"];
        [userDefaults synchronize];

    }
}

- (void)factoryLoad
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [[Factory sharedInstance] fetchDataInBackgroundWithCompletionHandler:^(BOOL success, NSDictionary *data, NSError *error) {
        if (error) {
            NSLog(@"error");
            self.jsonDictionary = [userDefaults objectForKey:@"cityJson"];
        } else {
            self.jsonDictionary = data;
            [userDefaults setObject:self.jsonDictionary forKey:@"cityJson"];
            [userDefaults synchronize];
        }
        self.cityArray = [self.jsonDictionary[@"cities"] allKeys];
        [self.tableView reloadData];

    }];

}

@end
