//
//  User.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 05/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import <Foundation/Foundation.h>

//user = {
//    email = "vikram.s.rawat@gmail.com";
//    "first_name" = Vikram;
//    gender = male;
//    id = 10202637671477566;
//    "last_name" = Singh;
//    link = "https://www.facebook.com/app_scoped_user_id/10202637671477566/";
//    locale = "en_US";
//    name = "Vikram Singh";
//    timezone = "5.5";
//    "updated_time" = "2014-08-07T19:37:38+0000";
//    verified = 1;
//}

@interface User : NSObject
@property (strong,nonatomic) NSString *uid;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *first_name;
@property (strong,nonatomic) NSString *last_name;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *age;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *business;
@property (strong,nonatomic) NSString *address;
@property (strong, nonatomic) NSMutableDictionary *directions;
@property (strong,nonatomic) NSDictionary *userInfo;
-(void)saveUserInfo:(NSDictionary*) userInfo;
+(User*)getInstance;
@end
