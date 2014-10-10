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
//    self.textFieldBusiness.text = [User getInstance].business;
    self.addressTextView.text = [User getInstance].address ? [User getInstance].address : self.addressTextView.text;
    self.addressTextView.delegate = self;
    
    [_addressTextView.layer setBorderColor:[[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_addressTextView.layer setBorderWidth:.5];
    
    //The rounded corner part, where you specify your view's corner radius:
    _addressTextView.layer.cornerRadius = 5;
    _addressTextView.clipsToBounds = YES;
    [self setNavigationBarBtns];
}

- (void)viewWillAppear:(BOOL)animated{
    //To make the border look very close to a UITextField
    
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
    
    NSMutableDictionary * direction = [[NSMutableDictionary alloc] init];
    [direction setObject:@"via bommanahalli" forKey:@"label"];
    [direction setObject:@"reach bommanahalli and take right turn" forKey:@"text"];
    
    NSMutableDictionary * direction2 = [[NSMutableDictionary alloc] init];
    [direction2 setObject:@"via B.G. Road" forKey:@"label"];
    [direction2 setObject:@"reach IIM bangalore and take left turn" forKey:@"text"];
    
    
    NSMutableArray * directions = [[NSMutableArray alloc] init];
    [directions addObject:direction];
    [directions addObject:direction2];
    
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"123456" forKey:@"uid"];
    [dict setObject:@"facebook" forKey:@"provider"];
    [dict setObject:@"vikram singh" forKey:@"name"];
    [dict setObject:@"1234567890" forKey:@"phone"];
    [dict setObject:@"kidzee school" forKey:@"landmark"];
    [dict setObject:@"kodichikanahalli" forKey:@"locality"];
    [dict setObject:@"bangalore" forKey:@"city"];
    [dict setObject:@"kumbha lake shore, kc halli" forKey:@"street_address"];
    [dict setObject:directions forKey:@"directions"];
    
    NSLog(@"%@", dict);
    [[Utils getAppDelegate] showLoading];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    __block STHTTPRequest *request = [STHTTPRequest requestWithURLString:PUTUSER];
    
    [request setHeaderWithName:@"content-type" value:@"application/json; charset=utf-8"];
    
    [request setHTTPMethod:@"POST"];
    request.rawPOSTData = jsonData;
    
    
//    request.completionDataBlock=^(NSDictionary *headers, NSData* data){
//        NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"resp = %@",newStr);
//        [[Utils getAppDelegate] hideLoading];
//        [self cancelEdit];//close the view
//    };
    
    request.completionBlock=^(NSDictionary *headers, NSString *body) {
        NSLog(@"Body: %@", body);
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
