//
//  TableViewController.h
//
//
//  Created by Kirill Pahnev on 31.5.2014.
//
//

#import <UIKit/UIKit.h>
#import "SessionManager.h"
#import "AFNetworking.h"
#import "CitiesTableViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "DFDateFormatterFactory.h"
#import "Factory.h"

@interface MenuTableViewController : UITableViewController

@property(strong, nonatomic) NSArray *cities;
@property(strong, nonatomic) NSArray *url;
@property(strong, nonatomic) NSString *restaurantName;

@property(strong, nonatomic) NSURLSessionDataTask *task;
@property(nonatomic)AFHTTPRequestOperation *operation;

@end
