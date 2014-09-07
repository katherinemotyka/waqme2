

#import <UIKit/UIKit.h>

@interface SettingView : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtContect;
@property (weak, nonatomic) IBOutlet UISwitch *swNotification;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIScrollView *scrView;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)onClickResetPassword:(id)sender;
- (IBAction)onClickAddAnotherContect:(id)sender;
- (IBAction)onClickLogout:(id)sender;
@end
