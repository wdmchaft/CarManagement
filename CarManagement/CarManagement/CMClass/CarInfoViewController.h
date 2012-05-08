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

@interface CarInfoViewController : CMBaseViewController<UINavigationControllerDelegate,UIScrollViewDelegate>
{
    UIButton *_backBtn;
    
    NSString *_terminalNo;
    
    UIScrollView *_carInfoDisplayView;
    
    //车照片
    UIImageView *_carImgView;
}

@property (nonatomic,retain) UIButton *backBtn;
@property (nonatomic,copy) NSString *terminalNo;
@property (nonatomic,retain) UIScrollView *carInfoDisplayView;
@property (nonatomic,retain) UIImageView *carImgView;


/**初始化
 *@param terminalNo:终端号码
 *return self*/
- (id)initWithTerminalNo:(NSString *)terminalNoParam;

@end
