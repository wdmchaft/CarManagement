//
//  CarInfo.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-7.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "CarInfo.h"

@implementation Dirver
@synthesize dirverName = _dirverName;
@synthesize dirverTel = _dirverTel;

- (id)initWithParam:(NSString *)name tel:(NSString *)tel
{
    self = [super init];
    if ( self ) {
        self.dirverName = name;
        self.dirverTel = tel;
    }
    
    return self;
}
@end

@implementation CarInfo

@synthesize companyName = _companyName;
@synthesize carSIMNo = _carSIMNo;
@synthesize terminalNo = _terminalNo;
@synthesize carNo = _carNo;
@synthesize drivers = _drivers;
@synthesize lastPhotoName = _lastPhotoName;
@synthesize lastPhoto = _lastPhoto;
@synthesize hasNewPhoto = _hasNewPhoto;
@synthesize lastPhotoTime = _lastPhotoTime;
@synthesize carType = _carType;
@synthesize cameraNum = _cameraNum;


/**初始化car
 *@param carInfo:数组,包含car的基本属性字段
 *return self*/
- (id)initWithParam:(NSArray *)carInfoParam
{
    self = [super init];
    if ( self ) {
        NSArray *carInfo = [NSArray arrayWithArray:carInfoParam];
        //self.companyName = [carInfo objectAtIndex:0];
        self.terminalNo = [carInfo objectAtIndex:0];
        self.carNo = [carInfo objectAtIndex:1];
        self.carSIMNo = [carInfo objectAtIndex:2];
        self.carType = [[carInfo objectAtIndex:3] intValue];
        self.cameraNum = [[carInfo objectAtIndex:4] intValue];
        Dirver *dirver1 = [[Dirver alloc] initWithParam:[carInfo objectAtIndex:5] tel:[carInfo objectAtIndex:6]];
        Dirver *dirver2 = [[Dirver alloc] initWithParam:[carInfo objectAtIndex:7] tel:[carInfo objectAtIndex:8]];
        self.drivers = [NSArray arrayWithObjects:dirver1,dirver2,nil];
        [dirver1 release];
        [dirver2 release];
        //self.
    }
    
    return self;
}

@end



@implementation CMCars

static CMCars *_instance = nil;
@synthesize cars = _cars;

- (void)dealloc
{
    [_cars release];
    
    [super dealloc];
}

/**初始化
 *@param carsInfoParam:车辆信息数组,数组内容为车辆对象
 *return 实例*/
- (id)initwithCarsInfoParam:(NSMutableArray *)carsInfoParam
{
    self = [super init];
    if ( self ) {
        NSMutableDictionary *carInfoDics = [[NSMutableDictionary alloc] init];
        NSString *key;
        for ( CarInfo *theCarInfo in carsInfoParam ){
            key = theCarInfo.carNo;
            [carInfoDics setObject:theCarInfo forKey:key];
        }
        
        self.cars = carInfoDics;
        [carInfoDics release];
    }
    
    return self;
}

/**获取单利
 *@param nil
 *return _instance:单利*/
+ (CMCars *)getInstance
{
    @synchronized(self){
        if ( !_instance ) {
            _instance = [[CMCars alloc] init];
        }
    }
    
    return _instance;
}

/**获取所有key值(车牌号)
 *@param nil
 *return 所有车牌号*/
- (NSArray *)carNos
{
    NSMutableArray *carNos = [[[NSMutableArray alloc] init] autorelease];
    for ( id key in self.cars ) {
        [carNos addObject:key];
    }
    
    return [NSArray arrayWithArray:carNos];
}

/**获取所有终端号
 *@param nil
 *return 所有车终端号*/
- (NSArray *)terminalNos
{
    NSMutableArray *terminalNos = [[[NSMutableArray alloc] init] autorelease];
    for ( id key in self.cars ){
        CarInfo *theCarInfo = [self.cars objectForKey:key];
        [terminalNos addObject:theCarInfo.terminalNo];
    }
    
    return [NSArray arrayWithArray:terminalNos];
}

/**由车牌获取车辆信息
 *@param carNo:车牌号
 *return theCarInfo:车辆信息*/
- (CarInfo *)theCarInfo:(NSString *)carNo
{
    return [self.cars objectForKey:carNo];
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