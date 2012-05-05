//
//  LoginViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "LoginViewController.h"
#import "SettingViewController.h"
#import "CMResManager.h"
#import "AppDelegate.h"
//test
#import "CMBaseViewController.h"

#define kAlertLoginMsgLoss              2000
#define kAlertServerMsgLoss             2001
#define kLoginInputViewTopY             130
#define kLoginInputViewBottomY          220

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize logoImageView = _logoImageView;
@synthesize loginInputView = _loginInPutView;
@synthesize loginIndicatorView = _loginIndicatorView;
@synthesize userAccountField = _userAccountField;
@synthesize userPasswordField = _userPasswordField;
@synthesize loginBtn = _loginBtn;
@synthesize settingBtn = _settingBtn;
@synthesize reserveTView = _reserveTView;
@synthesize socket = _socket;

- (void)dealloc
{
    [_logoImageView release];
    [_loginInPutView release];
    [_loginIndicatorView release];
    [_userAccountField release];
    [_userPasswordField release];
    [_loginBtn release];
    [_settingBtn release];
    [_reserveTView release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    //0.0 self.view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kFullScreenWidth, kFullScreenHight)];
    view.backgroundColor = [UIColor whiteColor];
    //self.navigationController.navigationBarHidden =  YES;
    
    //1.0 logoImage
    UIImage *image = [[CMResManager getInstance] imageForKey:@"logo"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 40, 90, 80)];
    [imageView setImage:image];
    imageView.userInteractionEnabled = YES;
    self.logoImageView = imageView;
    [view addSubview:self.logoImageView];
    [imageView release];
    
    //2.0登陆背景
    UIView *loginInputView = [[UIView alloc] initWithFrame:CGRectMake(30, 130, 260, 90)];
    UIImage *loginBackgroundImg = [[CMResManager getInstance] imageForKey:@"input_background"];
    [loginInputView setBackgroundColor:[UIColor colorWithPatternImage:loginBackgroundImg]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //2.1账号输入框
    UITextField *userAccountField = [[UITextField alloc] initWithFrame:CGRectMake(48, 5, 201, 40)];
    userAccountField.backgroundColor = [UIColor clearColor];
    userAccountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    userAccountField.placeholder = @"账号";
    userAccountField.text = [defaults objectForKey:kLastUserAccount];
    userAccountField.autocorrectionType = UITextAutocorrectionTypeNo;
    userAccountField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userAccountField.keyboardType = UIKeyboardTypeASCIICapable;
    userAccountField.textAlignment = UITextAlignmentLeft;
    userAccountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userAccountField.returnKeyType = UIReturnKeyDone;
    self.userAccountField = userAccountField;
    self.userAccountField.delegate = self;
    [loginInputView addSubview:self.userAccountField];
    [userAccountField release];
    
    //2.2密码输入框
    UITextField *userPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(48,45, 201, 40)];
    userPasswordField.backgroundColor = [UIColor clearColor];
    userPasswordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    userPasswordField.placeholder = @"密码";
    userPasswordField.text = [defaults objectForKey:kLastUserPassword];
    userPasswordField.autocorrectionType = UITextAutocorrectionTypeNo;
    userPasswordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userPasswordField.keyboardType = UIKeyboardTypeASCIICapable;
    userPasswordField.textAlignment = UITextAlignmentLeft;
    userPasswordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userPasswordField.secureTextEntry = YES;
    userPasswordField.returnKeyType = UIReturnKeyGo;
    self.userPasswordField = userPasswordField;
    self.userPasswordField.delegate = self;
    [loginInputView addSubview:self.userPasswordField];
    [userPasswordField release];
    
    self.loginInputView = loginInputView;
    [view addSubview:self.loginInputView];
    [loginInputView release];
    
    //3.0设置按钮
    UIButton *settingBtn = [[UIButton buttonWithType:UIButtonTypeInfoDark] retain];
    settingBtn.frame = CGRectMake(250, 40, 40, 40);
    settingBtn.backgroundColor = [UIColor clearColor];
    [settingBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    self.settingBtn = settingBtn;
    [view addSubview:self.settingBtn];
    
    //4.0登陆button
    UIButton *loginBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    loginBtn.frame = CGRectMake(30, 230, 260, 40);
    
    UIImage *loginBtnImg = [CMResManager middleStretchableImageWithKey:@"btn_blue"];
    [loginBtn setBackgroundImage:loginBtnImg forState:UIControlStateNormal];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn = loginBtn;
    [view addSubview:self.loginBtn];
    [loginBtn release];
    
    //5.0登陆进度指示
    UIView *loginIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(30, 230, 260, 40)];
    loginIndicatorView.backgroundColor = [UIColor clearColor];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(70, 5, 30, 30);
    //indicator.backgroundColor = [UIColor clearColor];
    [indicator startAnimating];
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 100, 30)];
    msgLabel.backgroundColor = [UIColor clearColor];
    msgLabel.text = @"正在登陆...";
    [loginIndicatorView addSubview:indicator];
    [loginIndicatorView addSubview:msgLabel];
    [indicator release];
    [msgLabel release];
    self.loginIndicatorView = loginIndicatorView;
    self.loginIndicatorView.hidden = YES;
    [view addSubview:self.loginIndicatorView];
    [loginIndicatorView release];
    
    //6.0版权说明                                                                         
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
    AsyncSocket *socket = [[AsyncSocket alloc] initWithDelegate:self];
    self.socket = socket;
    [socket release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    self.userAccountField.enabled = YES;
    self.userPasswordField.enabled = YES;
    if ( !self.userAccountField ) {
        [self.userAccountField becomeFirstResponder];
    }
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
    self.userAccountField.enabled  = NO;
    self.userPasswordField.enabled = NO;
    self.settingBtn.enabled = NO;
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
//            AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            appdelegate.client.delegate = self;
//            NSError *error;
//            BOOL isConnected = [appdelegate.client connectToHost:serverIpAddress onPort:[serverIpPort intValue] withTimeout:5 error:&error];
//            if ( isConnected ) {////$187:super:181125:10
//                NSString *loginMsg = [NSString stringWithFormat:@"$187:%@:%@:11",user,pwd];
//                NSLog(@"loginMsg = %@",loginMsg);
//                NSData *loginMsgData = [loginMsg dataUsingEncoding:NSUTF8StringEncoding];
//                [appdelegate.client writeData:loginMsgData withTimeout:-1 tag:0];
//            }
            NSError *error = nil;
            if ( ![self.socket connectToHost:serverIpAddress onPort:[serverIpPort intValue] error:&error] ) {
                NSLog(@"error = %@",error.description);
            }
            else {
                [self loginAnimated]; 
                NSString *loginMsg = [NSString stringWithFormat:@"$187:%@:%@:11",user,pwd];
                NSLog(@"loginMsg = %@",loginMsg);
                NSData *loginMsgData = [loginMsg dataUsingEncoding:NSUTF8StringEncoding];
                [self.socket writeData:loginMsgData withTimeout:-1 tag:0];
            }
        }
    }
}

