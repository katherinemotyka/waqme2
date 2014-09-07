

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "HttpWrapper.h"

@interface LocationView : UIViewController <UITextFieldDelegate,HttpWrapperDelegate,MKMapViewDelegate>
{
      int customTag;
    NSMutableArray *arrLatLong;
    NSMutableArray *arrMapViewDispay;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UITextField *txtCurrnetLocation;
@property (weak, nonatomic) IBOutlet UITextField *txtFinalLocation;
@property (weak, nonatomic) IBOutlet UIScrollView *scrView;
@property (weak, nonatomic) IBOutlet UIButton *btnMale;
@property (weak, nonatomic) IBOutlet UIButton *btnFemale;

- (IBAction)onClickRequest:(id)sender;
- (IBAction)onClickMale:(id)sender;
- (IBAction)onClickFemail:(id)sender;
@end
