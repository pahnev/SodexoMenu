//
//  FeedItems.m
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 31.5.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import "FeedItems.h"
#import "SessionManager.h"

@implementation FeedItems

+ (id)jsonData;
{

    SessionManager *sessionManager = [SessionManager sharedClient];

    // AFHTTPResponseSerializer *HTTPResponseSerializer = [AFJSONResponseSerializer serializer];

    // Initialize Request Operation Manager
    // AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];

    // Configure Request Operation Manager
    [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];

    // Send Request
    [sessionManager GET:@"84/2014/05/28/fi"
        parameters:nil
        success:^(NSURLSessionDataTask *task, id responseObject) {
            //NSLog(@"Success, %@", responseObject);
        }
        failure:^(NSURLSessionDataTask *task, NSError *error) { NSLog(@"Error, %@", error); }];
    return sessionManager;
}

@end
