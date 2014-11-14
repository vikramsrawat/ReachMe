//
//  ReachMeAddressBookHandler.h
//  ReachMe
//
//  Created by Vikram Singh Rawat on 14/11/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
@interface ReachMeAddressBookHandler : NSObject  <ABPeoplePickerNavigationControllerDelegate, MFMessageComposeViewControllerDelegate>
@property (strong, nonatomic) ABPeoplePickerNavigationController *picker;
@property (strong, nonatomic) NSString *dataToShare;
@property (strong, nonatomic) UIViewController * parentView;

+(ReachMeAddressBookHandler*)getInstance;
-(void)openAddressBook:(UIViewController*)vc dataToShare:(NSString*)data;
@end