/**设置
 *@param nil
 *return nil*/
- (void)settingAction
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    [appdelegate pushViewController:settingViewController animate:YES];
    [settingViewController release];
}

/**登陆动画
 *@param nil
 *return nil*/
- (void)loginAnimated
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [self.loginBtn setAlpha:0.0];
    [self.loginIndicatorView setHidden:NO];
    [UIView commitAnimations];
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
    tip.tag = alertTag;
    [tip show];
    [tip release];
}

/**alertView按钮点击事件处理
 *@param alertView:当前alertView buttonIndex:点击第几个按钮
 **/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"alert Enter in LoginViewController");
    switch ( alertView.tag ) {
        case kAlertLoginMsgLoss:
        {
        
        }break;
        case kAlertServerMsgLoss:
        {
            [self settingAction];
            NSLog(@"kAlertServerMsgLoss");
            
        }break;
        default:NSLog(@"setp over~ alertView.tag = %d",alertView.tag);
            break;
    }
}

/**触摸事件
 *@param nil
 *return nil*/
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if ( point.y > kLoginInputViewTopY && point.y < kLoginInputViewTopY + 45 ) {
        [self.userAccountField becomeFirstResponder];
    }
    else if ( point.y > kLoginInputViewTopY + 45 && point.y < kLoginInputViewBottomY ) {
        [self.userPasswordField becomeFirstResponder];
    }
    else {
        [self.userAccountField resignFirstResponder];
        [self.userPasswordField resignFirstResponder];
    }
}

#pragma textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma AsyncSocket
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    [self.socket readDataWithTimeout:-1 tag:0];
    NSLog(@"didConnectToHost");
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err 
{
    NSLog(@"Error");
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"Sorry this connect is failure");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *recvMsg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"recvMsg = %@",recvMsg);
    [recvMsg release];
}

/**链接服务器
 *@param hostIp:服务器ip hostPort:服务器端口
 **/


@end
