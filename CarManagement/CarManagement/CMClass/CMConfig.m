//
//  CMConfig.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "CMConfig.h"
@implementation CMConfig
//
//
//static CMConfig *_globalConfig = nil;
//
//@implementation CMConfig
//@synthesize originalNormalCarWarn = _originalNormalCarWarn;
//@synthesize originalMixerCarWarn = _originalMixerCarWarn;
//@synthesize originalAntiTheftCarWarn = _originalAntiTheftCarWarn;
//
//- (void)dealloc
//{
//    self.originalNormalCarWarn = nil;
//    self.originalMixerCarWarn = nil;
//    self.originalAntiTheftCarWarn = nil;
//    
//    [super dealloc];
//}
//
//- (id)init
//{
//    self = [super init];
//    if ( self)  {
//        self.originalNormalCarWarn = @" ,掉电,GPS无信号, ,油门断开, ,停车,非法移动, , , , , ,断电,ACC开, ,短信报警开,Gprs报警开,越界报警,越界报警开, , ,超速,GPRS掉线, , , , ,加油, ,偷油,工作时间外驾车, , , , ,有人在岗";
//        self.originalMixerCarWarn = @" ,掉电,GPS无信号,搅拌,油门断开, ,停车,非法移动, ,卸料, , , ,断电,ACC开, ,短信报警开,Gprs报警开,越界报警,越界报警开, , ,超速, GPRS掉线, , , , ,加油, ,偷油,工作时间外驾车, , , , ,有人在岗";
//        self.originalAntiTheftCarWarn = @" ,掉电,GPS无信号,车子锁定,油门断开, ,停车,非法移动, ,车门开, , , ,断电,ACC开, ,短信报警开,Gprs报警开,越界报警,越界报警开, , ,超速,GPRS掉线, , , , ,加油, ,偷油,工作时间外驾车, , , , ,有人在岗";
//    }
//    
//    return self;
//}
//
///**获取全局实例
// *@param nil
// *return nil*/
//+ (CMConfig *)globalConfig
//{
//    if ( !_globalConfig ) {
//        _globalConfig = [[CMConfig alloc] init];
//    }
//    
//    return _globalConfig;
//}
//
///**普通车辆报警信息数组
// *@param nil
// *return param:普通车辆报警信息数组*/
//- (NSArray *)normalCarWarnParam
//{
//    NSArray *param = [[NSArray alloc] init];
//    param = [self.originalNormalCarWarn componentsSeparatedByString:@","];
//    
//    return [param autorelease];
//}
//
///**搅拌型车辆报警信息数组
// *@param nil
// *return param:搅拌型车辆报警信息数组*/
//- (NSArray *)mixerCarWarnParam
//{
//    NSArray *param = [[NSArray alloc] init];
//    param = [self.originalMixerCarWarn componentsSeparatedByString:@","];
//    
//    return [param autorelease];
//}
//
///**防盗车辆报警信息数组
// *@param nil
// *return param:防盗车辆报警信息数组*/
//- (NSArray *)antiTheftCarWarnParam
//{
//    NSArray *param = [[NSArray alloc] init];
//    param = [self.originalAntiTheftCarWarn componentsSeparatedByString:@","];
//    
//    return [param autorelease];
//}

@end
