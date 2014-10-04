//
//  ReachMeAppDelegate.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 04/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface ReachMeAppDelegate : UIResponder <UIApplicationDelegate>

-(void)showLoading;
-(void)hideLoading;
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) MBProgressHUD *loading;
@property (weak, nonatomic) NSString *loginSelected;
@end
