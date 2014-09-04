//
//  Utils.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 04/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(void)setLoginContext:(NSString*)ctx;
+(void)setContextId:(NSString*)ctxId;
+(NSString*)getLoginContext;
+(NSString*)getContextId;

@end
