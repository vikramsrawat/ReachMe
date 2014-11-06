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
@property (strong, nonatomic) ReachMeAppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *addAddressBtn;
- (IBAction)addAddress:(id)sender;

- (void)editAddress;

- (void)setNavigationBarBtns;
- (void)shareAddress;

@end
