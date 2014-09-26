//
//  SessionManager.m
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 31.5.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import "SessionManager.h"

static NSString *const SessionManagerBaseUrlString = @"http://www.sodexo.fi/ruokalistat/output/daily_json/";

@implementation SessionManager

+(instancetype) sharedClient
{
	static SessionManager *_sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedClient = [[SessionManager alloc] initWithBaseURL:[NSURL URLWithString:SessionManagerBaseUrlString]];
		//NSLog(@"%@", _sharedClient);
	});
	return _sharedClient;
}


@end
