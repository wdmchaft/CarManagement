//
//  LoginViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    UIImageView *_logoImageView;
    
    UIView *_loginInPutView;
    
    UITextField *_userAccountField;
    
    UITextField *_userPasswordField;
    
    UIButton *_loginBtn;
    
    UITextView *_reserveTView;
}

@property (nonatomic,retain) UIImageView *logoImageView;
@property (nonatomic,retain) UIView *loginInputView;
@property (nonatomic,retain) UITextField *userAccountField;
@property (nonatomic,retain) UITextField *userPasswordField;
@property (nonatomic,retain) UIButton *loginBtn;
@property (nonatomic,retain) UITextView *reserveTView;
@end
