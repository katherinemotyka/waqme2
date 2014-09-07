

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "DXStarRatingView.h"

@interface WrightReviewView : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet UITextView *txtReview;

@property (weak, nonatomic) IBOutlet DXStarRatingView *starRatingView;
- (IBAction)onClickSave:(id)sender;

@end
