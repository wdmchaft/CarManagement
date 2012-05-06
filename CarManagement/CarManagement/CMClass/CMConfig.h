//
//  CMConfig.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMConfig : NSObject
{
    NSString *_loginParam;
    
    NSString *_passwordWrongParam;
}

@property (nonatomic,copy) NSString *loginParam;
@property (nonatomic,copy) NSString *passwordWrongParam;
//@property (nonatomic,copy) NSString *password;
//@property (nonatomic,copy) NSString *serverIpAddress;
//@property (nonatomic,copy) NSString *serverIpPort;
@end
