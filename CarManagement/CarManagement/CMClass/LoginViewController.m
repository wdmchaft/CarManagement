//
//  LoginViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "LoginViewController.h"
#import "CMResManager.h"

#define kAlertLoginMsgLoss              2000
#define kAlertServerMsgLoss             2001

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize logoImageView = _logoImageView;
@synthesize loginInputView = _loginInPutView;
@synthesize userAccountField = _userAccountField;
@synthesize userPasswordField = _userPasswordField;
@synthesize loginBtn = _loginBtn;
@synthesize reserveTView = _reserveTView;

- (void)dealloc
{
    [_logoImageView release];
    [_loginInPutView release];
    [_userAccountField release];
    [_userPasswordField release];
    [_loginBtn release];
    [_reserveTView release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    //0.0 self.view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kFullScreenWidth, kFullScreenHight)];
    view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden =  YES;
    
    //1.0 logoImage
    UIImage *image = [[CMResManager getInstance] imageForKey:@"logo"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 40, 100, 80)];
    [imageView setImage:image];
    self.logoImageView = imageView;
    [view addSubview:self.logoImageView];
    [imageView release];
    
    //2.0登陆背景
    UIView *loginInputView = [[UIView alloc] initWithFrame:CGRectMake(30, 130, 260, 90)];
    UIImage *loginBackgroundImg = [[CMResManager getInstance] imageForKey:@"input_background"];
    [loginInputView setBackgroundColor:[UIColor colorWithPatternImage:loginBackgroundImg]];
    
    //2.1账号输入框
    UITextField *userAccountField = [[UITextField alloc] initWithFrame:CGRectMake(48, 5, 201, 40)];
    userAccountField.backgroundColor = [UIColor clearColor];
    userAccountField.autocorrectionType = UITextAutocorrectionTypeNo;
    userAccountField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userAccountField.keyboardType = UIKeyboardTypeASCIICapable;
    userAccountField.textAlignment = UITextAlignmentLeft;
    self.userAccountField = userAccountField;
    self.userAccountField.delegate = self;
    [loginInputView addSubview:self.userAccountField];
    [userAccountField release];
    
    //2.2密码输入框
    UITextField *userPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(48,45, 201, 40)];
    userPasswordField.backgroundColor = [UIColor clearColor];
    userPasswordField.autocorrectionType = UITextAutocorrectionTypeNo;
    userPasswordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userPasswordField.keyboardType = UIKeyboardTypeASCIICapable;
    userPasswordField.textAlignment = UITextAlignmentLeft;
    self.userPasswordField = userPasswordField;
    self.userPasswordField.delegate = self;
    [loginInputView addSubview:self.userPasswordField];
    [userPasswordField release];
    
    self.loginInputView = loginInputView;
    [view addSubview:self.loginInputView];
    [loginInputView release];
    
    //3.0登陆button
    UIButton *loginBtn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    loginBtn.frame = CGRectMake(30, 230, 260, 40);
    UIImage *loginBtnImg = [CMResManager middleStretchableImageWithKey:@"btn_blue"];
    [loginBtn setImage:loginBtnImg forState:UIControlStateNormal];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn = loginBtn;
    [view addSubview:self.loginBtn];
    [loginBtn release];
    
    //4.0版权说明                                                                         
    UITextView *reserveTView = [[UITextView alloc] initWithFrame:CGRectMake(20, 400, 280, 60)];
    reserveTView.textAlignment = UITextAlignmentCenter;
    [reserveTView setText:@"Copyright 2012-2014©gpssos \nAll rights reserved."];
    reserveTView.editable = NO;
    self.reserveTView = reserveTView;
    [view addSubview:self.reserveTView];
    [reserveTView release];
    
    self.view = view;
    [view release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma buttonAction
/**登陆响应事件
 *@param nil
 *return nil*/
- (void)loginAction
{
    self.userAccountField.enabled  = FALSE;
    self.userPasswordField.enabled = FALSE;
    [self.userPasswordField resignFirstResponder];
    [self.userPasswordField resignFirstResponder];
    
    NSString *user = self.userAccountField.text;
    NSString *pwd = self.userPasswordField.text;
    
    if ( user == nil || pwd == nil || user.length == 0 || pwd.length == 0 ) {
        [self showAlert:kAlertLoginMsgLoss title:nil message:@"账号/密码不能为空"];
    }
    else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:user forKey:kLastUserAccount];
        [defaults setObject:pwd forKey:kLastUserPassword];
        NSString *serverIpAddress = [defaults objectForKey:kLastServerIpAddress];
        NSString *serverIpPort = [defaults objectForKey:kLastServerIpPort];
        
        if ( serverIpAddress == nil || serverIpPort == nil || serverIpAddress.length == 0 || serverIpAddress.length == 0 )
        {
            [self showAlert:kAlertServerMsgLoss title:nil message:@"请配置服务器信息"];
        }
        else {
            //登陆
        }
    }
}

/**提醒
 *@param
 *return nil*/
- (void)showAlert:(NSInteger)alertTag title:(NSString *)title message:(NSString *)message
{
    if ( !title ) {
        title = kAlertTitleDefault;
    }
    UIAlertView *tip = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [tip show];
    [tip release];
}
@end
