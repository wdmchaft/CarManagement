//
//  AppDelegate.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *_rootViewController;
    
    AsyncSocket *_client;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) UINavigationController *rootViewController;
@property (nonatomic,retain) AsyncSocket *client;

- (void)pushViewController:(UIViewController *)viewController animate:(BOOL)animate;

- (void)popViewController:(BOOL)animated;

- (void)presentModleViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end
