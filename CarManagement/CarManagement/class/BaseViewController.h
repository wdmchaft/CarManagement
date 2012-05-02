//
//  BaseViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-3-26.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavBar.h"

@interface BaseViewController : UIViewController
{
    NavBar *_navigationBar;
}

@property (nonatomic,retain) NavBar *navigationBar;

- (void)setNavigationBarLeftButtonBackground:(UIImage *)imageNormal
                                imageClicked:(UIImage *)imageClicked 
                       touchUpInSideSelector:(SEL)selector;

- (void)setNavigationBarTitle:(NSString *)title;

@end
