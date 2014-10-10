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
    [self.addAddressBtn setHidden:YES];
    [self.addressLabel setHidden:YES];
    if(![User getInstance].address){
        [self.addAddressBtn setHidden:NO];
    }else {
        [self.addressLabel setHidden:NO];
    }
    [self setNavigationBarBtns];
    self.nameLabel.text = [User getInstance].name;
    self.emailLabel.text = [User getInstance].email;
    self.addressLabel.text = [User getInstance].address;
}

- (void)viewWillAppear:(BOOL)animated{
    
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
    //[self.view addSubview:[ReachMeEditUserInfoViewController getInstance].view];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *userInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"EditUserInfo"];
    [self.parentViewController.navigationController pushViewController:userInfoVC animated:YES];
//    [self.parentViewController presentViewController:userInfoVC animated:YES completion:nil];
}
- (void)setNavigationBarBtns {
//    UIViewController* vc = self.appDelegate.window.rootViewController;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAddress)];
    self.parentViewController.navigationItem.leftBarButtonItem = leftBtn;
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(shareAddress)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAddress)];
    self.parentViewController.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)shareAddress {
    NSString *message = @"Whats app";
    UIImage *image = [UIImage imageNamed:@"whatsapp.png"];
    NSArray *arrayOfActivityItems = [NSArray arrayWithObjects:message, image, nil];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:arrayOfActivityItems applicationActivities:nil];
    
    [self.navigationController presentViewController:activityVC animated:YES completion:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact,
                                                 UIActivityTypePrint,
                                                 UIActivityTypeAddToReadingList,
                                                 UIActivityTypeAirDrop,
                                                 UIActivityTypeCopyToPasteboard,
                                                 UIActivityTypePostToFacebook,UIActivityTypePostToFlickr];
}

@end
