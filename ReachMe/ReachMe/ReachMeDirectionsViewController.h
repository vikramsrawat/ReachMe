//
//  ReachMeDirectionsViewController.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 23/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReachMeDirectionsViewController : UIViewController <UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray* directions;
@end
