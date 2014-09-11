//
//  MenuTableViewController.m
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 29.8.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import "MenuTableViewController.h"
#import "RestaurantsTableViewController.h"
#import "Factory.h"

@interface MenuTableViewController ()

@property(nonatomic, strong) NSDictionary *cityJson;
@property(nonatomic, strong) NSArray *cityArray;

@end

@implementation MenuTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // iOS 6.1 or earlier
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:102.0 / 255.0 green:153.0 / 255.0 blue:204.0 / 255.0 alpha:1.0];
    } else {
        // iOS 7.0 or later
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:102.0 / 255.0 green:153.0 / 255.0 blue:204.0 / 255.0 alpha:1.0];
        self.navigationController.navigationBar.translucent = NO;
    }
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	[self.navigationController.navigationBar
	 setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    Factory *shared = [Factory cityJson];
    self.cityJson = shared.cityJson;

    self.cityArray = [self.cityJson[@"cities"] allKeys];
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
    NSString *city = [[self.cityArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.row];

    cell.textLabel.text = city;

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showRestaurants"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RestaurantsTableViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.cityName = [[self.cityArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.row];
        destinationViewController.title = destinationViewController.cityName;
    }
}

@end
