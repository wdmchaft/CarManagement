//
//  MainViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UISearchBar *_searchBar;
    
    UITableView *_carInfoTView;
    
    UIBarButtonItem *_refreshBtn;
    
    UITabBar *_toolBar;
    
    NSMutableArray *_carInfoKind;
    
    NSMutableDictionary *_carInfoDics;
    
    NSString *_companyName;
    
    NSMutableArray *_carIDs;
    
    NSMutableArray *_searchResult;
}

@property (nonatomic,retain) UISearchBar *searchBar;
@property (nonatomic,retain) UITableView *carInfoTView;
@property (nonatomic,retain) UIBarButtonItem *refreshBtn;
@property (nonatomic,retain) UITabBar *toolBar;
@property (nonatomic,copy) NSString *companyName;
@property (nonatomic,retain) NSMutableArray *carInfoKind;
@property (nonatomic,retain) NSMutableDictionary *carInfoDics;
@property (nonatomic,retain) NSMutableArray *carIDs;
@property (nonatomic,retain) NSMutableArray *searchResult;
@property (nonatomic) BOOL isSearchOn;
@property (nonatomic) BOOL canSelectRow;

/**初始化
 *@param param:初始化参数
 *return nil*/
- (id)initWithParam:(NSMutableArray *)param;
@end
