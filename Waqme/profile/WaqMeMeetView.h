

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface WaqMeMeetView : UIViewController
{
    int customTag;
    NSMutableArray *arrLatLong;
    NSMutableArray *arrMapViewDispay;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)onClickCancel:(id)sender;

@end
