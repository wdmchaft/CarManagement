//
//  CMResManager.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "CMResManager.h"

@implementation CMResManager

static CMResManager *_instance = nil;
@synthesize imageResourceBundle = _imageResourceBundle;

- (void)dealloc
{
    [_imageResourceBundle release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    return self;
}

+ (CMResManager *)getInstance
{
    @synchronized(self){
        if ( _instance == nil ) {
            [[CMResManager alloc] init];
        }
    }
    
    return _instance;
}

#pragma mark - 通过key获取图片资源
/**获取图片资源
 *@param key:图片名(不含后缀)
 *@return nil*/
- (UIImage *)imageForKey:(NSString *)key
{
    NSBundle *imageBundle = [self getImageBundle:IMAGE_BUNDLE];
    NSString *imagePath = [imageBundle pathForResource:key ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
    return [image autorelease];
}

/**获取图片资源包
 *@param nil
 *return nil*/
- (NSBundle *)getImageBundle:(NSString *)sourceName
{
    if ( !_imageResourceBundle ) {
        NSString *imageBundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:sourceName];
        _imageResourceBundle = [[NSBundle alloc] initWithPath:imageBundlePath];
        
    }
    
    return _imageResourceBundle;
}

/**直接获取图片资源
 *@param name:图片名
 *@return nil*/
- (UIImage *)imageForName:(NSString *)name
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Image" ofType:@"bundle"]];
    NSString * sourcePath = [bundle pathForResource:name ofType:@"png"]; 
    UIImage *image = [UIImage imageWithContentsOfFile:sourcePath];
    
    return image;
}

@end