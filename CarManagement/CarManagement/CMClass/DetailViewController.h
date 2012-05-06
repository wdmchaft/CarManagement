//
//  DetailViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITabBarDelegate>
{
    UITabBarItem *_CMTabBarItem;
    
    UITabBar *_toolBar;
    
    UITabBarController *_tabBarController;
}

@property (nonatomic,retain) UITabBarItem *CMTabBarItem;
@property (nonatomic,retain) UITabBar *toolBar;
@property (nonatomic,retain) UITabBarController *tabBarController;
@end
