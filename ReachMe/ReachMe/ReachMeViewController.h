//
//  ReachMeViewController.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 04/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReachMeAppDelegate.h"
@interface ReachMeViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) ReachMeAppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextField *input_phone;
- (IBAction)registerBtn:(id)sender;
@end
