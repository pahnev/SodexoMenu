//
//  TableViewController.h
//
//
//  Created by Kirill Pahnev on 31.5.2014.
//
//

#import <UIKit/UIKit.h>
#import "SessionManager.h"

@interface TableViewController : UITableViewController

@property(strong, nonatomic) NSArray *cities;
@property(strong, nonatomic) NSArray *url;
@property(strong, nonatomic) NSString *restaurantName;

@property(nonatomic, strong) NSDate *topSongsCacheDate;

@end
