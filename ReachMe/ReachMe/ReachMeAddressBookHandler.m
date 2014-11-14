//
//  ReachMeAddressBookHandler.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 14/11/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeAddressBookHandler.h"

@implementation ReachMeAddressBookHandler

+(ReachMeAddressBookHandler*)getInstance {
    static ReachMeAddressBookHandler *instance = nil;
    if (!instance) {
        instance = [[ReachMeAddressBookHandler alloc] init];
    }
    return instance;
}

- (void)openAddressBook:(UIViewController*)vc dataToShare:(NSString*)data{
    self.parentView = vc;
    self.dataToShare = data;
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self.parentView presentViewController:picker animated:YES completion:nil];
}
#pragma ABPeoplePickerNavigationControllerDelegate methods
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{
    NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                    kABPersonFirstNameProperty);
    NSLog(@"Name %@",name);
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
    
    NSLog(@"Phone %@",phone);
//    if(receipients == nil){
//        receipients = [[NSMutableArray alloc] initWithObjects:[[NSString alloc] initWithFormat:@"%@",phone] , nil];
//    }else {
//        [receipients addObject:[[NSString alloc] initWithFormat:@"%@",phone]];
//    }
//    [self shareViaSMS];
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma MFMessageComposeViewControllerDelegate methods
-(void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self.parentView dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendSMS{
    
}
@end
