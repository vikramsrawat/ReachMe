//
//  ReachMeEditUserInfoViewController.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 20/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeEditUserInfoViewController.h"
#import "Utils.h"
#import "User.h"
#import "STHTTPRequest.h"
#import "Constants.h"
@interface ReachMeEditUserInfoViewController ()

@end

@implementation ReachMeEditUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textFieldName.text = [User getInstance].name;
    self.textFieldEmail.text = [User getInstance].email;
    self.textFieldPhone.text = [User getInstance].phone ? [User getInstance].phone : self.textFieldPhone.text;
//    self.textFieldBusiness.text = [User getInstance].business;
    self.addressTextView.text = [User getInstance].address ? [User getInstance].address : self.addressTextView.text;
    self.addressTextView.delegate = self;
    
    [_addressTextView.layer setBorderColor:[[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_addressTextView.layer setBorderWidth:.5];
    
    //The rounded corner part, where you specify your view's corner radius:
    _addressTextView.layer.cornerRadius = 5;
    _addressTextView.clipsToBounds = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    //To make the border look very close to a UITextField
    [self setNavigationBarBtns];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"Address"]) {
        textView.text = nil;
    }
    return YES;
}


+ (ReachMeEditUserInfoViewController*) getInstance{
    static ReachMeEditUserInfoViewController * instance = nil;
    if (instance == nil) {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        instance = [storyboard instantiateViewControllerWithIdentifier:@"EditUserInfo"];
    }
    return instance;
}
- (void) saveAddress{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:[User getInstance].uid forKey:@"uid"];
    [userInfo setObject:self.textFieldName.text forKey:@"name"];
    [userInfo setObject:self.textFieldEmail.text forKey:@"email"];
    [userInfo setObject:self.textFieldPhone.text forKey:@"phone"];
    [userInfo setObject:self.addressTextView.text forKey:@"address"];
    [self putUser:userInfo];
}

- (void) cancelEdit{
//    [self dismissViewControllerAnimated:YES completion:nil]; //if view is presented
    //if pushed
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setNavigationBarBtns{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit)];
//    self.navItem.leftBarButtonItem = leftBtn; //if using this view's navitem
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAddress)];
    //    self.navItem.rightBarButtonItem = rightBtn;//if using this view's navitem
    self.navigationItem.rightBarButtonItem = rightBtn;

}

- (void)putUser:(NSDictionary*)userInfo {
    
    
    
    
    [[Utils getAppDelegate] showLoading];
    return;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    STHTTPRequest *request = [STHTTPRequest requestWithURLString:PUTUSER];
    
    [request setHeaderWithName:@"content-type" value:@"application/json; charset=utf-8"];
    
    [request setHTTPMethod:@"POST"];
    request.rawPOSTData = jsonData;
    
    
//    request.completionDataBlock=^(NSDictionardy *headers, NSData* data){
//        NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"resp = %@",newStr);
//        [[Utils getAppDelegate] hideLoading];
//        [self cancelEdit];//close the view
//    };
    
    request.completionBlock=^(NSDictionary *headers, NSString *body) {
        NSLog(@"Body: %@", body);
        if (![body isEqualToString:@"false"]) {
            NSDictionary * dict = [NSDictionary dictionaryWithObject:body forKey:@"uid"];
            [[User getInstance] saveUserInfo:dict];
        }
        [[Utils getAppDelegate] hideLoading];
        [self cancelEdit];
    };
    
    request.errorBlock=^(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        [[Utils getAppDelegate] hideLoading];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    };
    
    [request startAsynchronous];
}


@end
