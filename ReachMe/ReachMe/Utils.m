//
//  Utils.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 04/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "Utils.h"
#import "Constants.h"
@implementation Utils


+(void)setLoginContext:(NSString*)ctx {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:ctx forKey:@"ctx"];
}

+(void)setContextId:(NSString*)ctxId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:ctxId forKey:@"ctxId"];
}

+(NSString*)getLoginContext {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"ctx"] ? [defaults objectForKey:@"ctx"] : NULL;
}

+(NSString*)getContextId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"ctxId"] ? [defaults objectForKey:@"ctxId"] : NULL;
}

+(BOOL)isLoggedIn {
    return [Utils getLoginContext] ? TRUE : FALSE;
}

+(ReachMeAppDelegate*)getAppDelegate {
    ReachMeAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    return appDelegate;
}

+(UIStoryboard*)getStoryBoard{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return storyboard;
}
@end
