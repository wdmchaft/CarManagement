//
//  MainViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-3-25.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MainViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_contentView;
    NSMutableDictionary *_carInfoDic;
    NSMutableArray *_carType;
}

@property (nonatomic,retain) UITableView *contentView;
@property (nonatomic,retain) NSMutableDictionary *carInfoDic;
@property (nonatomic,retain) NSMutableArray *carType;

@end
