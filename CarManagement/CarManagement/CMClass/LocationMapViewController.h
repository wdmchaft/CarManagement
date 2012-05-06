//
//  LocationMapViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationMapViewController : UIViewController
{
    MKMapView *_mapView;
    
}

@property (nonatomic,retain) MKMapView *mapView;
@end
