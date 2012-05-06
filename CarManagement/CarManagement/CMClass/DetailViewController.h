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
    
    NSString *_carID;
    
    UITabBarController *_tabBarController;
}

@property (nonatomic,copy) NSString *carID;
@property (nonatomic,retain) UITabBarItem *CMTabBarItem;
@property (nonatomic,retain) UITabBar *toolBar;
@property (nonatomic,retain) UITabBarController *tabBarController;

/**初始化
 *@param param:车辆ID
 *return self*/
- (id)initwithParam:(NSString *)param;
@end
