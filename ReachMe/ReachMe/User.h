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
@property (weak,nonatomic) NSString *uid;
@property (weak,nonatomic) NSString *name;
@property (weak,nonatomic) NSString *first_name;
@property (weak,nonatomic) NSString *last_name;
@property (weak,nonatomic) NSString *email;
@property (weak,nonatomic) NSString *age;
@property (weak,nonatomic) NSString *phone;
@property (weak,nonatomic) NSString *business;
@property (weak,nonatomic) NSString *address;
@property (strong, nonatomic) NSMutableDictionary *directions;
@property (weak,nonatomic) NSDictionary *userInfo;
-(void)saveUserInfo:(NSDictionary*) userInfo;
+(User*)getInstance;
@end
