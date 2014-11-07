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

    [self showShareView];
}

- (void)showShareView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ReachMeShareUserInfoViewController *userInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"ShareBtnsVC"];
//    UIViewController *userInfoVC = [[UIViewController alloc] init];
    
    userInfoVC.view.layer.borderWidth = 1;
    userInfoVC.view.layer.borderColor = self.view.tintColor.CGColor;
    CGFloat width = self.view.frame.size.width * .10;
    CGFloat height = self.view.frame.size.height * .20;
    CGFloat xpos = self.view.frame.size.width - width - 5;
    CGFloat ypos = 62; //uinavigationcontroller height
//    CGFloat ypos = (self.view.frame.size.height - height) / 2;
    
    userInfoVC.view.frame = CGRectMake(xpos, ypos, width, height);
    [self.view addSubview:userInfoVC.view];
}
@end
