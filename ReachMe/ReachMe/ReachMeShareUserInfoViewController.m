//
//  ReachMeShareUserInfoViewController.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 03/11/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeShareUserInfoViewController.h"
#import "Constants.h"
@interface ReachMeShareUserInfoView ()

@end

@implementation ReachMeShareUserInfoView


-(void)didMoveToSuperview {
    UIButton * whtsAppBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [whtsAppBtn setImage:[UIImage imageNamed:@"whatsapp.png"] forState:UIControlStateNormal];
    [whtsAppBtn addTarget:self action:@selector(sendWhatsAppMesg) forControlEvents:UIControlEventTouchUpInside];
    [whtsAppBtn setContentMode:UIViewContentModeCenter];
    whtsAppBtn.frame = CGRectMake((self.frame.size.width - SOCIAL_BTN_WIDTH) / 2, WHATSAPP_BTN_XPOS, SOCIAL_BTN_WIDTH, SOCIAL_BTN_HEIGHT); //hardcoded values as of now, need to b aligned as per the view
    [self addSubview:whtsAppBtn];
    
    UIButton * smsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [smsBtn setImage:[UIImage imageNamed:@"sms.png"] forState:UIControlStateNormal];
    [smsBtn addTarget:self action:@selector(sendSMSMesg) forControlEvents:UIControlEventTouchUpInside];
    [smsBtn setContentMode:UIViewContentModeCenter];
    
    //    CGFloat xpos =
    smsBtn.frame = CGRectMake((self.frame.size.width - SOCIAL_BTN_WIDTH) / 2, WHATSAPP_BTN_XPOS + SOCIAL_BTNS_MARGIN + SOCIAL_BTN_HEIGHT, SOCIAL_BTN_WIDTH, SOCIAL_BTN_HEIGHT); //hardcoded values as of now, need to b
    [self addSubview:smsBtn];
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
