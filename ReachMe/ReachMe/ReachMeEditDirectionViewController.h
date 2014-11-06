//
//  ReachMeEditDirectionViewController.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 24/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import <UIKit/UIKit.h>
static const int ADD = 0;
static const int EDIT = 1;
@interface ReachMeEditDirectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *directionTitle;
@property (weak, nonatomic) IBOutlet UITextView *direction;
+(ReachMeEditDirectionViewController*)getInstance;
@property NSString* directionTitleText;
@property NSString* directionText;
@property int mode; // edit or add mode

- (void) setNavigationBarBtns;
@end
