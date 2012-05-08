//
//  NSString+CMAdditions.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//



#import "NSString+CMAdditions.h"

#define kLoginSuccess               @"0;3;1;1"
#define kLoginWithPasswordWrong     @"0,3,1,0"
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

/**请求车辆信息口令1
 *@param
 *return*/
+ (NSString *)createRequireCarInfoFirstParam:(NSArray *)carNos
{
    NSString *param = [NSString stringWithFormat:@"1:"];
    NSString *part;
    for ( NSString *carNo in carNos ) {
        part = [NSString stringWithFormat:@"%@,-1;",carNo];
        param = [param stringByAppendingString:part];
    }
    
    return  param;
}

/**请求车辆信息口令2
 *@param
 *return*/
+ (NSString *)createRequireCarInfoSecondParam:(NSArray *)carNos
{
    NSString *param = [NSString stringWithFormat:@"2:"];
    NSString *part;
    for ( NSString *carNo in carNos ) {
        part = [NSString stringWithFormat:@"%@,-1;",carNo];
        param = [param stringByAppendingString:part];
    }
    
    return  param;
}


/**拍照口令
 *@param terminalId:终端编号 cameraType:摄像头类型(前置/后置)
 *return takePhoteParam:拍照口令*/
+ (NSString *)createTakePhotoParam:(NSString *)terminalId cameraType:(CMCameraType)cameraType;
{
    NSString *takePhotoParam = [[NSString alloc] initWithFormat:@"60:%@:$GETPHOTO:1,%d,1",cameraType];
    
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
 *return param:车辆信息数组，第一个字段为登陆返回码;第二字段为公司名称;之后为车辆信息数组 */
+ (NSMutableArray *)parseLoginRecv:(NSString *)recv
{
    NSMutableArray *param = [[NSMutableArray alloc] init];
    NSMutableArray *carsParam = [[NSMutableArray alloc] init];
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
        [param addObject:[semicolonArray objectAtIndex:4]];//第一个字段位公司名称
        NSString *carsInfo = [semicolonArray objectAtIndex:5];
        NSArray *carInfoArray = [carsInfo componentsSeparatedByString:@","];
        for ( NSString *carInfos in carInfoArray ) {
            NSArray *carDetailInfo = [carInfos componentsSeparatedByString:@":"];
            //[param addObject:carDetailInfo];
            CarInfo *theCarInfo = [[CarInfo alloc] initWithParam:carDetailInfo];
            [carsParam addObject:theCarInfo];
        }
        
        CMCars *cars = [[[CMCars alloc] initwithCarsInfoParam:carsParam] autorelease];
        NSLog(@"cars = %@",cars);
    }
    [carsParam release];
    NSLog(@"param = %@",param);
    return [param autorelease];
}

/**车辆信息请求返回解析
 *@param recv:车辆信息请求接收到的数据
 *return terminalNos:终端号码数组*/
+ (NSMutableArray *)parseRequestCarInfoRecv:(NSString *)recv
{
    NSMutableArray *param = [[NSMutableArray alloc] init];
    NSMutableArray *terminalNos = [[NSMutableArray alloc] init];
    //冒号分割
    NSArray *colonArray = [recv componentsSeparatedByString:@":"];
    //逗号分割
    NSArray *commaArray = [[colonArray objectAtIndex:1] componentsSeparatedByString:@","];
    NSLog(@"commArray = %@",commaArray);
    for ( NSString *currentCarInfos in commaArray ) {
        //分号分割
        if ( ![currentCarInfos isEqualToString:@""] ) {
            NSArray *currentCarInfoParam = [currentCarInfos componentsSeparatedByString:@";"];
            CurrentCarInfo *currentCarInfo = [[CurrentCarInfo alloc] initWithParam:currentCarInfoParam];
            [terminalNos addObject:currentCarInfo.terminalNo];
            [param addObject:currentCarInfo];
        }
    }
    
    CMCurrentCars *currentCars = [[[CMCurrentCars alloc] initWithCurrentCarInfoParam:param] autorelease];
    NSLog(@"currentCars = %@",currentCars);
    [param release];
    
    return [terminalNos autorelease];
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

/**获取对应车类型的车图片
 *@param carType:车类型
 *return key:对应车类型的图片的key*/
+ (NSString *)carImage:(CMCarType)carType
{
    NSString *key = [[NSString alloc] init];
    if ( carType == CMCarTypeCar ) {
        key = @"car_red";
    }
    else if ( carType == CMCarTypeCrane ) {
        key = @"crane";
    }
    else if ( carType == CMCarTypeTruck ) {
        key = @"truck";
    }
    
    return [key autorelease];
}

/**获取对应车类型的车图片
 *@param carType:车类型
 *return keys:对应车类型的图片的keys*/

@end
