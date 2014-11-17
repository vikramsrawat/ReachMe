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
#import <GooglePlus/GooglePlus.h>
@interface ReachMeViewController : UIViewController<UITextFieldDelegate,FBLoginViewDelegate,GPPSignInDelegate>

@property (strong, nonatomic) ReachMeAppDelegate *appDelegate;
- (IBAction)loginToFB:(id)sender;
- (IBAction)loginToGPlus:(id)sender;

-(void)processResponseAndShowUserInfo:(NSString*) data;
@end
