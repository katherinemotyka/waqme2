

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RequestAcceptView : UIViewController
{   int customTag;
    NSMutableArray *arrLatLong;
    NSMutableArray *arrMapViewDispay;
}

-(IBAction)onClickCancel:(id)sender;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end
