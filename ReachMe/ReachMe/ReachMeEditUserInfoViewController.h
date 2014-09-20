//
//  ReachMeEditUserInfoViewController.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 20/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReachMeEditUserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldBusiness;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;

- (void) saveAddress;
- (void) setNavigationBarBtns;
- (void) cancelEdit;
+ (ReachMeEditUserInfoViewController*) getInstance;
@end