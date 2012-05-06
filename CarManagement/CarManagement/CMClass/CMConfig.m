//
//  CMConfig.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "CMConfig.h"


static CMConfig *_instance = nil;

@implementation CMConfig

@synthesize loginParam = _loginParam;


- (void)dealloc
{
    self.loginParam = nil;
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if ( self)  {
        self.loginParam = @"";
        self.passwordWrongParam = @"0;3;1;0";
    }
    
    return self;
}

/**获取全局实例
 *@param nil
 *return nil*/
+ (CMConfig *)globalConfig
{
    if ( !_instance ) {
        _instance = [[CMConfig alloc] init];
    }
    
    return _instance;
}

@end
