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
        self.companyName = [carInfo objectAtIndex:0];
        self.terminalNo = [carInfo objectAtIndex:1];
        self.carNo = [carInfo objectAtIndex:2];
        self.carSIMNo = [carInfo objectAtIndex:3];
        self.carType = [[carInfo objectAtIndex:4] intValue];
        self.cameraNum = [[carInfo objectAtIndex:5] intValue];
        Dirver *dirver1 = [[Dirver alloc] initWithParam:[carInfo objectAtIndex:6] tel:[carInfo objectAtIndex:7]];
        Dirver *dirver2 = [[Dirver alloc] initWithParam:[carInfo objectAtIndex:8] tel:[carInfo objectAtIndex:9]];
        self.drivers = [NSArray arrayWithObjects:dirver1,dirver2,nil];
        [dirver1 release];
        [dirver2 release];
        //self.
    }
    
    return self;
}

@end



@implementation CMCars
@synthesize cars = _cars;

/**
 *
 **/
- (id)initwithCarsInfoParam:(NSArray *)carsInfoParam
{

}

@end