//
//  Factory.m
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 1.6.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import "Factory.h"
#import <AFHTTPRequestOperationManager.h>

static NSString *const FactoryUrlString = @"https://api.myjson.com/bins/1zo1h";

@implementation Factory

@synthesize cityJson;

//+ (instancetype)cityJson
//{
//    static dispatch_once_t pred;
//    static Factory *shared = nil;
//    dispatch_once(&pred, ^{
//        shared = [[Factory alloc] init];
//
//		//https://api.myjson.com/bins/1zo1h
//
//		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cityData" ofType:@"json"];
//		NSData *data = [NSData dataWithContentsOfFile:filePath];
//		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//
//		shared.cityJson = json;
//    });
//    return shared;
//}

+ (Factory *)cityJson
{
    static Factory *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		shared = [[Factory alloc] init];
		
		NSHTTPURLResponse *response = nil;
		NSString *jsonUrlString = [NSString stringWithFormat:@"http://pahnev.meximas.com/cityData.json"];
		NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		
		//-- Get request and response though URL
		NSURLRequest *request = [NSURLRequest requestWithURL:url
												 cachePolicy:NSURLRequestReloadRevalidatingCacheData
											 timeoutInterval:10.0];
		NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
		
		//-- JSON Parsing
		NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
		//NSLog(@"Result = %@",result);
		shared.cityJson = result;
    });
    return shared;
}

@end
