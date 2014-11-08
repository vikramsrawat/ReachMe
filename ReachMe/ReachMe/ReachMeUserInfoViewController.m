//
//  ReachMeUserInfoViewController.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 04/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeUserInfoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Utils.h"
#import "ReachMeEditUserInfoViewController.h"
#import "STHTTPRequest.h"
#import "Constants.h"
#import "User.h"
#import "JBWhatsAppActivity.h"
#import "ReachMeShareUserInfoViewController.h"
@interface ReachMeUserInfoViewController ()

@end

@implementation ReachMeUserInfoViewController
@synthesize appDelegate, navItem;
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
    self.appDelegate = [Utils getAppDelegate];
    self.showShareView = NO;
    [self.appDelegate hideLoading];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.addAddressBtn setHidden:YES];
    [self.addressLabel setHidden:YES];
    if(![User getInstance].address){
        [self.addAddressBtn setHidden:NO];
    }else {
        [self.addressLabel setHidden:NO];
    }
    self.nameLabel.text = [User getInstance].name;
    self.emailLabel.text = [User getInstance].email;
    self.addressLabel.text = [User getInstance].address;
    self.phoneLabel.text = [User getInstance].phone;
    [self setNavigationBarBtns];
}

-(void)sendWhatsAppMesg{
    NSLog(@"sendWhatsAppMesg");
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

- (IBAction)addAddress:(id)sender {
    [self editAddress];
}

- (void)editAddress {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *userInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"EditUserInfo"];
    [self.parentViewController.navigationController pushViewController:userInfoVC animated:YES];
}
- (void)setNavigationBarBtns {
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAddress)];
    self.parentViewController.navigationItem.leftBarButtonItem = leftBtn;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAddress)];
    self.parentViewController.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)shareAddress {
    self.showShareView = !self.showShareView;
    [self toggleShareView:self.showShareView];
}

- (void)toggleShareView:(BOOL)show{
    
    if (!self.userInfoVC) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.userInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"ShareBtnsVC"];
        //    UIViewController *userInfoVC = [[UIViewController alloc] init];
        
        self.userInfoVC.view.layer.borderWidth = 1;
        self.userInfoVC.view.layer.borderColor = self.view.tintColor.CGColor;
        CGFloat width = self.view.frame.size.width * .10;
        CGFloat height = self.view.frame.size.height * .20;
        CGFloat xpos = self.view.frame.size.width - width - 5;
        CGFloat ypos = - NAVIGATIONBAR_HEIGHT - self.userInfoVC.view.frame.size.height; //uinavigationcontroller height
        //    CGFloat ypos = (self.view.frame.size.height - height) / 2;
        
        self.userInfoVC.view.frame = CGRectMake(xpos, ypos, width, height);
        [self.view addSubview:self.userInfoVC.view];
    }
    NSLog(@"%d",show);
    [UIView animateKeyframesWithDuration:0.25f delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        CGRect frame = self.userInfoVC.view.frame;
        self.userInfoVC.view.frame = CGRectMake(frame.origin.x, frame.size.height * (show ? 1 : -1) + (show ? NAVIGATIONBAR_HEIGHT : -NAVIGATIONBAR_HEIGHT), frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        if(!show) {
            [self.userInfoVC.view removeFromSuperview];
            self.userInfoVC = nil;
        }
    }];
//    if (show) {
//        [self viewSlideDown];
//    }else {
//        [self viewSlideUp];
//    }
    
}

-(void)viewSlideDown{
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        self.userInfoVC.view.frame = CGRectMake(self.userInfoVC.view.frame.origin.x, NAVIGATIONBAR_HEIGHT - 1, self.userInfoVC.view.frame.size.width, self.userInfoVC.view.frame.size.height);
    } completion:nil];
}

-(void)viewSlideUp{
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{self.userInfoVC.view.frame = CGRectMake(self.userInfoVC.view.frame.origin.x, -10, self.userInfoVC.view.frame.size.width, self.userInfoVC.view.frame.size.height);} completion:nil];
}
@end
