//
//  CarInfo.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-7.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInfo : NSObject
{
    NSString *_companyName;
	NSString *_angentId;
	NSString *_terminalNo;
    NSString *_carNo;
    CMCarType _carType;
    NSInteger _cameraNum;
    NSArray *_drivers;
    NSArray *_phones;
    
    //lastPhoto info
    NSString *_lastPhotoName;
	NSInteger *_lastPhotoTime;
    UIImage *_lastPhoto;

}
@property (nonatomic,copy) NSString *companyName;
@property (nonatomic,copy) NSString *angentId;
@property (nonatomic,copy) NSString *terminalNo;
@property (nonatomic,copy) NSString *carNo;
@property (nonatomic,copy) NSString *lastPhotoName;
@property (nonatomic,copy) NSString *lastPhotoTime;
@property (nonatomic,retain) UIImage *lastPhoto;
@property (nonatomic) CMCarType carType;
@property (nonatomic) NSInteger cameraNum;
@property (nonatomic,retain) NSArray *drivers;
@property (nonatomic,retain) NSArray *phones;
@property (nonatomic) BOOL hasNewPhoto;
@end

@interface CMCars : NSObject
{
    NSArray *_cars;
}

@property (nonatomic,retain) NSArray *cars;

@end