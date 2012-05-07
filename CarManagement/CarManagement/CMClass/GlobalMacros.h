//
//  GlobalMacros.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-5.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#ifndef CarManagement_GlobalMacros_h
#define CarManagement_GlobalMacros_h

typedef enum
{
    CMCameraTypeFront = 1,
    CMCameraTypeRear,
}CMCameraType;

typedef enum
{
    CMLoinResultTypeSuccess = 1,
    CMLoinResultTypeAcountNotExist,
    CMLoinResultTypePasswordWrong,
    CMLoinResultTypeServerIpWrong,
    CMLoinResultTypeServerPortWrong,
}CMLoginREsultType;

typedef enum
{
    CMCarTypeCar = 2,
    CMCarTypeCrane,
    CMCarTypeTruck,
}CMCarType;


#define NAVIGATIONBAR_ANIMATION_TIMINTERVAL     0.5

#define kLastUserAccount            @"LastUserAccount"
#define kLastUserPassword           @"LastUserPassword"
#define kLastServerIpAddress        @"LastServerIpAddress"
#define kLastServerIpPort           @"LastServerIpPort"
#define kMainUserFileName           @"user"
#define kFullScreenWidth            320.0
#define kFullScreenHight            460.0
#define kContentWithoutBarWidth     320.0
#define kContentWithoutBarHight     420.0
#define kAlertTitleDefault          @"胖总管提醒您"
#define kCMNavigationBarHight       44
//for detail
#define kCarInfoItemTag             199
#define kContactsItemTag            200
#define kHistoryTrackItemTag        201
#define kLocationMapItemTag         202
#define kTackPhotoItemTag           203
//关于car的key
#define key                         k 

#endif
