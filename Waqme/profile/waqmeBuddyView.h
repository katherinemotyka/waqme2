

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface waqmeBuddyView : UIViewController
{
    NSMutableArray *arrLatLong;
    NSMutableArray *arrMapViewDispay;
    int customTag;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

-(IBAction)OnClickICannot:(id)sender;
@end
