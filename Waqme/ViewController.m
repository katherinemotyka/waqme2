

#import "ViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "AppDelegate.h"



@interface ViewController ()
{
    AppDelegate *appDelegate;
    bool isLogin;
}
@end

@implementation ViewController
@synthesize txtPassword,txtUsername;

- (void)viewDidLoad
{
    // self.lblPassword.font = [UIFont fontWithName:@"Neue light" size:15];
    // self.lblUsename.font = [UIFont fontWithName:@"Neue light" size:15];
    // self.btnForgotPassword.titleLabel.font = [UIFont fontWithName:@"Neue light" size:12];
    // self.btnLogin.titleLabel.font = [UIFont fontWithName:@"Neue light" size:15];
    //  self.lblSignIn.font = [UIFont fontWithName:@"Neue light" size:15];
    
    [super viewDidLoad];
    appDelegate = [AppDelegate sharedDalegate];
    appDelegate.session = [[FBSession alloc] init];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)onClickForgotPassword:(id)sender {
}

- (IBAction)onClickLogin:(id)sender {
        [appDelegate tabBarControllerView];
    
//    if(self.txtUsername.text.length == 0 ||  txtPassword.text.length == 0){
//        [appDelegate showAlert:@"Alert" message:@"Must have entered username and password"];
//    }else if(![self validateEmailWithString:txtUsername.text]){
//        [appDelegate showAlert:@"Alert" message:@"Please enter valid email address"];
//    }else {
//        [self.txtPassword resignFirstResponder];
//        [self.txtUsername resignFirstResponder];
//        
//        [appDelegate tabBarControllerView];
//    }
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - Button handler

- (void)buttonTabPressed:(id)sender {
    NSLog(@"Button %@ has been pressed in tabView", sender);
}


- (IBAction)onClickTwitter:(id)sender {
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) // check Twitter is configured in Settings or not
    {
        ACAccountType *twitterAcc = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        [appDelegate tabBarControllerView];
        
        [accountStore requestAccessToAccountsWithType:twitterAcc options:nil completion:^(BOOL granted, NSError *error)
         {
             if (granted)
             {
                 NSArray *accounts = [accountStore accountsWithAccountType:accountType];
                 // Check if the users has setup at least one Twitter account
                 if (accounts.count > 0)
                 {
                     ACAccount *twitterAccount = [accounts objectAtIndex:0];
                     
                     twitterAccount = [[accountStore accountsWithAccountType:twitterAcc] lastObject];
                     
                     NSLog(@"Twitter UserName: %@, FullName: %@", twitterAccount.username, twitterAccount.userFullName);
                     
                     [appDelegate.dictUserInfo setValue:twitterAccount.username forKeyPath:@"username"];
                     [appDelegate.dictUserInfo setValue:twitterAccount.userFullName forKeyPath:@"userFullname"];
                   
                     isLogin = TRUE;
                     
                 }else{}
             }else
             {
                 if (error == nil) {
                     NSLog(@"User Has disabled your app from settings...");
                 }
                 else
                 {
                     NSLog(@"Error in Login: %@", error);
                 }
             }
         }];
        
        
        
    } else
    {
        UIAlertView *alertViewTwitter = [[UIAlertView alloc]
                                         initWithTitle:@"No Twitter Accounts"
                                         message:@"There are no Twitter accounts configured in this device. You can add or create a Twitter account in Settings."
                                         delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil] ;
        
        [alertViewTwitter show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

- (IBAction)onClickFacebook:(id)sender {
//    if (FBSession.activeSession.state == FBSessionStateOpen
//        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
//        
//        [FBSession.activeSession closeAndClearTokenInformation];
//        
//        // If the session state is not any of the two "open" states when the button is clicked
//    } else {
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile",@"email"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             [appDelegate sessionStateChanged:session state:state error:error];
         }];
  //  }
}

-(void)onClickSignUp:(id)sender{
    
}

@end
