
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface WalkingView : UIViewController
{   int customTag;
    NSMutableArray *arrLatLong;
    NSMutableArray *arrMapViewDispay;
}

-(IBAction)onClickCancel:(id)sender;
-(IBAction)onClickSOS:(id)sender;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@end
