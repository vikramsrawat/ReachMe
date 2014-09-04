//
//  ReachMeViewController.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 04/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReachMeAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
@interface ReachMeViewController : UIViewController <FBLoginViewDelegate>

@property (strong, nonatomic) ReachMeAppDelegate *appDelegate;
@end
