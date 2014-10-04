//
//  ReachMeViewController.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 04/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeViewController.h"
#import "Utils.h"
#import "Constants.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "MBProgressHUD.h"
#import "User.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#define PHONE_MAX_LENGTH 10
@interface ReachMeViewController ()
@property (strong, nonatomic) GPPSignIn *signIn;
@end

@implementation ReachMeViewController
@synthesize appDelegate, input_phone;
static NSString * const kClientId = @"130182801305-tei60s241j8u1nnqg2fqqi8jj7nfktii.apps.googleusercontent.com";
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.appDelegate = [UIApplication sharedApplication].delegate;
    
    {
        self.signIn = [GPPSignIn sharedInstance];
        self.signIn.shouldFetchGooglePlusUser = YES;
        self.signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
        self.signIn.shouldFetchGoogleUserID = YES;
        // You previously set kClientId in the "Initialize the Google+ client" step
        self.signIn.clientID = kClientId;
        
        // Uncomment one of these two statements for the scope you chose in the previous step
        self.signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
        self.signIn.scopes = @[ @"profile" ];            // "profile" scope
        
        // Optional: declare signIn.actions, see "app activities"
        self.signIn.delegate = self;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    NSString *loginCtx = [Utils getLoginContext];
    if ([loginCtx isEqualToString:FB]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
            
            // If there's one, just open the session silently, without showing the user the login UI
            [self openFBSession:YES];
        }
        
    }else if ([loginCtx isEqualToString:GPLUS]){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.signIn trySilentAuthentication];
    }
    else {
        //        [self loginToFB:nil];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showUserInfoView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *userInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"TabsView"];
//    [self.appDelegate.window.rootViewController presentViewController:userInfoVC animated:YES completion:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:userInfoVC];
    userInfoVC.navigationItem.title = @"Address";
    [self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)registerBtn:(id)sender {
    [self registerUser];
    [self.input_phone resignFirstResponder];
}

- (void) registerUser {
    
    if([self validatePhone]){
        [self.appDelegate showLoading];
//        NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeUp) userInfo:nil repeats:NO];
        
//        [self showUserInfoView];
    }
}

-(void)timeUp{
    [self showUserInfoView];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self registerUser];
    [self.input_phone resignFirstResponder];
    return YES;
}

- (BOOL)validatePhone{
    if ([self.input_phone.text length] == PHONE_MAX_LENGTH) {
        return TRUE;
    }else {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid phone number!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return FALSE;
    }
}
- (IBAction)loginToFB:(id)sender {
    [Utils setLoginContext:FB];
    [self.appDelegate showLoading];
    {
        // If the session state is any of the two "open" states when the button is clicked
        if (FBSession.activeSession.state == FBSessionStateOpen
            || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
            
            // Close the session and remove the access token from the cache
            // The session state handler (in the app delegate) will be called automatically
            [FBSession.activeSession closeAndClearTokenInformation];
            [self.appDelegate hideLoading];
            // If the session state is not any of the two "open" states when the button is clicked
        } else {
            // Open a session showing the user the login UI
            // You must ALWAYS ask for public_profile permissions when opening a session
            [self openFBSession:YES];
        }
    }

}

- (void)openFBSession:(BOOL)showLogin{
    [FBSession openActiveSessionWithReadPermissions:@[@"public_profile,email"]
                                       allowLoginUI:showLogin
                                  completionHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {
         
         // Retrieve the app delegate
         
         // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
         [self sessionStateChanged:session state:state error:error];
     }];

}
- (IBAction)loginToGPlus:(id)sender {
    [Utils setLoginContext:GPLUS];
    [self.appDelegate showLoading];
    [self.signIn authenticate];
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                                               id<FBGraphUser> user,
                                                               NSError *error2) {
            
            NSLog(@"user = %@",user);
            [Utils setLoginContext:FB];
            [Utils setContextId:user.objectID];
            [self showUserInfoView];
            return;
            
        }];
         return;
         }
         if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
             // If the session is closed
             NSLog(@"Session closed");
             // Show the user the logged-out UI
//             [self userLoggedOut];
         }
         
         // Handle errors
         if (error){
             NSLog(@"Error");
             NSString *alertText;
             NSString *alertTitle;
             // If the error requires people using an app to make an action outside of the app in order to recover
             if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
                 alertTitle = @"Something went wrong";
                 alertText = [FBErrorUtility userMessageForError:error];
//                 [self showMessage:alertText withTitle:alertTitle];
             } else {
                 
                 // If the user cancelled login, do nothing
                 if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                     NSLog(@"User cancelled login");
                     
                     // Handle session closures that happen outside of the app
                 } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                     alertTitle = @"Session Error";
                     alertText = @"Your current session is no longer valid. Please log in again.";
//                     [self showMessage:alertText withTitle:alertTitle];
                     
                     // Here we will handle all other errors with a generic error message.
                     // We recommend you check our Handling Errors guide for more information
                     // https://developers.facebook.com/docs/ios/errors/
                 } else {
                     //Get more error information from the error
                     NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                     
                     // Show the user an error message
                     alertTitle = @"Something went wrong";
                     alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
//                     [self showMessage:alertText withTitle:alertTitle];
                 }
             }
             // Clear this token
             [FBSession.activeSession closeAndClearTokenInformation];
             // Show the user the logged-out UI
//             [self userLoggedOut];
         }
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error {
//    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (!error) {
        NSLog(@"id = %@", self.signIn.userID);
        NSLog(@"email = %@", self.signIn.userEmail);
        [Utils setContextId:self.signIn.userID];
        [self showUserInfoView];
    }else {
        
    }
}
@end
