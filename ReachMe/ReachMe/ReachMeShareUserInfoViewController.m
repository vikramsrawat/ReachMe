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
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{self.view.frame = CGRectMake(self.view.frame.origin.x, 50, self.view.frame.size.width, self.view.frame.size.height);} completion:nil];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    UIButton * whtsAppBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [whtsAppBtn setImage:[UIImage imageNamed:@"whatsapp.png"] forState:UIControlStateNormal];
    [whtsAppBtn setContentMode:UIViewContentModeCenter];
    [whtsAppBtn addTarget:self action:@selector(sendWhatsAppMesg) forControlEvents:UIControlEventTouchUpInside];
    whtsAppBtn.frame = CGRectMake((self.view.frame.size.width - 48) / 2, 10, 48, 48); //hardcoded values as of now, need to b aligned as per the view
    [self.view addSubview:whtsAppBtn];
    
    UIButton * smsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [smsBtn setImage:[UIImage imageNamed:@"sms.png"] forState:UIControlStateNormal];
    [smsBtn setContentMode:UIViewContentModeCenter];
    [smsBtn addTarget:self action:@selector(sendSMSMesg) forControlEvents:UIControlEventTouchUpInside];
    //    CGFloat xpos =
    smsBtn.frame = CGRectMake((self.view.frame.size.width - 48) / 2, 60, 48, 48); //hardcoded values as of now, need to b
    [self.view addSubview:smsBtn];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)sendWhatsAppMesg{
    NSLog(@"send whatsapp mesg");
}

-(void)sendSMSMesg{
    NSLog(@"send sms");
}
@end
