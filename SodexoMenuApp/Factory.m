//
//  Factory.m
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 1.6.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import "Factory.h"

@implementation Factory

@synthesize cityJson;

+ (Factory *)cityJson
{
    static dispatch_once_t pred;
    static Factory *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[Factory alloc] init];
		
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cityData" ofType:@"json"];
		NSData *data = [NSData dataWithContentsOfFile:filePath];
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
		
		shared.cityJson = json;
    });
    return shared;
}
@end
