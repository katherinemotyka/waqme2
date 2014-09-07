

#import <UIKit/UIKit.h>

@interface RegisterView : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastname;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)onClickLogin:(id)sender;
- (IBAction)onClickBack:(id)sender;

@end
