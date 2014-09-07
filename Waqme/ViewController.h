

#import <UIKit/UIKit.h>




@interface ViewController : UIViewController <UITextFieldDelegate>
{
   
   
}
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblUsename;
@property (weak, nonatomic) IBOutlet UILabel *lblPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnSingUp;
@property (weak, nonatomic) IBOutlet UILabel *lblSignIn;


- (IBAction)onClickForgotPassword:(id)sender;
- (IBAction)onClickLogin:(id)sender;
- (IBAction)onClickTwitter:(id)sender;
- (IBAction)onClickFacebook:(id)sender;
- (IBAction)onClickSignUp:(id)sender;

@end
