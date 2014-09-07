#import "WrightReviewView.h"
#import "AppDelegate.h"

@interface WrightReviewView ()
{
    AppDelegate *appDelegate;
}
@end

@implementation WrightReviewView

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
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:appDelegate.userLatitude longitude:appDelegate.userLongitude] ;
    MKCoordinateRegion region; //create a region.  No this is not a pointer
    region.center = location.coordinate;  // set the region center to your current location
    MKCoordinateSpan span; // create a range of your view
    span.latitudeDelta = 0.1;
    span.longitudeDelta = 0.1;
    region.span = span;
    [self.mapView setRegion:region animated:YES];
    
    self.txtReview.text = @"Please write a review about John Smith";
    
    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"navBg.png"] forToolbarPosition:0 barMetrics:0];
    // Do any additional setup after loading the view.
    
    [self.starRatingView setStars:2 callbackBlock:^(NSNumber *newRating) {
        NSLog(@"didChangeRating: %@",newRating);
    }];

}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self animateTextField:textView up:YES];
    if ([textView.text isEqualToString:@"Please write a review about John Smith"]) {
        textView.text = @"";
    }
    [textView becomeFirstResponder];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
         [self animateTextField:textView up:NO];
        return NO;
    }
    
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Please write a review about John Smith";
        textView.textColor = [UIColor whiteColor]; //optional
    }
    [textView resignFirstResponder];
}

-(void)animateTextField:(UITextView *)textField up:(BOOL)up
{
    const int movementDistance = -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)didChangeRating:(NSNumber*)newRating
{
    NSLog(@"didChangeRating: %@",newRating);
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

- (IBAction)onClickSave:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
