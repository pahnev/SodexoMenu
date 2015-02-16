//
//  Factory.m
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 1.6.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//
//#import "MainViewController.h"
#import "Factory.h"

@implementation Factory


//+(instancetype) sharedClient
//{
//	static Factory *_sharedClient = nil;
//	static dispatch_once_t onceToken;
//	dispatch_once(&onceToken, ^{
//		_sharedClient = [[Factory alloc] init];
//		//NSLog(@"%@", _sharedClient);
//	});
//	return _sharedClient;
//}

+ (Factory *) sharedInstance
{
    static Factory *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
    
}

-(void)fetchDataInBackgroundWithCompletionHandler: (void(^)(BOOL success, NSDictionary *data, NSError *error)) block
{
    NSString * baseURL = @"https://raw.githubusercontent.com/pahnev/SodexoMenu/master/SodexoMenuApp/cityData.json";
    AFHTTPRequestOperationManager * manager = [[AFHTTPRequestOperationManager alloc] init];
    
    __weak AFHTTPRequestOperationManager *weakManager = manager;
    weakManager.responseSerializer = [AFJSONResponseSerializer serializer];
    weakManager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];

    
    NSOperationQueue *operationQueue = manager.operationQueue;
    [weakManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status ==  AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"internet!");
            [weakManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringCacheData];
            [operationQueue setSuspended:NO];
            
            [manager GET:baseURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                    
                    block(YES, responseObject, nil);
                    
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) { // invalid request.
                NSLog(@"%@", error.localizedDescription);
                block(YES, nil, error);
            }];
            
            
        } else if (status == AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"no internet");
            [weakManager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
            [operationQueue setSuspended:YES];
            
        }
        
    }];
    
    [weakManager.reachabilityManager startMonitoring];
    
    
    [weakManager GET:baseURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            block(YES, responseObject, nil);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) { // invalid request.
        NSLog(@"%@", error.localizedDescription);
        block(YES, nil, error);
    }];
    
}

@end

