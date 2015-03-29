//
//  City.m
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 16.2.2015.
//  Copyright (c) 2015 Kirill Pahnev. All rights reserved.
//

#import "City.h"
#import "Restaurant.h"

@implementation City {
    NSArray *restaurants;
}

-(instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.name = name;
        restaurants = [[NSArray alloc] init];
    }
    
    return self;
}

-(void)addRestaurant:(Restaurant *)restaurant
{
    restaurants = [restaurants arrayByAddingObject:restaurant];
}

@end
