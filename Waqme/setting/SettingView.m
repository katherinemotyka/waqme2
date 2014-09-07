

#import "SettingView.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface SettingView ()
{
    AppDelegate *appDelegate;
}
@end

@implementation SettingView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [AppDelegate sharedDalegate];
    
    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"navBg.png"] forToolbarPosition:0 barMetrics:0];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.txtContect) {
        CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y - 280);
        [self.scrView setContentOffset:scrollPoint animated:YES];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self.scrView setContentOffset:CGPointZero animated:YES];
    return YES;
}

- (IBAction)onClickLogout:(id)sender{
    
    [appDelegate.tabBarController.view removeFromSuperview];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)onClickResetPassword:(id)sender {
  self.txtPassword.text = @"";
}

- (IBAction)onClickAddAnotherContect:(id)sender {
}
@end
