//
//  FeedItems.h
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 31.5.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedItems : NSObject

@property(strong, nonatomic) NSArray *data;
@property(strong, nonatomic) NSArray *locationName;

+ (id)jsonData;

@end
