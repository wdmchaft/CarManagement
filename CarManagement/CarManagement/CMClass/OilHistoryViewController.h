//
//  HistoryTrackViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMBaseViewController.h"

@interface OilHistoryViewController : CMBaseViewController<UITextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    NSString *_terminalNo;
    
    UITextView *_oilHistoryView;
    
    UILabel *_titleLabel;
    
    UITextField *_dateBegin;
    
    UITextField *_dateEnd;
    
    UIView *_dateView;
    
    //-label
    UILabel *_segLabel;
    //日期选择
    UIDatePicker *_datePicker;
    CMDateChoiceProcess _dateChoiceProcess;
    
    //加载数据进度指示
    UIView *_loadView;
    UIActivityIndicatorView *_indicator;
    UILabel *_tipLabel;
    
    //通讯
    AsyncSocket *_socket;
}

@property (nonatomic,copy) NSString *terminalNo;
@property (nonatomic,retain) UITextView *oilHistoryView;
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UITextField *dateBegin;
@property (nonatomic,retain) UITextField *dateEnd;
@property (nonatomic,retain) UIView *dateView;
@property (nonatomic,retain) UILabel *segLabel;
@property (nonatomic,retain) UIView *pickerBackgroundView;
@property (nonatomic,retain) UIDatePicker *datePicker;
@property (nonatomic,retain) UIView *loadView;
@property (nonatomic,retain) UIActivityIndicatorView *indicator;
@property (nonatomic,retain) UILabel *tipLabel;
@property (nonatomic) CMDateChoiceProcess dateChoiceProcess;
@property (nonatomic,retain) AsyncSocket *socket;
/**初始化
 *@param terminalNo:终端号码
 *return self*/
- (id)initWithTerminalNo:(NSString *)terminalNoParam;

@end
