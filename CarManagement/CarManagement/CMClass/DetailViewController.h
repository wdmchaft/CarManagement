//
//  DetailViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMBaseViewController.h"

//@protocol DetailViewControllerDelegate <NSObject>
//
//- (void)popBackToMainView:(BOOL)animated;
//
//@end

@interface DetailViewController : UIViewController<UITabBarDelegate,BaseViewControllerDelegate>
{
    UITabBarItem *_CMTabBarItem;
    
    UITabBar *_toolBar;
    
    NSString *_carID;
    
    UITabBarController *_tabBarController;
    
//    id <DetailViewControllerDelegate> *_detailDelegate;
}

@property (nonatomic,copy) NSString *carID;
@property (nonatomic,retain) UITabBarItem *CMTabBarItem;
@property (nonatomic,retain) UITabBar *toolBar;
@property (nonatomic,retain) UITabBarController *tabBarController;
//@property (nonatomic,assign) id<DetailViewControllerDelegate> *detailDeleagte;

/**初始化
 *@param param:车辆ID
 *return self*/
- (id)initwithParam:(NSString *)param;
@end


