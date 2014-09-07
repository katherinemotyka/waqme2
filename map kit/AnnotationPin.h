//
//  AnnotationPin.h
//  Click
//
//  Created by MW on 15/05/12.
//  
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface AnnotationPin : NSObject<MKAnnotation>{
    
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    
    int intTag;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@property(nonatomic,assign)int intTag;

@end
