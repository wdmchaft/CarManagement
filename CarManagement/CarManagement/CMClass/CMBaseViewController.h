//
//  CMBaseViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-5.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMNavigationBar.h"

@protocol BaseViewControllerDelegate <NSObject>

- (void)popBackToMainViewController:(BOOL)animated;

@end

@interface CMBaseViewController : UIViewController
{
    CMNavigationBar *_navBar;
    
    id<BaseViewControllerDelegate> _baseViewControllerDelegate;
}

@property (nonatomic,retain) CMNavigationBar *navBar;
@property (nonatomic,assign) id<BaseViewControllerDelegate> baseViewControllerDelegate;

/**设置navBar的显示或隐藏
 *@param hidden:是否隐藏 animated:动画
 *return nil*/
- (void)setNavBarHidden:(BOOL)hidden animated:(BOOL)animated;
@end
