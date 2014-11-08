//
//  ReachMeShareUserInfoViewController.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 03/11/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeShareUserInfoViewController.h"
#import "Constants.h"
@interface ReachMeShareUserInfoViewController ()

@end

@implementation ReachMeShareUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor clearColor];
//    self.view.opaque = NO;

    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self addBtns];
}

-(void)addBtns{
    UIButton * whtsAppBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [whtsAppBtn setImage:[UIImage imageNamed:@"whatsapp.png"] forState:UIControlStateNormal];
    [whtsAppBtn addTarget:self action:@selector(sendWhatsAppMesg) forControlEvents:UIControlEventTouchUpInside];
    [whtsAppBtn setContentMode:UIViewContentModeCenter];
    whtsAppBtn.frame = CGRectMake((self.view.frame.size.width - SOCIAL_BTN_WIDTH) / 2, WHATSAPP_BTN_XPOS, SOCIAL_BTN_WIDTH, SOCIAL_BTN_HEIGHT); //hardcoded values as of now, need to b aligned as per the view
    [self.view addSubview:whtsAppBtn];
    
    UIButton * smsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [smsBtn setImage:[UIImage imageNamed:@"sms.png"] forState:UIControlStateNormal];
    [smsBtn addTarget:self action:@selector(sendSMSMesg) forControlEvents:UIControlEventTouchUpInside];
    [smsBtn setContentMode:UIViewContentModeCenter];
    
    //    CGFloat xpos =
    smsBtn.frame = CGRectMake((self.view.frame.size.width - SOCIAL_BTN_WIDTH) / 2, WHATSAPP_BTN_XPOS + SOCIAL_BTNS_MARGIN + SOCIAL_BTN_HEIGHT, SOCIAL_BTN_WIDTH, SOCIAL_BTN_HEIGHT); //hardcoded values as of now, need to b
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
