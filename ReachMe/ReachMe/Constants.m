//
//  Constants.m
//  MOH
//
//  Created by Vikram Singh Rawat on 01/06/14.
//  Copyright (c) 2014 MOH. All rights reserved.
//

#import "Constants.h"

@implementation Constants
NSString *const actionSendSMS = @"http://localhost/reachme/test.php?action=sendSMS";
NSString *const whatsAppURL = @"whatsapp://send?text=";
NSString *const FB = @"facebook";
NSString *const GPLUS = @"google";
NSString *const PUTUSER = @"http://www.intruo.com/putUser";
NSString *const GETUSER = @"http://www.intruo.com/getUser?uid=%@&provider=%@";
int const SOCIAL_BTN_WIDTH = 48;
int const SOCIAL_BTN_HEIGHT = 48;
int const SOCIAL_BTNS_MARGIN = 2;
int const WHATSAPP_BTN_XPOS = 10;
int const NAVIGATIONBAR_HEIGHT = 64;
@end
