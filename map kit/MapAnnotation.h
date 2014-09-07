//
//  MapAnnotation.h
//  MapView
//
//  Created by Chintan on 01/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject<MKAnnotation>
{
    NSString *title;
    CLLocationCoordinate2D coordinate;  

    
}
@property (nonatomic,copy)NSString *title;
@property (nonatomic)CLLocationCoordinate2D coordinate;  

-(id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d;
@end
