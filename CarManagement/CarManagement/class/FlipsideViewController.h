//
//  FlipsideViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-3-25.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;

@end

@interface FlipsideViewController : BaseViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    UILabel *_ipLabel;
    
    UITextField *_ipField;
    
    UILabel *_portLabel;
    
    UITextField *_portField;
    
    UITableView *_settingView;
}

@property (assign, nonatomic)id <FlipsideViewControllerDelegate> delegate;

@property (nonatomic,retain) UILabel *ipLabel;

@property (nonatomic,retain) UITextField *ipField;

@property (nonatomic,retain) UILabel *portLabel;

@property (nonatomic,retain) UITextField *portField;

@property (nonatomic,retain) UITableView *settingView;

//产生文本输入框
+ (UITextField*)textInputFieldForCellWithValue:(NSString*)value secure:(BOOL)secure;

//产生包含label的view
- (UIView*)containerCellWithTitle:(NSString*)title view:(UIView*)view;

@end
