//
//  AppDelegate.m
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 13.5.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];

    [self dateCheck];
    [self customizeUserInterface];
    [Fabric with:@[CrashlyticsKit]];


    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Helper methods

- (void)customizeUserInterface
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:102.0 / 255.0 green:153.0 / 255.0 blue:204.0 / 255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    // iOS 6.1 or earlier
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:102.0 / 255.0 green:153.0 / 255.0 blue:204.0 / 255.0 alpha:1.0]];
    }
}

- (void)dateCheck
{
    NSDate *dateCheck = [NSDate date];
    //NSLog(@"datecheck: %@", dateCheck);

    NSDate *saveDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastStartDate"];
    if (!saveDate) {
        // This is the 1st run of the app
        saveDate = [NSDate date];

        [[NSUserDefaults standardUserDefaults] setObject:saveDate forKey:@"lastStartDate"];
    }
    //NSLog(@"First run was on: %@", saveDate);

    NSInteger interval = [[[NSCalendar currentCalendar] components:NSCalendarUnitDay
                                                          fromDate:saveDate
                                                            toDate:dateCheck
                                                           options:0] day];

    if (interval < 0 || interval > 0) {
        // Dates don't match lets remove cache and delete saveDate
        [self removeMenuCache];
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        //NSLog(@"dates are different");
    } else {
        // Dates are equal no need to do anything
        //NSLog(@"dates are same");
    }
}

- (void)removeMenuCache
{
//    TableViewController *tableViewController = [[TableViewController alloc] init];
//
//    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
//    
//        [[NSURLCache sharedURLCache] removeAllCachedResponses];
//
//    }
//    [[NSURLCache sharedURLCache] removeCachedResponseForDataTask:tableViewController.task];

    // Let's just remove all cache, who cares
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSLog(@"Removing cache");
}
#pragma mark - State restoration
-(BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    return YES;
}

-(BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}

@end
