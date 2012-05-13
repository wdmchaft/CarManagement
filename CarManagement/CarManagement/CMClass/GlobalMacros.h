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
    CMCarTypeNormal = 1,
    CMCarTypeMixer,
    CMCarTypeAntiTheft,
}CMCarType;

typedef enum
{
    CMProcessLogin = 1,
    CMProcessRequireCarsInfoStateFirst,
    CMProcessRequireCarsInfoStateSecond,
    CMProcessRequireTheCarInfo,
    CMProcessQueryHistoryTrack,
    CMProcessQueryLeftOil,
    CMProcessTakePhoto,
}CMProcess;


#define NAVIGATIONBAR_ANIMATION_TIMINTERVAL     0.5

//数据保存相关
#define kLastUserAccount            @"LastUserAccount"
#define kLastUserPassword           @"LastUserPassword"
#define kLastServerIpAddress        @"LastServerIpAddress"
#define kLastServerIpPort           @"LastServerIpPort"
#define kMainUserFileName           @"user"
#define kCarPhotoFileName           @"photo"
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

//报警位(车辆状态相关)
#define INTERVAL                    1
#define LOSTPOWER                   2
#define LOSTGPS                     4
#define BELOCKED                    8
#define OILCUT                      16
#define USERALARM                   32
#define STOP                        64
#define BEMOVED                     128
#define GPSERROR                    256
#define DOOR                        512
#define HB                          1024
#define ANTI                        2048
#define EX1                         4096
#define CUTELE                      4096 * 2
#define ACC                         4096 * 4
#define SENDMESS                    32768
#define SENDSMS                     65536
#define OFFWARN                     65536 * 2
#define OVERCONTROL                 65536 * 4
#define ONCONTROL                   65536 * 8
#define LOGIN                       65536 * 16
#define BEMONITED                   65536 * 32
#define OVERSPEED                   65536 * 64 
#define LOSTGPRS                    65536 * 128
#define GPRSCHECK                   65536 * 256
#define BESTOP                      65536 * 512
#define MOVEIN                      65536 * 1024
#define ADDOIL                      65536 * 2048
#define ADDOILBEG                   65536 * 2048
#define ADDOILEND                   65536 * 4096
#define STOOILBEG                   65536 * 8192
#define STOOILEND                   65536 * 8192 * 2
#define WORKTIMEOUT                 65536 * 8192 * 4L
#define GPSOUT                      65536 * 8192 * 16L
#define BAOBEI                      65536 * 8192 * 32L
#define AWOL                        65536 * 8192 * 128L
#endif
