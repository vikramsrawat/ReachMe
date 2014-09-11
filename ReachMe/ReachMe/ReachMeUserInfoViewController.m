//
//  ReachMeUserInfoViewController.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 04/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeUserInfoViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ReachMeUserInfoViewController ()

@end

@implementation ReachMeUserInfoViewController
@synthesize appDelegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appDelegate = [UIApplication sharedApplication].delegate;
    [self.appDelegate hideLoading];
    
    
    //To make the border look very close to a UITextField
    [_addressTextView.layer setBorderColor:[[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_addressTextView.layer setBorderWidth:.5];
    
    //The rounded corner part, where you specify your view's corner radius:
    _addressTextView.layer.cornerRadius = 5;
    _addressTextView.clipsToBounds = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
