//
//  ReachMeShareUserInfoViewController.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 03/11/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeShareUserInfoViewController.h"

@interface ReachMeShareUserInfoViewController ()

@end

@implementation ReachMeShareUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor clearColor];
//    self.view.opaque = NO;

    // Do any additional setup after loading the view.
//    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{self.view.frame = CGRectMake(self.view.frame.origin.x, 300, self.view.frame.size.width, self.view.frame.size.height);} completion:nil;
//    UIButton * smsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [smsBtn setBackgroundImage:[UIImage imageNamed:@"whatsapp.png"] forState:UIControlStateNormal];
//    [smsBtn setContentMode:UIViewContentModeCenter];
//    [smsBtn addTarget:self action:@selector(sendSMS) forControlEvents:UIControlEventTouchUpInside];
//    smsBtn.frame = CGRectMake(10, 10, 44, 44);
//    UIView * subview = [self.view viewWithTag:100];
//    [subview addSubview:smsBtn];
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


-(void)sendSMS{
    NSLog(@"send sms");
}
@end
