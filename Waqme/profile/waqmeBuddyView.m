
#import "waqmeBuddyView.h"
#import "AppDelegate.h"
#import "MapAnnotation.h"
#import "AnnotationPin.h"

@interface waqmeBuddyView ()
{
    AppDelegate *appDelegate;
}
@end

@implementation waqmeBuddyView
@synthesize mapView;

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
    
    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"navBg.png"] forToolbarPosition:0 barMetrics:0];

    mapView.showsUserLocation=YES;
    [mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];
    
    arrMapViewDispay=[[NSMutableArray alloc]init];
    
    NSMutableDictionary *dictData = [[NSMutableDictionary alloc]init];
    
    [dictData setValue:[NSNumber numberWithFloat:appDelegate.userLatitude] forKey:@"lat"];
    [dictData setValue:[NSNumber numberWithFloat:appDelegate.userLongitude] forKey:@"lang"];
    [dictData setValue:@"Currenrt location" forKey:@"offer_name"];
    
    [arrMapViewDispay addObject:dictData];
    
    [self setMapViewOnClick];
    MKCoordinateRegion region = [self regionForAnnotations:arrLatLong];
    [self.mapView setRegion:region animated:YES];
    // Do any additional setup after loading the view.
}

-(IBAction)OnClickICannot:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setMapViewOnClick{
    customTag=0;
    
    [mapView removeAnnotations:mapView.annotations];
    if ([arrMapViewDispay count]>0) {
        arrLatLong = [[NSMutableArray alloc] init];
        for (int i=0; i<[arrMapViewDispay count]; i++) {
            [self getLatLong:i];
        }
    }
}

#pragma mark -
#pragma mark - MapView SetCenter

-(void)getLatLong:(int)intTag{
	
    NSMutableDictionary *dictData=[arrMapViewDispay objectAtIndex:intTag];
    
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude=[[dictData objectForKey:@"lat" ] floatValue];
    coordinate.longitude=[[dictData objectForKey:@"lang" ] floatValue];
    
    NSLog(@">>>>>>Add =%@ >>>>>>>>> lat :%@",[dictData objectForKey:@"lat" ],[dictData objectForKey:@"lang"]);
    
    AnnotationPin *addAnnotation = [[AnnotationPin alloc]init];
    addAnnotation.coordinate=coordinate;
    
    addAnnotation.title=[dictData objectForKey:@"offer_name"];
    //addAnnotation.subtitle=[dictData valueForKey:@"offer_cat"];
    addAnnotation.intTag=intTag;
    
    [arrLatLong addObject:addAnnotation];
    [mapView addAnnotation:addAnnotation];
}


-(MKCoordinateRegion) regionForAnnotations:(NSMutableArray *)annotations
{
    double minLat=90.0f, maxLat=-90.0f;
    double minLon=180.0f, maxLon=-180.0f;
    
    for (id<MKAnnotation> mka in annotations) {
        if ( mka.coordinate.latitude  < minLat ) minLat = mka.coordinate.latitude;
        if ( mka.coordinate.latitude  > maxLat ) maxLat = mka.coordinate.latitude;
        if ( mka.coordinate.longitude < minLon ) minLon = mka.coordinate.longitude;
        if ( mka.coordinate.longitude > maxLon ) maxLon = mka.coordinate.longitude;
    }
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((minLat+maxLat)/2.0, (minLon+maxLon)/2.0);
    MKCoordinateSpan span = MKCoordinateSpanMake(maxLat-minLat, maxLon-minLon);
    MKCoordinateRegion region = MKCoordinateRegionMake (center, span);
    
    return region;
}



#pragma mark -
#pragma mark - MapView Delegate

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    //    AnnotationPin *obj=view.annotation;
    //    if ([obj isKindOfClass:[MKUserLocation class]]) {
    //
    //    }else{
    //        OfferDetailViewIpad *offer = [[OfferDetailViewIpad alloc]initWithNibName:@"OfferDetailViewIpad" bundle:nil];
    //        offer.dictData=[arrMapViewDispay objectAtIndex:obj.intTag];
    //        offer.arrUserInfo=arrUserInfo;
    //        [self.navigationController pushViewController:offer animated:YES];
    //
    //        NSLog(@"Annotaion View >> %d",obj.intTag);
    //    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    AnnotationPin *obj=view.annotation;
    if ([obj isKindOfClass:[MKUserLocation class]]) {
        
    }else{
        NSLog(@"Annotaion View >> %d",obj.intTag);
    }
    
    NSLog(@"Annotaion control.tag >> %ld",(long)control.tag);
}



- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *pinView = nil;
    static NSString *defaultPinID = @"com.invasivecode.pin";
    pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView == nil )
        pinView = [[MKAnnotationView alloc]
                   initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    pinView.canShowCallout = YES;
    pinView.image = [UIImage imageNamed:@"pin.png"];
    pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pinView.rightCalloutAccessoryView.tag = 1;
    customTag++;
    
    [pinView needsUpdateConstraints];
    return pinView;
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

@end
