//
//  RestaurantsTableViewController.h
//  
//
//  Created by Kirill Pahnev on 1.9.2014.
//
//

#import <UIKit/UIKit.h>
#import "MenuTableViewController.h"
#import "Factory.h"

@interface RestaurantsTableViewController : UITableViewController

@property(nonatomic, strong) NSDictionary *jsonDataDictionary;
@property(nonatomic, strong) NSArray *cityArray;

@property (strong, nonatomic) NSString *cityName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
