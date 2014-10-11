//
//  ReachMeDirectionsViewController.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 23/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReachMeDirectionsViewController : UIViewController <UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray* directions;
@property NSInteger currentPageIndex;
@property (weak, nonatomic) IBOutlet UIButton *addNewDirection;

- (IBAction)addNewDirection:(id)sender;
- (IBAction)removeDirection:(id)sender;

- (void)addDirection:(NSNotification*)notification;
@end
