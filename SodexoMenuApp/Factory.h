//
//  Factory.h
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 1.6.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Factory : AFHTTPSessionManager

+ (Factory *)sharedInstance;

- (void)fetchDataInBackgroundWithCompletionHandler:(void (^)(BOOL success, NSDictionary *data, NSError *error))block;

@end
