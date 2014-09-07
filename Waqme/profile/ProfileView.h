

#import <UIKit/UIKit.h>

@interface ProfileView : UIViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *arrDescription;
    int counter;
    NSMutableArray *arrLatLong;
    NSMutableArray *arrMapViewDispay;
}
@property (weak, nonatomic) IBOutlet UILabel *lblFirstName;
@property (weak, nonatomic) IBOutlet UILabel *lblLastName;
@property (weak, nonatomic) IBOutlet UILabel *lblOccupation;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblVoteUp;
@property (weak, nonatomic) IBOutlet UILabel *lblVoteDown;
@property (weak, nonatomic) IBOutlet UITextView *txtComment;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;

- (IBAction)OnClickLeftComment:(id)sender;
- (IBAction)onClickProfilePic:(id)sender;

- (IBAction)OnClickRightComment:(id)sender;
- (IBAction)OnClickVoteUp:(id)sender;
- (IBAction)OnClickVoteDown:(id)sender;
- (IBAction)OnClickShareTwitter:(id)sender;
- (IBAction)OnClickShareOnFacebook:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrView;


@end
