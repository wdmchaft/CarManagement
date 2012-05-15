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

#define FIELD_DATE_BEGIN_Y            5
#define FIELD_DATE_BEGIN_MAX_X        155
#define FIELD_DATE_END_BEGIN_MIN_X    165  
#define kAlertEndDateWrong            2000
#define kAlertDatesIntervalWrong      2001

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
@synthesize dateView = _dateView;
@synthesize dateBegin = _dateBegin;
@synthesize dateEnd = _dateEnd;
@synthesize segLabel = _segLabel;
@synthesize datePicker = _datePicker;
@synthesize dateChoiceProcess = _dateChoiceProcess;
@synthesize isQueryOk = _isQueryOk;
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
    [_dateView release];
    [_dateBegin release];
    [_dateEnd release];
    [_datePicker release];
    [_segLabel release];
 
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
    [self addExtendBtnWithTarget:self touchUpInsideSelector:@selector(queryHistoryTrackAction) normalImage:historyBtnImg hightLightedImage:nil];

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
    
    //5.0时间选择
    //5.1背景view
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(0, kFullScreenHight, kFullScreenWidth, 256)];
    dateView.backgroundColor = [UIColor whiteColor];
    //5.2开始查询时间
    UITextField *dateBegin = [[UITextField alloc] initWithFrame:CGRectMake(20,5,135,30)];
    dateBegin.backgroundColor = [UIColor clearColor];
    dateBegin.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    dateBegin.textAlignment = UITextAlignmentCenter;
    dateBegin.userInteractionEnabled = NO;
    dateBegin.placeholder = @"查询开始日期";
    self.dateBegin = dateBegin;
    self.dateBegin.delegate = self;
    [dateView addSubview:self.dateBegin];
    [dateBegin release];
    //5.3中间分割，
    UILabel *segLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 5, 10, 30)];
    segLabel.backgroundColor = [UIColor clearColor];
    segLabel.textAlignment = UITextAlignmentCenter;
    segLabel.text = @"-";
    self.segLabel = segLabel;
    [dateView addSubview:self.segLabel];
    [segLabel release];
    //5.4结束时间
    UITextField *dateEnd = [[UITextField alloc] initWithFrame:CGRectMake(165, 5, 135, 30)];
    dateEnd.backgroundColor = [UIColor clearColor];
    dateEnd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    dateEnd.textAlignment = UITextAlignmentCenter;
    dateEnd.placeholder = @"查询结束日期";
    self.dateEnd = dateEnd;
    self.dateEnd.delegate = self;
    [dateView addSubview:self.dateEnd];
    [dateEnd release];
    //5.5滚轮
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,40, kFullScreenWidth, 216)];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [datePicker addTarget:self action:@selector(pickerValueChangedAction) forControlEvents:UIControlEventValueChanged];
    self.datePicker = datePicker;
    [dateView addSubview:self.datePicker];
    [datePicker release];
    
    self.dateView = dateView;
    [self.view addSubview:self.dateView];
    [dateView release];
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
    
    //1.0查询日期默认
    //1.1获取当前时间
    NSDateFormatter *dateFormater = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormater setDateFormat:kDateAndTimeHourFormater];
    NSString *theRightEndDate = [dateFormater stringFromDate:[NSDate date]];
    //1.2获取一周前的时间
    NSDate *now = [NSDate date];
    NSString *theRightBeginDate = [dateFormater stringFromDate:[now dateByAddingTimeInterval:-3600 * 24 * kQueryHistoryTimeInterval]];
    self.dateBegin.text = theRightBeginDate;
    self.dateEnd.text = theRightEndDate;
    //1.3滚轮初始化选择时间
    NSDate *currentTime = [[NSDate alloc] init];
    [self.datePicker setDate:currentTime animated:YES];
    
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
        CurrentCarInfo *theCurrentCar = [[CMCurrentCars getInstance] theCurrentCarInfo:self.terminalNo];
        CMAnnotation *annotation = [[CMAnnotation alloc] initWithCoordinate:self.currentLocation title:@"Here" subTitle:theCurrentCar.carPosition];
        self.annotation = annotation;
        [self.mapView addAnnotation:self.annotation];
        [annotation release];
    }
    //socket
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.socket = appDelegate.client;
    self.socket.delegate = self;

    self.isQueryOk = NO;
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
/*@手指触发事件*/
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.dateView];
    if ( point.y > FIELD_DATE_BEGIN_Y - 5 && point.y < FIELD_DATE_BEGIN_Y + 35 ) {
        
//        [self showPickerView];
        if ( point.x < FIELD_DATE_BEGIN_MAX_X ) {
            self.dateBegin.text = @"";
            self.dateChoiceProcess = CMDateChoiceProcessBegin;
        }
        else {
            self.dateEnd.text = @"";
            self.dateChoiceProcess = CMDateChoiceProcessEnd;
        }
    }
}

/**显示滚轮
 *@param nil
 *return nil*/
- (void)showPickerView
{
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.3];
    self.dateView.center = CGPointMake(160, 283);
    [UIView commitAnimations];
}

/**隐藏滚轮
 *@param nil
 *return nil*/
