//
//  LoginViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-3-25.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"
#import "Socket.h"

@interface LoginViewController : UIViewController<SettingViewControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    UIImageView *_picView;
    
    UITextField *_accountField;
    
    UITextField *_passwdField;
    
    UIButton *_settingBtn;
    
    UITextView *_msgTView;  
    
    UIButton *_loginBtn;
    
    Socket *_socketDef;
}

@property (nonatomic,retain) UIImageView *picView;
@property (nonatomic,retain) UITextField *accountField;
@property (nonatomic,retain) UITextField *passwdField;
@property (nonatomic,retain) UIButton *settingBtn;
@property (nonatomic,retain) UITextView *msgTView;
@property (nonatomic,retain) UIButton *loginBtn;
@property (nonatomic,retain) Socket *socketDef;


//产生文本输入框
+ (UITextField*)textInputFieldForCellWithValue:(NSString*)value secure:(BOOL)secure;

//产生包含label的view
- (UIView*)containerCellWithTitle:(NSString*)title view:(UIView*)view;

//收起键盘
- (void)pickUpTheKeyBorad;

//按键go
- (void)goAcction;

@end
