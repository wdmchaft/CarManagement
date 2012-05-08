//
//  CurrentCarInfo.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-8.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "CurrentCarInfo.h"

@implementation CurrentCarInfo
@synthesize location = _location;
@synthesize state = _state;
@synthesize speed = _speed;
@synthesize mileage = _mileage;
@synthesize direction = _direction;
@synthesize lastTransmissionTime = _lastTransmissionTime;
@synthesize continueDirverTime = _continueDirverTime;
@synthesize oilLeft = _oilLeft;
@synthesize carPosition = _carPosition;
@synthesize voltage = _voltage;
@synthesize expand1 = _expand1;
@synthesize expand2 = _expand2;
@synthesize photoName = _photoName;
@synthesize uitrasonicWaveDistance = _uitrasonicWaveDistance;
@synthesize lastTakePhotoTime = _lastTakePhotoTime;
@synthesize version = _version;

- (void)dealloc
{
    [_location release];
    
    [super dealloc];
}
/**初始化currentCar
 *@param currentCarInfo:数组，包含currentCar的基本属性字段
 *return self*/
- (id)initWithParam:(NSArray *)currentCarInfoParam
{
    NSLog(@"hello currentinfo = %@",currentCarInfoParam);
    self = [super init];
    if ( self ) {
        NSLog(@"count = %d",[currentCarInfoParam count]);
        NSInteger count = 0;
        for ( NSString *key in currentCarInfoParam ) {
            NSLog(@"index = %d,key = %@",count ++,key);
        }
        NSArray *currentCarInfo = [NSArray arrayWithArray:currentCarInfoParam];
        self.terminalNo = [currentCarInfo objectAtIndex:0];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[[currentCarInfo objectAtIndex:1] floatValue] 
                                                          longitude:[[currentCarInfo objectAtIndex:2] floatValue]];
        self.location = location;
        [location release];
        self.speed = [[currentCarInfo objectAtIndex:3] floatValue];
        self.state = [[currentCarInfo objectAtIndex:4] longLongValue];
        self.direction = [[currentCarInfo objectAtIndex:5] floatValue];
        self.mileage = [[currentCarInfo objectAtIndex:6] floatValue];
        self.lastTransmissionTime = [[currentCarInfo objectAtIndex:7] longLongValue];
        self.continueDirverTime = [[currentCarInfo objectAtIndex:8] longLongValue];
        self.oilLeft = [[currentCarInfo objectAtIndex:9] floatValue];
        self.carPosition = [currentCarInfo objectAtIndex:10];
        self.voltage = [[currentCarInfo objectAtIndex:11] floatValue];
        self.expand1 = [currentCarInfo objectAtIndex:12];
        self.version = [currentCarInfo objectAtIndex:13];
        self.expand2 = [currentCarInfo objectAtIndex:14];
        self.photoName = [currentCarInfo objectAtIndex:15];
        self.uitrasonicWaveDistance = [[currentCarInfo objectAtIndex:16] floatValue];
        self.lastTakePhotoTime = [[currentCarInfo objectAtIndex:17] longLongValue];
    }
    
    return self;
}

@end

@implementation CMCurrentCars

static CMCurrentCars *_instance = nil;
@synthesize currentCars = _currentCars;

- (void)dealloc
{
    [_currentCars release];
    
    [super dealloc];
}

/**初始化
 *@param currentCarParam:当前车辆信息数组,数组内容为当前车辆信息对象
 *return 实例*/
- (id)initWithCurrentCarInfoParam:(NSMutableArray *)currentCarsInfoParam
{
    self = [super init];
    if ( self ) {
        NSMutableDictionary *currentCarDics = [[NSMutableDictionary alloc] init];
        NSString *key;
        for ( CurrentCarInfo *theCurrentCarInfo in currentCarsInfoParam ){
            key = theCurrentCarInfo.terminalNo;
            //currentCarInfo 从 carInfo赋值
            
//            CarInfo *theCarInfo = [[CMCars getInstance] theCarInfo:key];
//            theCurrentCarInfo.carNo = theCarInfo.carNo;
//            theCurrentCarInfo.carSIMNo = theCarInfo.carSIMNo;
//            theCurrentCarInfo.carType = theCarInfo.carType;
//            theCurrentCarInfo.cameraNum = theCarInfo.cameraNum;
//            theCurrentCarInfo.drivers = theCarInfo.drivers;
//            theCurrentCarInfo.lastPhotoName = theCarInfo.lastPhotoName;
//            theCurrentCarInfo.lastPhotoTime = theCarInfo.lastPhotoTime;
//            theCurrentCarInfo.lastPhoto = theCarInfo.lastPhoto;
            [currentCarDics setObject:theCurrentCarInfo forKey:key];
        }
        
        self.currentCars = currentCarDics;
        [currentCarDics release];
    }
    
    return self;
}

/**获取单利
 *@param nil
 *return _instance:单利*/
+ (CMCurrentCars *)getInstance
{
    @synchronized(self){
        if ( !_instance ) {
            _instance = [[CMCurrentCars alloc] init];
        }
    }
    
    return _instance;
}

/**获取所有终端号
 *@param nil
 *return 所有车终端号*/
- (NSArray *)terminalNos
{
    NSMutableArray *terminalNos = [[[NSMutableArray alloc] init] autorelease];
    for ( id key in self.currentCars ){
        [terminalNos addObject:key];
    }
    
    return [NSArray arrayWithArray:terminalNos];
}

/**由终端号获取当前车辆信息
 *@param terminalNo:车牌号
 *return theCarInfo:车辆信息*/
- (CurrentCarInfo *)theCurrentCarInfo:(NSString *)terminalNo
{
    return [self.currentCars objectForKey:terminalNo];
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if ( !_instance ) {
            _instance = [super allocWithZone:zone];
            return _instance;
        }
    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return  _instance;
}

- (unsigned)retainCount
{
    return UINT_MAX;
}

- (id)autorelease
{
    return self;
}
@end