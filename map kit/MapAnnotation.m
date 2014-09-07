//
//  MapAnnotation.m
//  MapView
//
//  Created by Chintan on 01/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
@synthesize title;
@synthesize coordinate;

-(id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d
{
   
   self=[super init];
    if(self)
    {
     title = ttl;
     coordinate = c2d;
    }
    return self;
}



@end