- (void)hidePickerView
{
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.3];
    self.dateView.center = CGPointMake(160, 588);
    [UIView commitAnimations];    
}

/**滚轮数值改变
 *@param nil
 *return nil*/
- (void)pickerValueChangedAction
{
    NSDate *selected = [self.datePicker date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:kDateAndTimeHourFormater];
    NSString *theDate = [dateFormat stringFromDate:selected];
    switch ( self.dateChoiceProcess ) {
        case CMDateChoiceProcessBegin:
        {
            self.dateBegin.text = theDate;
        }break;
        case CMDateChoiceProcessEnd:
        {
            self.dateEnd.text = theDate;
        }break;
        default:NSLog(@"date choice error～");
            break;
    }
}

/**当前用户所在位置
 *
 **/
- (void)locationAction
{
    self.mapView.showsUserLocation = YES;
    MKUserLocation *userLocation = self.mapView.userLocation;
    CLLocationCoordinate2D userCoord = userLocation.coordinate;
    NSLog(@"userCoord = %f , %f",userCoord.latitude,userCoord.longitude);
    self.mapView.centerCoordinate = userCoord;
}

///**查看历史记录
// *@param 地图上显示历史记录
// *return nil*/
//- (void)historyTrackAction
//{
//    NSLog(@"historyTrackAction~");
//    NSString *queryHistoryTrackParam = [NSString createQueryHistoryTrackParam:self.terminalNo beginTime:@"2012-05-04 08" endTime:@"2012-05-04 09"];
//    NSLog(@"queryHistoryTrackParamm = %@",queryHistoryTrackParam);
//    NSData *query = [queryHistoryTrackParam dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [self.socket writeData:query withTimeout:-1 tag:3];
//    [self.socket readDataWithTimeout:-1 tag:3];
//}

/**地图箭头按钮事件,详细信息
 *@param nil
 *return nil*/
- (void)detailAction
{
    LocationDetailViewController *detailViewController = [[LocationDetailViewController alloc] init];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

/**滚轮选择值改变触发
 *@param nil    
 *return nil*/
- (void)queryHistoryTrackAction
{
    if ( !self.isQueryOk ) {
        [self showPickerView];
        self.isQueryOk = YES;
    }
    else {
        //1.0时间判断
        //1.1获取日期之差,判断是否大于系统查询间隔
        NSDateFormatter *formater = [[[NSDateFormatter alloc] init] autorelease];
        [formater setDateFormat:kDateAndTimeHourFormater];
        NSDate *beginDate = [formater dateFromString:self.dateBegin.text];
        NSDate *endDate = [formater dateFromString:self.dateEnd.text];
        NSDate *currentDate = [NSDate date];
        
        float daysBetweenEB = [endDate timeIntervalSinceDate:beginDate] / ( 3600 * 24 );
        float daysBetweenNE = [currentDate timeIntervalSinceDate:endDate] / ( 3600 * 24 );
        float daysBetweenNB = [currentDate timeIntervalSinceDate:beginDate] / ( 3600 * 24 );
        
        NSLog(@"daysBetweenEB=%f,daysBetweenNE=%f,daysBetweenNB=%f",daysBetweenEB,daysBetweenNE,daysBetweenNB);
        NSLog(@"beginDate=%@,endDate=%@,currentDate=%@",beginDate,endDate,currentDate);
        if ( daysBetweenNE >= 0.000001 && daysBetweenNB >= 0.000001 ) {
            if ( daysBetweenEB < 0.000001 ) {
                [self showAlert:kAlertDatesIntervalWrong title:nil message:@"查询开始时间不可大于结束时间"];
            }
            else if ( daysBetweenEB > kQueryHistoryTimeInterval ) {
                [self showAlert:kAlertDatesIntervalWrong title:nil message:[NSString stringWithFormat:@"查询日期差不可超过%d天",kQueryHistoryTimeInterval]];
            }
            else {
                NSString *historyTrackQueryParam = [NSString createQueryHistoryTrackParam:self.terminalNo beginTime:self.dateBegin.text endTime:self.dateEnd.text];
                NSLog(@"historyTrackQueryParam = %@",historyTrackQueryParam);
                NSData *query = [historyTrackQueryParam dataUsingEncoding:NSUTF8StringEncoding];
                [self.socket writeData:query withTimeout:-1 tag:3];
                [self.socket readDataWithTimeout:-1 tag:3];
                [self hidePickerView];
                self.isQueryOk = NO;
            }
        }
        else {
            [self showAlert:kAlertEndDateWrong title:nil message:@"查询开始/结束时间不可超过当日"];
        }
    }
}

/**提醒
 *@param
 *return nil*/
- (void)showAlert:(NSInteger)alertTag title:(NSString *)title message:(NSString *)message
{
    if ( !title ) {
        title = kAlertTitleDefault;
    }
    UIAlertView *tip = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    tip.tag = alertTag;
    [tip show];
    [tip release];
}
#pragma mark - UITextFieldDelegate
/*@=UITextFieldDelegate*/
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
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
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{  
    NSLog(@"recvData = %@",data);
    NSMutableArray *recv = [NSString parseQueryHistoryTrackRecv:data];
    NSLog(@"LocationMap recv = %@",recv);
}
@end
//test 59.77.15.2:1440
