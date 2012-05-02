//
//  AppDelegate.h
//  CarManagement
//
//  Created by YongFeng.li on 12-3-25.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    LoginViewController *_loginViewController;
    
    UINavigationController *_rootViewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LoginViewController *loginViewController;
@property (nonatomic,retain) UINavigationController *rootViewController;
// push指定的modelViewController
- (void)pushModelViewController:(UIViewController *)viewController;
// pop顶层的modelViewController
- (void)popModelViewController;

@end
