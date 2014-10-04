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
    
    [self cancelEdit];
}

- (void) cancelEdit{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) setNavigationBarBtns{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit)];
    self.navItem.leftBarButtonItem = leftBtn;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAddress)];
    self.navItem.rightBarButtonItem = rightBtn;
}


@end
