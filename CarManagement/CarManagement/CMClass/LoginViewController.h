//
//  LoginViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    UIImageView *_logoImageView;
    
    UIView *_loginInPutView;
    
    UITextField *_userAccountField;
    
    UITextField *_userPasswordField;
    
    UIButton *_loginBtn;
    
    UIButton *_settingBtn;
    
    UITextView *_reserveTView;
    
    UIView *_logionIndicatorView;
    
    AsyncSocket *_socket;
    
    UINavigationController *_carInfoNavigationController;
}

@property (nonatomic,retain) UIImageView *logoImageView;
@property (nonatomic,retain) UIView *loginInputView;
@property (nonatomic,retain) UITextField *userAccountField;
@property (nonatomic,retain) UITextField *userPasswordField;
@property (nonatomic,retain) UIButton *loginBtn;
@property (nonatomic,retain) UIButton *settingBtn;
@property (nonatomic,retain) UITextView *reserveTView;
@property (nonatomic,retain) UIView *loginIndicatorView;
@property (nonatomic,retain) AsyncSocket *socket;
@property (nonatomic,retain) UINavigationController *carInfoNavigationController;

- (int)connectServer:(NSString *)hostIp port:(int)hostPort;
@end
