//
//  CMUser.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-5.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "CMUser.h"

@interface CMUser(Private)

/**读取持久化数据user
 *@param userAccount:用户账号
 *return nil*/
+ (CMUser *)readFromDisk:(NSString *)userAccount;

/**持久化路径
 *@param userAccount:用户名
 *return path:归档文件路径*/
+ (NSString *)persistPath:(NSString *)userAccount;

@end

static CMUser *_instance = nil;

@implementation CMUser

@synthesize userAccount = _userAccount;
@synthesize userPassword = _userPassword;
@synthesize serverIpAddress = _serverIpAddress;
@synthesize serverIpPort = _serverIpPort;

- (void)dealloc
{
    [_userAccount release];
    [_userPassword release];
    [_serverIpAddress release];
    [_serverIpPort release];
    
    [super dealloc];
}


- (id)init
{
    self = [super init];
    
    return self;
}

+ (CMUser *)getInstance
{
    @synchronized(self){
        if ( !_instance ) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *userAccount = [defaults objectForKey:kLastUserAccount];
            
            if ( userAccount ) {
                _instance = [CMUser readFromDisk:userAccount];
                if ( !_instance ) {
                    [[CMUser alloc] init];
                }
            }
            else {
                [[CMUser alloc] init];
            }
            
        }
    }
    
    return _instance;
}

/**APP Document路径
 *@param nil
 *return nil*/
+ (NSString *)documentPath
{
    NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [searchPath objectAtIndex:0];
    
    return path;
}

/**持久化存档
 *@param nil
 *return nil*/
- (void)persist
{
    NSString *docName = self.userAccount;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:docName forKey:kLastUserAccount];
    
    if ( docName ) {
        NSString *persisPath = [CMUser persistPath:docName];
        [NSKeyedArchiver archiveRootObject:self toFile:persisPath];
    }
}

/**登陆信息
 *@param nil
 *return YES:有登陆信息 NO:无*/
- (BOOL)checkLoginInfo
{
    if ( self.userAccount && self.userPassword ) {
        return YES;
    }
    
    return NO;
}

#pragma private method
/**持久化路径
 *@param userAccount:用户名
 *return path:归档文件路径*/
+ (NSString *)persistPath:(NSString *)userAccount
{
    NSString *dirPath = [[CMUser documentPath] stringByAppendingPathComponent:userAccount];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ( ![fileManager fileExistsAtPath:dirPath] ) {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:dirPath
               withIntermediateDirectories:YES 
                                attributes:nil
                                     error:&error];
        
        if ( error ) {
            NSLog(@"创建失败~");
        }
    }
    
    NSString *path = [dirPath stringByAppendingPathComponent:kMainUserFileName];
    
    return path;
}

/**读取持久化数据user
 *@param userAccount:用户账号
 *return nil*/
+ (CMUser *)readFromDisk:(NSString *)userAccount
{
    NSString *userFile = [CMUser persistPath:userAccount];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:userFile];
}
@end
