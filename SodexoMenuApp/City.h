//
//  City.h
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 1.6.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSURL *url;

// TODO: NSDictionary *cityData = @{ @"lappeenranta":@"url_osoite",@"helsinki":@"url_osoite_hki" };

@end
