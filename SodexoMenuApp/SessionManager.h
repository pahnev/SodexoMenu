//
//  SessionManager.h
//  SodexoMenuApp
//
//  Created by Kirill Pahnev on 31.5.2014.
//  Copyright (c) 2014 Kirill Pahnev. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface SessionManager : AFHTTPSessionManager

+(instancetype)sharedClient;

@end
