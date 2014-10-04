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
    [self getUser];
//    [self putUser];
}


-(void)processResponseAndShowUserInfo:(NSString*) data{
    if ([data isEqualToString:@"false"]) {
        NSLog(@"resp data : %@",data);
        return;
    }
    NSError * localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&localError];
    if(localError){
        NSLog(@"error parsing json data");
    }
    
    NSLog(@"%@",parsedObject);
}
- (void)getUser{
    NSString *url = [NSString stringWithFormat:GETUSER,@"123456",@"facebook"];
    STHTTPRequest * r = [STHTTPRequest requestWithURLString:url];
    [r setHeaderWithName:@"content-type" value:@"application/x-www-form-urlencoded; charset=utf-8"];
    [r setHTTPMethod:@"GET"];
//    r.completionDataBlock = ^(NSDictionary* headers, NSData* data) {
//      [self processResponseAndShowUserInfo:data];
//    };
    r.completionBlock=^(NSDictionary *headers, NSString *body) {
//        NSLog(@"Body: %@", body);
        [self processResponseAndShowUserInfo:body];
    };
    r.errorBlock = ^(NSError* error){
        NSLog(@"error: %@",[error localizedDescription]);
    };
    [r startAsynchronous];
}

- (void)putUser {
    NSDictionary *d = @{ @"uid":@"12345", @"name":@"vikram", @"provider":@"facebook",@"landmark":@"kidzee school",@"locality":@"kodichikanahalli",@"city":@"bangalore",@"street_address":@"kumbha lake shore, kc halli",@"phone":@"1234567890"};
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    STHTTPRequest *request = [STHTTPRequest requestWithURLString:PUTUSER];
    
    [request setHeaderWithName:@"content-type" value:@"application/json; charset=utf-8"];
    
    request.rawPOSTData = jsonData;
    [request setHTTPMethod:@"POST"];
    
    request.completionDataBlock=^(NSDictionary *headers, NSData* data){
        NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"resp = %@",newStr);
    };
    
    request.completionBlock=^(NSDictionary *headers, NSString *body) {
        NSLog(@"Body: %@", body);
    };
    
    request.errorBlock=^(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    };
    
    [request startAsynchronous];
}
- (void) viewWillAppear:(BOOL)animated{
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

- (void)editAddress {
    //[self.view addSubview:[ReachMeEditUserInfoViewController getInstance].view];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *userInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"EditUserInfo"];
    //[self.parentViewController.navigationController pushViewController:userInfoVC animated:YES];
    [self.parentViewController presentViewController:userInfoVC animated:YES completion:nil];
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
    
}

@end
