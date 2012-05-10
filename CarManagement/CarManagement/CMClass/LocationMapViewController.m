//
//  LocationMapViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "LocationMapViewController.h"
#import "LocationDetailViewController.h"
#import "AppDelegate.h"

@interface LocationMapViewController ()

@end

@implementation LocationMapViewController
@synthesize mapView = _mapView;
@synthesize terminalNo = _terminalNo;
@synthesize locationMgr = _locationMgr;
@synthesize currentLocation = _currentLocation;
@synthesize region = _region;
@synthesize span = _span;
@synthesize annotation = _annotation;
@synthesize locationAddress = _locationAddress;
@synthesize geocoder = _geocoder;
@synthesize detailBtn = _detailBtn;
/**初始化
 *@param terminalNo:终端号码
 *return self*/
- (id)initWithTerminalNo:(NSString *)terminalNoParam
{
    self = [super init];
    if ( self ) {
        self.terminalNo = terminalNoParam;
    }
    
    return self;
}

- (void)dealloc
{
    [_mapView release];
    [_locationMgr release];
    [_annotation release];
    [_detailBtn release];
 
    self.locationAddress = nil;
    self.terminalNo = nil;
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"GPS定位";
    self.navigationController.navigationBarHidden = YES;
    
    //2.0当前位置
    UIImage *btnImg = [[CMResManager getInstance] imageForKey:@"current_location"];
    [self addRightBtn:btnImg controllerEventTouchUpInside:@selector(locationAction) target:self];
   
    //3.0mapView
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, kCMNavigationBarHight, kFullScreenWidth, 400)];
    mapView.showsUserLocation = YES;
    mapView.mapType = MKMapTypeStandard;
    self.mapView = mapView;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    [mapView release];
    
    //4.0地图上详细按钮
    UIButton *detailBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    detailBtn.frame = CGRectMake(0, 0, 23, 23);
    detailBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    detailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [detailBtn addTarget:self action:@selector(detailAction) forControlEvents:UIControlEventTouchUpInside];
    self.detailBtn = detailBtn;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CLLocationManager *locationMgr = [[CLLocationManager alloc] init];
    locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    locationMgr.distanceFilter = kCLDistanceFilterNone;
    self.locationMgr = locationMgr;
    self.locationMgr.delegate = self;
    [self.locationMgr startUpdatingLocation];
    [locationMgr release];
    
    self.currentLocation = [[CMCurrentCars getInstance] theCurrentCarInfo:self.terminalNo].currentLocation;
    self.mapView.centerCoordinate = self.currentLocation;
    NSLog(@"terminalNo = %@:latitude = %f,longitude = %f",self.terminalNo,self.currentLocation.latitude,self.currentLocation.longitude);
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    span = MKCoordinateSpanMake(0.2, 0.2);
    region.span = span;
    region.center = self.currentLocation;
    self.region = region;
    [self.mapView setRegion:self.region];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.locationMgr stopUpdatingLocation];  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma buttonAction
- (void)locationAction
{
    self.mapView.showsUserLocation = YES;
}


/**地图箭头按钮事件,详细信息
 *@param nil
 *return nil*/
- (void)detailAction
{
    LocationDetailViewController *detailViewController = [[LocationDetailViewController alloc] init];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}
#pragma mark - MKMapViewDelegate
/*@地图缩放时*/
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated    
{
    
}

/*@显示箭头*/
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSString *identifier = @"pin";
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if ( !pin ) {
        pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
    }
    else {
        pin.annotation = annotation;
    }
    
    pin.rightCalloutAccessoryView = self.detailBtn;
    pin.enabled = YES;
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    
    return pin;
}


#pragma mark - CLLocationmanagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation   
{
    NSLog(@"locationManager~~");
    MKCoordinateSpan span = MKCoordinateSpanMake(.002, .002);
    MKCoordinateRegion region;
    region.center = newLocation.coordinate;
    region.span = span;
    [self.mapView setRegion:region animated:YES];
    
    if ( self.annotation ) {
        [self.annotation moveAnnotation:self.currentLocation];
    }
    else {
        CMAnnotation *annotation = [[CMAnnotation alloc] initWithCoordinate:newLocation.coordinate title:@"You are here" subTitle:@"great"];
        self.annotation = annotation;
        [self.mapView addAnnotation:self.annotation];
        [annotation release];
    }
    
    if ( !self.geocoder ) {
        MKReverseGeocoder *geocoder = [[MKReverseGeocoder alloc] initWithCoordinate:self.currentLocation];
        self.geocoder = geocoder;
        self.geocoder.delegate = self;
        [self.geocoder start];
        [geocoder release];
    }
}

#pragma mark - MKReverseGeocoderDelegate
/*@逆地址解析成功回调*/
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark 
{
    self.locationAddress = [NSString stringWithFormat:@"%@,%@",placemark.locality,placemark.country];
    self.annotation.subTitle = self.locationAddress;
    [_geocoder release];
    _geocoder = nil;
}

/*@逆地址解析失败回调*/
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    [_geocoder release];
    _geocoder = nil;
}
@end
