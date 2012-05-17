//
//  CMConfig.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "CMConfig.h"

@implementation CMConfig

static CMConfig *_globalConfig = nil;
@synthesize svnMapUrl = _svnMapUrl;
@synthesize svnMapUrl1 = _svnMapUrl1;
@synthesize svnMapUrl2 = _svnMapUrl2;
@synthesize oriSvnMapUrl = _oriSvnMapUrl;


- (void)dealloc
{
    self.svnMapUrl = nil;
    self.svnMapUrl1 = nil;
    self.svnMapUrl2 = nil;
    self.oriSvnMapUrl = nil;
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if ( self)  {
        self.svnMapUrl = @"http://www.fatmanager.cn/maplite/TDtu";
        self.svnMapUrl1 = @"http://www.fatmanager.cn/maplite/TDtu1";
        self.svnMapUrl2 = @"http://www.fatmanager.cn/maplite/TDtu2";
        self.oriSvnMapUrl = @"http://tile2.tianditu.com/DataServer?T=";
    }
    
    return self;
}

/**获取全局实例
 *@param nil
 *return nil*/
+ (CMConfig *)globalConfig
{
    if ( !_globalConfig ) {
        _globalConfig = [[CMConfig alloc] init];
    }
    
    return _globalConfig;
}

@end
