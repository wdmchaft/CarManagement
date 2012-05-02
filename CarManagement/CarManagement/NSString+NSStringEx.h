//
//  NSString+NSStringEx.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-2.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString(NSStringEx)
/**
 * 将字符串MD5加密.
 * 
 * @return 加密后的字符串.
 */
- (NSString*) md5;
@end
