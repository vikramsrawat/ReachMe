//
//  ReachMeEditDirectionViewController.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 24/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReachMeEditDirectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *directionTitle;
@property (weak, nonatomic) IBOutlet UITextView *direction;
+(ReachMeEditDirectionViewController*)getInstance;
@property NSString* directionTitleText;
@property NSString* directionText;

- (void) setNavigationBarBtns;
@end
