//
//  ReachMeViewController.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 04/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeViewController.h"
#import "Utils.h"
#import "Constants.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "MBProgressHUD.h"
#import "User.h"
#define PHONE_MAX_LENGTH 10
@interface ReachMeViewController ()

@end

@implementation ReachMeViewController
@synthesize appDelegate, input_phone;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.appDelegate = [UIApplication sharedApplication].delegate;
}

- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showUserInfoView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *userInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"UserInfo"];
    [self.appDelegate.window.rootViewController presentViewController:userInfoVC animated:YES completion:nil];
}

- (IBAction)registerBtn:(id)sender {
    [self registerUser];
    [self.input_phone resignFirstResponder];
}

- (void) registerUser {
    
    if([self validatePhone]){
        [self.appDelegate showLoading];
        NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeUp) userInfo:nil repeats:NO];
        
//        [self showUserInfoView];
    }
}

-(void)timeUp{
    [self showUserInfoView];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self registerUser];
    [self.input_phone resignFirstResponder];
    return YES;
}

- (BOOL)validatePhone{
    if ([self.input_phone.text length] == PHONE_MAX_LENGTH) {
        return TRUE;
    }else {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid phone number!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return FALSE;
    }
}
@end
