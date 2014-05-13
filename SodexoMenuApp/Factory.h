//
//  Factory.h
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 1.6.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject
{
	NSDictionary *cityJson;
}
@property (nonatomic, retain) NSDictionary *cityJson;

+(Factory *)cityJson;


@end
