

#import "ProfileView.h"
#import <Social/Social.h>

@interface ProfileView ()

@end

@implementation ProfileView

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
    arrDescription = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dictData = [[NSMutableDictionary alloc]init];
    [dictData setValue:@"12" forKeyPath:@"upvote"];
    [dictData setValue:@"8" forKeyPath:@"downvote"];
    [dictData setValue:@"john methyu" forKeyPath:@"user"];
    [dictData setValue:@"It is made up of comment and opinion, and also new emotions which are vaguely applied to his own life.   She would not comment on how the aftermarket sites had affected revenue.  Go ahead, try it out for yourself and send us a comment. " forKeyPath:@"comment"];
    
    [arrDescription addObject:dictData];
    
    dictData = [[NSMutableDictionary alloc]init];
    [dictData setValue:@"18" forKeyPath:@"upvote"];
    [dictData setValue:@"16" forKeyPath:@"downvote"];
    [dictData setValue:@"john cena" forKeyPath:@"user"];
    [dictData setValue:@"A comment is generally a verbal or written remark often related to an added piece of information, or an observation or statement. These are usually marked with an abbreviation, such as obs." forKeyPath:@"comment"];
    
    [arrDescription addObject:dictData];
 
    dictData = [[NSMutableDictionary alloc]init];
    [dictData setValue:@"32" forKeyPath:@"upvote"];
    [dictData setValue:@"24" forKeyPath:@"downvote"];
    [dictData setValue:@"Rockstar 12" forKeyPath:@"user"];
    [dictData setValue:@"Since iOS 3.2, you can use custom fonts in your iOS apps by adding the UIAppFonts Info.plist key. Unfortunately, custom fonts are not available when editing your xib files in Interface Builder. MoarFonts makes your custom fonts available right within Interface Builder." forKeyPath:@"comment"];
    
    [arrDescription addObject:dictData];
    
    counter = 0;
    [self.scrView setContentSize:CGSizeMake(320, 660)];
    
    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"navBg.png"] forToolbarPosition:0 barMetrics:0];
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

- (IBAction)OnClickLeftComment:(id)sender {
    if (counter >= 0) {
        NSDictionary *dict = [arrDescription objectAtIndex:counter];
    
        self.lblVoteDown.text = [dict valueForKey:@"downvote"];
        self.lblVoteUp.text = [dict valueForKey:@"upvote"];
        self.lblUserName.text = [dict valueForKey:@"user"];
        self.txtComment.text = [dict valueForKey:@"comment"];
        if (counter != 0) {
            counter--;
        }
    }
}

- (IBAction)onClickProfilePic:(id)sender {
    
    UIActionSheet *actionsheet = [[UIActionSheet alloc]
                                  
                                  initWithTitle:@"Upload Photo"
                                  
                                  delegate:self
                                  
                                  cancelButtonTitle:@"Cancel"
                                  
                                  destructiveButtonTitle:nil
                                  
                                  otherButtonTitles:@"Take Photo",@"Select Photo from Gallery", nil];
    
    [actionsheet showFromTabBar:self.tabBarController.tabBar];
}

#pragma mark -
#pragma mark - Action sheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])  {
            UIImagePickerController *cardPicker = [[UIImagePickerController alloc]init];
            cardPicker.allowsEditing=YES;
            cardPicker.delegate=self;
            cardPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:cardPicker animated:YES completion:nil];
      
            
        }
    }else if (buttonIndex ==1){
        UIImagePickerController *cardPicker = [[UIImagePickerController alloc]init];
        cardPicker.allowsEditing=YES;
        cardPicker.delegate=self;
        cardPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:cardPicker animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image
                 editingInfo:(NSDictionary *)editingInfo
{
    self.imgProfile.image = image;
    [picker dismissModalViewControllerAnimated:YES];
}


- (IBAction)OnClickRightComment:(id)sender {
    if (counter < [arrDescription count]) {
        NSDictionary *dict = [arrDescription objectAtIndex:counter];
        
        self.lblVoteDown.text = [dict valueForKey:@"downvote"];
        self.lblVoteUp.text = [dict valueForKey:@"upvote"];
        self.lblUserName.text = [dict valueForKey:@"user"];
        self.txtComment.text = [dict valueForKey:@"comment"];
        if (counter != [arrDescription count]-1) {
            counter++;
        }
    }
}

- (IBAction)OnClickVoteUp:(id)sender {
  self.lblVoteUp.text = [NSString stringWithFormat:@"%d",[self.lblVoteUp.text intValue]+1];
}

- (IBAction)OnClickVoteDown:(id)sender {
      self.lblVoteDown.text = [NSString stringWithFormat:@"%d",[self.lblVoteDown.text intValue]+1];
}

- (IBAction)OnClickShareTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:self.txtComment.text];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure                                   your device has an internet connection and you have                                   at least one Twitter account setup"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }

}

- (IBAction)OnClickShareOnFacebook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:self.txtComment.text];
        [self presentViewController:controller animated:YES completion:Nil];
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't post right now, make sure                                   your device has an internet connection and you have                                   at least one Facebook account setup"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}
@end
