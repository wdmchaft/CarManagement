//
//  CarInfoViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMBaseViewController.h"
#import "DetailViewController.h"

@interface CarInfoViewController : CMBaseViewController<UINavigationControllerDelegate>
{
    UIButton *_backBtn;
}

@property (nonatomic,retain) UIButton *backBtn;

@end
