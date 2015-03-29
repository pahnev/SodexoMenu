//
//  City.h
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 16.2.2015.
//  Copyright (c) 2015 Kirill Pahnev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (strong, nonatomic) NSString *name;

-(instancetype)initWithName:(NSString *)name;

@end
