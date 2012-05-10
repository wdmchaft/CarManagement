//
//  LocationMapViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CMBaseViewController.h"
#import "CMAnnotation.h"
#import "AsyncSocket.h"

@interface LocationMapViewController : CMBaseViewController<CLLocationManagerDelegate,MKMapViewDelegate,MKReverseGeocoderDelegate>
{
    MKMapView *_mapView;
    
    NSString *_terminalNo;
    
    CLLocationManager *_locationMgr;
    
    CLLocationCoordinate2D _currentLocation;
    
    MKCoordinateRegion _region;
    
    MKCoordinateSpan _span;
    
    CMAnnotation *_annotation;
    
    NSString *_locationAddress;
    
    MKReverseGeocoder *_geocoder;
    
    UIButton *_detailBtn;
}

@property (nonatomic,retain) MKMapView *mapView;
@property (nonatomic,copy) NSString *terminalNo;
@property (nonatomic,retain) CLLocationManager *locationMgr;
@property (nonatomic) CLLocationCoordinate2D currentLocation;
@property (nonatomic) MKCoordinateRegion region;
@property (nonatomic) MKCoordinateSpan span;
@property (nonatomic,retain) CMAnnotation *annotation;
@property (nonatomic,copy) NSString *locationAddress;
@property (nonatomic,retain) MKReverseGeocoder *geocoder;
@property (nonatomic,retain) UIButton *detailBtn;

/**初始化
 *@param terminalNo:终端号码
 *return self*/
- (id)initWithTerminalNo:(NSString *)terminalNoParam;
@end
