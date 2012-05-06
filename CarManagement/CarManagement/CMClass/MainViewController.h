//
//  MainViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar *_searchBar;
    
    UITableView *_carInfoTView;
    
    UIBarButtonItem *_refreshBtn;
    
    UITabBar *_toolBar;
    
    NSMutableArray *_carInfoKind;
    
    NSMutableDictionary *_carInfoDics;
}

@property (nonatomic,retain) UISearchBar *searchBar;
@property (nonatomic,retain) UITableView *carInfoTView;
@property (nonatomic,retain) UIBarButtonItem *refreshBtn;
@property (nonatomic,retain) UITabBar *toolBar;

/**初始化
 *@param param:初始化参数
 *return nil*/
- (id)initWithParam:(NSArray *)param;
@end
