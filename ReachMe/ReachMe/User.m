//
//  User.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 05/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize uid, name, first_name, last_name, age, email, phone, business, directions, address;


- (void)saveUserInfo:(NSDictionary *)userInfo{
    self.uid = [userInfo objectForKey:@"uid"];
    self.name = [userInfo objectForKey:@"name"];
    self.first_name = [userInfo objectForKey:@"first_name"];
    self.last_name = [userInfo objectForKey:@"last_name"];
    self.email = [userInfo objectForKey:@"email"];
    self.phone = [userInfo objectForKey:@"phone"];
    self.business = [userInfo objectForKey:@"business"];
    self.directions = [userInfo objectForKey:@"directions"];
    self.address = [userInfo objectForKey:@"street_address"];
}

+(User*)getInstance{
    static User* instance = nil;
    if (!instance) {
        instance = [[User alloc] init];
    }
    return instance;
}
@end
