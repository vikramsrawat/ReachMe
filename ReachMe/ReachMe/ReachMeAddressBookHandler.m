//
//  ReachMeAddressBookHandler.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 14/11/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeAddressBookHandler.h"
#import "STHTTPRequest.h"
#import "Utils.h"
#import "Constants.h"
@interface ReachMeAddressBookHandler () <MFMessageComposeViewControllerDelegate,ABPeoplePickerNavigationControllerDelegate>{
    NSMutableArray * receipients;
}

@end

@implementation ReachMeAddressBookHandler

+(ReachMeAddressBookHandler*)getInstance {
    static ReachMeAddressBookHandler *instance = nil;
    if (!instance) {
        instance = [[ReachMeAddressBookHandler alloc] init];
    }
    return instance;
}

- (void)openAddressBook:(UIViewController*)vc dataToShare:(NSDictionary*)data{
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
    if(receipients == nil){
        receipients = [[NSMutableArray alloc] initWithObjects:[[NSString alloc] initWithFormat:@"%@",phone] , nil];
    }else {
        [receipients addObject:[[NSString alloc] initWithFormat:@"%@",phone]];
    }
    [self sendSMSViaServer];
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendSMSViaServer{
    [[Utils getAppDelegate] showLoading];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.dataToShare
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    STHTTPRequest *request = [STHTTPRequest requestWithURLString:actionSendSMS];
    
    [request setHeaderWithName:@"content-type" value:@"application/json; charset=utf-8"];
    
    [request setHTTPMethod:@"POST"];
    request.rawPOSTData = jsonData;
    
    
    //    request.completionDataBlock=^(NSDictionardy *headers, NSData* data){
    //        NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //        NSLog(@"resp = %@",newStr);
    //        [[Utils getAppDelegate] hideLoading];
    //        [self cancelEdit];//close the view
    //    };
    
    request.completionBlock=^(NSDictionary *headers, NSString *body) {
        NSLog(@"Body: %@", body);
        if (![body isEqualToString:@"false"]) {
            [[Utils getAppDelegate] hideLoading];
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sucess!" message:@"Message Successfully sent!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }else {
            [self showSMSWarning];
        }
        [[Utils getAppDelegate] hideLoading];
    };
    
    request.errorBlock=^(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        [[Utils getAppDelegate] hideLoading];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    };
    
    [request startAsynchronous];
}
-(void) showSMSWarning {
    //todo : inform user about charges
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"There was an error on the server. Would you like to send an SMS via carrier? Standard SMS rates will apply." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"OK", nil];
    [alert show];
}

-(void)sendSMSViaClient{
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    
    NSString *message = [NSString stringWithFormat:@"Test SMS from ReachMe"];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:receipients];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self.parentView presentViewController:messageController animated:YES completion:nil];
}

#pragma MFMessageComposeViewControllerDelegate methods
-(void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS. Please try again later!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"alert view btn index = %d", alertView.cancelButtonIndex);
    NSLog(@"btn index = %d", buttonIndex);
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        [self sendSMSViaClient];
    }
}
@end
