
#import "RegisterView.h"
#import "AppDelegate.h"

@interface RegisterView ()
{
    AppDelegate *appDelegate;
}
@end

@implementation RegisterView

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)onClickLogin:(id)sender {
    if(self.txtFirstName.text.length == 0 ||  self.txtLastname.text.length == 0 || self.txtEmail.text.length == 0 ||  self.txtPassword.text.length == 0){
        [appDelegate showAlert:@"Alert" message:@"Must have entered all information"];
    }else if(![self validateEmailWithString:self.txtEmail.text]){
        [appDelegate showAlert:@"Alert" message:@"Please enter valid email address"];
    }else {
        [self.txtPassword resignFirstResponder];
        [self.txtFirstName resignFirstResponder];
        [self.txtLastname resignFirstResponder];
        [self.txtEmail resignFirstResponder];
        
        [appDelegate tabBarControllerView];
    }
}


- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
