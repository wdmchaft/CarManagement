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

@interface TakePhotoViewController : CMBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *_backBtn;
    
    NSString *_terminalNo;
    
    UILabel *_photoInfoLabel;
    //车照片
    UIImageView *_carImgView;
    
    AsyncSocket *_socket;
    
    //加载车辆照片信息
    UIView *_photoLoadingView;
    UILabel *_photoLoadLabel;
    UIActivityIndicatorView *_photoLoadProcessView;
    
    UITableView *_callList;
}

@property (nonatomic,retain) UIButton *backBtn;
@property (nonatomic,copy) NSString *terminalNo;
@property (nonatomic,retain) UILabel *photoInfoLabel;
@property (nonatomic,retain) UIImageView *carImgView;
@property (nonatomic,retain) AsyncSocket *socket;

@property (nonatomic,retain) UIView *photoLoadingView;
@property (nonatomic,retain) UILabel *photoLoadLabel;
@property (nonatomic,retain) UIActivityIndicatorView *photoLoadProcessView;
@property (nonatomic,retain) UITableView *callList;
@property (nonatomic) BOOL isReadyCall;


/**初始化
 *@param terminalNo:终端号码
 *return self*/
- (id)initWithTerminalNo:(NSString *)terminalNoParam;

@end
