//
//  ReachMeUserInfoViewController.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 04/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReachMeAppDelegate.h"
@interface ReachMeUserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (strong, nonatomic) ReachMeAppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

- (void)editAddress;

@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldBusiness;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;

- (void)enableEditMode;
- (void)disableEditMode;
- (void)shareAddress;
- (void)saveAddress;
@end
