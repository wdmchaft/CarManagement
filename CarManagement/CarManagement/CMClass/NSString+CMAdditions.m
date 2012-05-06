//
//  NSString+CMAdditions.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//



#import "NSString+CMAdditions.h"

#define kLoginSuccess               @"0;3;1;1"
#define kLoginWithPasswordWrong     @"0;3;1;0"
#define kLoginWithAccountNotExist   @""
#define kLoginWithServerIpWrong     @""
#define kLoginWithServerPortWrong     @""

#define kCarInfoRequestError        @""
#define kCarInfoRequestSuccess      @""

#define kTakePhotoSuccess           @""
#define kTakePhotoFailure           @""

#define kQueryHistoryTrackSuccess   @""
#define kQueryHistoryTrackFailure   @""

#define kOilAnalysisSuccess         @""
#define kOilAnalysisFailure         @""

@implementation NSString(CMAdditions)

/*登陆口令
 *@param userAccount:账号 userPassword:密码
 *return loginParam:登陆口令*/
+ (NSString *)createLoginParam:(NSString *)userAccount password:(NSString *)userPassword
{
    NSString *loginParam = [[NSString alloc] initWithFormat:@"$187:%@:%@:11",userAccount,userPassword];
    
    return [loginParam autorelease];
}

/**请求车辆信息口令
 *@param
 *return*/
+ (NSString *)createRequireCarInfoParam:(NSString *)carId
{
    return  nil;
}

/**拍照口令
 *@param terminalId:终端编号 cameraType:摄像头类型(前置/后置)
 *return takePhoteParam:拍照口令*/
+ (NSString *)createTakePhotoParam:(NSString *)terminalId cameraType:(CMCameraType)cameraType;
{
    NSString *takePhotoParam = [[NSString alloc] initWithFormat:@"60:+%@+:$GETPHOTO:+1+1+,+%d+,+1",cameraType];
    
    return [takePhotoParam autorelease];
}

/**查询历史轨迹
 *@param terminalId:终端编号 beginTime:开始时间 endTime:结束时间
 *return queryHistoryTrackParam:查看历史轨迹口令*/
+ (NSString *)createQueryHistoryTrackParam:(NSString *)terminalId beginTime:(NSString *)beginTime endTime:(NSString *)endTime
{
    NSString *queryHistoryTrackParam = [[NSString alloc] initWithFormat:@"and1:%@:%@",beginTime,endTime];
    
    return [queryHistoryTrackParam autorelease];

}

/**油量分析
 *@param terminalId:终端编号 beginTime:开始时间 endTime:结束时间
 *return oilAnalysis*/
+ (NSString *)createOilAnalysisParam:(NSString *)terminalId beginTime:(NSString *)beginTime endTime:(NSString *)endTime
{
    NSString *oilAnalysisParam = [[NSString alloc] initWithFormat:@"and2:%@:%@",beginTime,endTime];
    
    return [oilAnalysisParam autorelease]; 

}

/**登陆返回解析
 *@param recv:登陆后接收到的数据
 *return */
+ (NSMutableArray *)parseLoginRecv:(NSString *)recv
{
    NSMutableArray *param = [[NSMutableArray alloc] init];
    if ( [recv hasPrefix:kLoginWithAccountNotExist] ) {
        [param addObject:[NSString stringWithFormat:@"%d",CMLoinResultTypeAcountNotExist]];
    }
    else if ( [recv hasPrefix:kLoginWithPasswordWrong] ) {
        [param addObject:[NSString stringWithFormat:@"%d",CMLoinResultTypePasswordWrong]];
    }
    else if ( [recv hasPrefix:kLoginWithServerIpWrong] ) {
        [param addObject:[NSString stringWithFormat:@"%d",CMLoinResultTypeServerIpWrong]];
    }
    else if ( [recv hasPrefix:kLoginWithServerPortWrong] ) {
        [param addObject:[NSString stringWithFormat:@"%d",CMLoinResultTypeServerPortWrong]];
    }
    else if ( [recv hasPrefix:kLoginSuccess] ) {
        [param addObject:[NSString stringWithFormat:@"%d",CMLoinResultTypeSuccess]];
        
        NSArray *semicolonArray = [recv componentsSeparatedByString:@";"];
        [param addObject:[semicolonArray objectAtIndex:1]];//第一个字段位公司名称
        NSString *carsInfo = [semicolonArray objectAtIndex:2];
        NSArray *carInfoArray = [carsInfo componentsSeparatedByString:@","];
        for ( NSString *carInfos in carInfoArray ) {
            NSArray *carDetailInfo = [carInfos componentsSeparatedByString:@":"];
            [param addObject:carDetailInfo];
        }
    }
    
    return [param autorelease];
}

/**车辆信息请求返回解析
 *@param recv:车辆信息请求接收到的数据
 **/
+ (NSArray *)parseRequestCarInfoRecv:(NSString *)recv
{

}

/**拍照返回数据解析
 *@param recv:拍照接收到的数据
 **/
+ (NSArray *)takePhotoRecv:(NSString *)recv
{

}

/**查询历史轨迹返回数据解析
 *@param recv:历史轨迹接收到的数据
 **/
+ (NSArray *)historyTrackRecv:(NSString *)recv
{

}

/**剩余油量返回解析
 *@param recv:查询剩余油量接收到的数据
 **/
+ (NSArray *)oilAnalysis:(NSString *)recv
{
   
}
@end
