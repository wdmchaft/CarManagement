//
//  CMAnnotation.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-10.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "CMAnnotation.h"

@implementation CMAnnotation
@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize coordinate;

- (void)dealloc
{
    self.title = nil;
    self.subTitle = nil;
    [super dealloc];
}


- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)title subTitle:(NSString *)subTitle
{
    self = [super init];
    if ( self ) {
        coordinate = c;
        self.title = title;
        self.subTitle = subTitle; 
    }
    
    return self;
}


- (NSString *)subTitle 
{
    return _subTitle;
}


- (NSString *)title
{
    return _title;
}

- (void)moveAnnotation:(CLLocationCoordinate2D)newCoordinate
{
    coordinate = newCoordinate;
}
@end
