//
//  Factory.m
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 1.6.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import "Factory.h"
#import <AFHTTPRequestOperationManager.h>

@implementation Factory

@synthesize cityJson;

+ (Factory *)cityJson
{
    static Factory *shared = nil;
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    shared = [[Factory alloc] init];

    NSHTTPURLResponse *response = nil;
    NSString *jsonUrlString = [NSString stringWithFormat:@"http://pahnev.netii.net/cityData.json"];
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSError *error = nil;

    //-- Get request and response though URL
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                         timeoutInterval:10.0];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        NSString *errorString = [NSString stringWithFormat:@"%@",
                                                           [error localizedDescription]];
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Oh no! Something went wrong!", nil)
                                                     message:NSLocalizedString(errorString, nil)
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
        [av show];

    } else {
        //-- JSON Parsing
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        //NSLog(@"Result = %@",result);
        shared.cityJson = result;
    }

    return shared;
}

@end
