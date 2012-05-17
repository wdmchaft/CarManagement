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
    NSString *_svnMapUrl;
    NSString *_svnMapUrl1;
    NSString *_svnMapUrl2;
    NSString *_oriSvnMapUrl;
    
}

@property (nonatomic,copy) NSString *svnMapUrl;
@property (nonatomic,copy) NSString *svnMapUrl1;
@property (nonatomic,copy) NSString *svnMapUrl2;
@property (nonatomic,copy) NSString *oriSvnMapUrl;



@end
