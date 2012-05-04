//
//  CMResManager.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IMAGE_BUNDLE @"/Image.bundle"

@interface CMResManager : NSObject
{
    //图片资源bundle
    NSBundle *_imageResourceBundle;
}

@property (nonatomic,retain) NSBundle *imageResourceBundle;

/**获取图片资源
 *@param key:图片名(不含后缀)
 *@return nil*/
- (UIImage *)imageForKey:(NSString *)key;

/**直接获取图片资源
 *@param name:图片名
 *@return nil*/
- (UIImage *)imageForName:(NSString *)name;
@end

