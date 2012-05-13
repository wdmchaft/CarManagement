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
@synthesize socket = _socket;

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
    [_socket release];
 
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
    UIImage *locationBtnImg = [[CMResManager getInstance] imageForKey:@"current_location"];
    UIImage *historyBtnImg = [[CMResManager getInstance] imageForKey:@"history_trace"];
    [self setRightBtnEnabled:NO];
    [self addExtendBtnWithTarget:self touchUpInsideSelector:@selector(locationAction) normalImage:locationBtnImg hightLightedImage:nil];
    [self addExtendBtnWithTarget:self touchUpInsideSelector:@selector(historyTrackAction) normalImage:historyBtnImg hightLightedImage:nil];

    //3.0mapView
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, kCMNavigationBarHight, kFullScreenWidth, 400)];
    mapView.showsUserLocation = NO;
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
//    CLLocationManager *locationMgr = [[CLLocationManager alloc] init];
//    locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
//    locationMgr.distanceFilter = kCLDistanceFilterNone;
//    self.locationMgr = locationMgr;
//    self.locationMgr.delegate = self;
//    [locationMgr release];
    
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
    
    if ( self.annotation ) {
        [self.annotation moveAnnotation:self.currentLocation];
    }
    else {
        CMAnnotation *annotation = [[CMAnnotation alloc] initWithCoordinate:self.currentLocation title:@"You are here" subTitle:@"great"];
        self.annotation = annotation;
        [self.mapView addAnnotation:self.annotation];
        [annotation release];
    }
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.socket = appDelegate.client;
    self.socket.delegate = self;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
//    [self.locationMgr startUpdatingLocation];

}

- (void)viewWillDisappear:(BOOL)animated
{
//    [self.locationMgr stopUpdatingLocation];  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma buttonAction
- (void)locationAction
{
    self.mapView.showsUserLocation = YES;
    MKUserLocation *userLocation = self.mapView.userLocation;
    CLLocationCoordinate2D userCoord = userLocation.coordinate;
    NSLog(@"userCoord = %f , %f",userCoord.latitude,userCoord.longitude);
    self.mapView.centerCoordinate = userCoord;
}

/**查看历史记录
 *@param 地图上显示历史记录
 *return nil*/
- (void)historyTrackAction
{
    NSLog(@"historyTrackAction~");
    NSString *queryHistoryTrackParam = [NSString createQueryHistoryTrackParam:self.terminalNo beginTime:@"2012-05-04 08" endTime:@"2012-05-04 09"];
    NSLog(@"queryHistoryTrackParamm = %@",queryHistoryTrackParam);
    NSData *query = [queryHistoryTrackParam dataUsingEncoding:NSUTF8StringEncoding];
    //test
//    NSString *queryOilAnalysisParam = [NSString createOilAnalysisParam:self.terminalNo beginTime:@"2012-05-01" endTime:@"2012-05-06"];
//    NSLog(@"queryOilAnalysisParam = %@",queryOilAnalysisParam);
//    NSData *query2 = [queryOilAnalysisParam dataUsingEncoding:NSUTF8StringEncoding];
//    [self.socket writeData:query2 withTimeout:-1 tag:4];
//    [self.socket readDataWithTimeout:-1 tag:4];
    
    [self.socket writeData:query withTimeout:-1 tag:3];
    [self.socket readDataWithTimeout:-1 tag:3];
    
//    //test
//    NSString *loginParam = [NSString createLoginParam:@"super1" password:@"181125"];
//    NSLog(@"longinParam = %@",loginParam);
//    NSData *param = [loginParam dataUsingEncoding:NSUTF8StringEncoding];
//    [self.socket writeData:param withTimeout:-1 tag:12];
//    
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
/*@更新*/
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

#pragma AsyncSocket
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    [self.socket readDataWithTimeout:-1 tag:0];
    NSLog(@"didConnectToHost");
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err 
{
    NSLog(@"Error");

}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"Sorry this connect is failure");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{  
    NSLog(@"recvData = %@",data);
//    if ( tag == 3 ) {
        NSMutableArray *recv = [NSString parseQueryHistoryTrackRecv:data];
        NSLog(@"LocationMap recv = %@",recv);
//    }
//    else if ( tag == 4 ) {
//        NSMutableArray *recv = [NSString parseQueryOilAnalysisRecv:data];
//        NSLog(@"hello~~~");
//    }

}
@end
//test 59.77.15.2:1440
