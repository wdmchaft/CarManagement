//
//  CMGlobalMacros.h
//  CarManagement
//
//  Created by YongFeng.li on 12-3-26.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#ifndef CarManagement_CMGlobalMacros_h
#define CarManagement_CMGlobalMacros_h

#define CM_RELEASE_SAFELY(__POINTER) [__POINTER  release]

/*
 * 内容区导航条高度
 */
#define CONTENT_NAVIGATIONBAR_HEIGHT 44

/*
 *NavBar可扩展按钮数量
 */
#define MAX_EXTEND_BUTTONS_COUNT 3

/*
 *全屏宽度
 */
#define FULL_SCREEN_WIDTH 320

/*
 *全屏高度
 */
#define FULL_SCREEN_HEIGHT 480

/*
 * 导航条动画时间
 */
#define NAVIGATIONBAT_ANIMATION_TIMEINTERVAL 0.5

/*
 * 导航扩展页动画时间
 */
#define NAVIGATION_EXTEND_ANIMATION_TIMEINTEVAL 0.5

/*
 * 华文黑体-light
 */
#define LIGHT_HEITI_FONT @"STHeitiSC-Light"

/*
 * 华文黑体-medium
 */
#define MED_HEITI_FONT @"STHeitiSC-Medium"

#define RN_DEBUG_LOG NSLog(@"-------%s---%d",__FUNCTION__,__LINE__)

#endif
