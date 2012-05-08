//
//  NSString+CMAdditions.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(CMAdditions)
/*登陆口令
 *@param userAccount:账号 userPassword:密码
 *return loginParam:登陆口令*/
+ (NSString *)createLoginParam:(NSString *)userAccount password:(NSString *)userPassword;

/**请求车辆信息口令1
 *@param
 *return*/
+ (NSString *)createRequireCarInfoFirstParam:(NSArray *)carNos;

/**请求车辆信息口令2
 *@param
 *return*/
+ (NSString *)createRequireCarInfoSecondParam:(NSArray *)carNos;

/**拍照口令
 *@param terminalId:终端编号 cameraType:摄像头类型(前置/后置)
 *return takePhoteParam:拍照口令*/
+ (NSString *)createTakePhotoParam:(NSString *)terminalId cameraType:(CMCameraType)cameraType;

/**查询历史轨迹
 *@param terminalId:终端编号 beginTime:开始时间 endTime:结束时间
 *return queryHistoryTrackParam:查看历史轨迹口令*/
+ (NSString *)createQueryHistoryTrackParam:(NSString *)terminalId beginTime:(NSString *)beginTime endTime:(NSString *)endTime;

/**油量分析
 *@param terminalId:终端编号 beginTime:开始时间 endTime:结束时间
 *return oilAnalysis*/
+ (NSString *)createOilAnalysisParam:(NSString *)terminalId beginTime:(NSString *)beginTime endTime:(NSString *)endTime;

/**车辆状态
 *@param staate:车辆状态码 
 *return param*/
+ (NSString *)createCarStateParam:(long)state;

/**登陆返回解析
 *@param recv:登陆后接收到的数据
 *return */
+ (NSMutableArray *)parseLoginRecv:(NSString *)recv;

/**车辆信息请求返回解析
 *@param recv:车辆信息请求接收到的数据
 *return nil*/
- (void)parseRequestCarInfoRecv:(NSString *)recv;

/**拍照返回数据解析
 *@param recv:拍照接收到的数据
 **/
+ (NSArray *)takePhotoRecv:(NSString *)recv;

/**查询历史轨迹返回数据解析
 *@param recv:历史轨迹接收到的数据
 **/
+ (NSArray *)historyTrackRecv:(NSString *)recv;

/**剩余油量返回解析
 *@param recv:查询剩余油量接收到的数据
 **/
+ (NSArray *)oilAnalysis:(NSString *)recv;

@end