//
//  ReachMeDirectionsPageContentViewController.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 23/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReachMeDirectionsPageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *directionTitle;
@property (weak, nonatomic) IBOutlet UILabel *direction;
@property NSUInteger pageIndex;
@property NSString* titleText;
@property NSString* directionText;
@end
