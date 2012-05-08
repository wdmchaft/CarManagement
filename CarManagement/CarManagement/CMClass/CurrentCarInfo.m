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
    self = [super init];
    if ( self ) {
        NSArray *currentCarInfo = [NSArray arrayWithArray:currentCarInfoParam];
        self.terminalNo = [currentCarInfo objectAtIndex:1];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[[currentCarInfo objectAtIndex:2] floatValue] 
                                                          longitude:[[currentCarInfo objectAtIndex:3] floatValue]];
        self.location = location;
        [location release];
        self.speed = [[currentCarInfo objectAtIndex:4] floatValue];
        self.state = [[currentCarInfo objectAtIndex:5] longValue];
        self.direction = [[currentCarInfo objectAtIndex:6] floatValue];
        self.mileage = [[currentCarInfo objectAtIndex:7] floatValue];
        self.lastTransmissionTime = [[currentCarInfo objectAtIndex:8] longValue];
        self.continueDirverTime = [[currentCarInfo objectAtIndex:9] longValue];
        self.oilLeft = [[currentCarInfo objectAtIndex:10] floatValue];
        self.carPosition = [currentCarInfo objectAtIndex:11];
        self.voltage = [[currentCarInfo objectAtIndex:12] floatValue];
        self.expand1 = [currentCarInfo objectAtIndex:13];
        self.version = [currentCarInfo objectAtIndex:14];
        self.expand2 = [currentCarInfo objectAtIndex:15];
        self.photoName = [currentCarInfo objectAtIndex:16];
        self.uitrasonicWaveDistance = [[currentCarInfo objectAtIndex:17] floatValue];
        self.lastTakePhotoTime = [[currentCarInfo objectAtIndex:18] longValue];
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
- (CurrentCarInfo *)theCarInfo:(NSString *)terminalNo
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