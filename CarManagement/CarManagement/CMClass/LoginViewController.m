//
//  LoginViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "LoginViewController.h"
#import "SettingViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "CMUser.h"
//test
#import "CMBaseViewController.h"
#define kLoginInputViewTopY             130
#define kLoginInputViewBottomY          220
#define kAlertLoginMsgLoss              2000
#define kAlertServerMsgLoss             2001
#define kAlertNetWorkUnusable           2002
#define kAlertAccountNotExist           2003
#define kAlertPasswordWrong             2004
#define kAlertServerIpWrong             2005
#define kAlertServerPortWrong           2006
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize carInfoNavigationController = _carInfoNavigationController;
@synthesize logoImageView = _logoImageView;
@synthesize loginInputView = _loginInPutView;
@synthesize loginIndicatorView = _loginIndicatorView;
@synthesize userAccountField = _userAccountField;
@synthesize userPasswordField = _userPasswordField;
@synthesize loginBtn = _loginBtn;
@synthesize settingBtn = _settingBtn;
@synthesize reserveTView = _reserveTView;
@synthesize socket = _socket;
@synthesize process = _process;
@synthesize companyName = _companyName;
@synthesize automaticLogin = _automaticLogin;


/**初始化
 *@param login:是否自动登陆
 *return self*/
- (id)initWithAutomaticLogin:(BOOL)login
{
    self = [super init];
    if ( self ) {
        _automaticLogin = login;
    }
    
    return self;
}

- (void)dealloc
{
    [_logoImageView release];
    [_carInfoNavigationController release];
    [_loginInPutView release];
    [_loginIndicatorView release];
    [_userAccountField release];
    [_userPasswordField release];
    [_loginBtn release];
    [_settingBtn release];
    [_reserveTView release];
    [_socket release];
    
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.logoImageView = nil;
    self.loginInputView = nil;
    self.userAccountField = nil;
    self.userPasswordField = nil;
    self.loginBtn = nil;
    
    self.settingBtn = nil;
    
    UITextView *_reserveTView;
    
    UIView *_logionIndicatorView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [self loginPrepareAnimated];
    [self.userAccountField becomeFirstResponder];
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.client.delegate = self;
    self.socket = [appdelegate.client retain];
    self.process = CMProcessLogin;
    
    if ( _automaticLogin ) {
        [self loginAction];
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
            NSLog(@"%@:%@",serverIpAddress,serverIpPort);
            NSError *error = nil;
            if ( ![self.socket connectToHost:serverIpAddress onPort:[serverIpPort intValue] error:&error] ) {
                NSLog(@"error = %@",error.description);
            }
            else {
                [self loginAnimated]; 
                NSString *loginParam = [NSString createLoginParam:user password:pwd];
                NSLog(@"loginMsg = %@",loginParam);
                NSData *loginMsgData = [loginParam dataUsingEncoding:NSUTF8StringEncoding];
                [self.socket writeData:loginMsgData withTimeout:-1 tag:0];
                //保存用户信息 line6
                CMUser *userInfo = [CMUser getInstance];
                userInfo.userAccount = user;
                userInfo.userPassword = pwd;
                userInfo.serverIpAddress = serverIpAddress;
                userInfo.serverIpPort = serverIpPort;
                [userInfo persist];
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
    [self.loginBtn setTitle:nil forState:UIControlStateNormal];
    [self.loginIndicatorView setHidden:NO];
    [UIView commitAnimations];
}

/**登陆准备
 *@param nil
 *return nil*/
- (void)loginPrepareAnimated
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
//    [self.loginBtn setAlpha:1.0];
    [self.loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [self.loginIndicatorView setHidden:YES];
    self.userAccountField.enabled = YES;
    self.userPasswordField.enabled = YES;
    self.settingBtn.enabled = YES;
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
            [self loginPrepareAnimated];
            [self.userPasswordField becomeFirstResponder];
        }break;
        case kAlertServerMsgLoss:
        {
            [self settingAction];
            NSLog(@"kAlertServerMsgLoss");
            
        }break;
        case kAlertNetWorkUnusable:
        {
            [self loginPrepareAnimated];
        }break;
        case kAlertPasswordWrong:
        {
            [self loginPrepareAnimated];
            [self.userPasswordField becomeFirstResponder];
            [self.socket disconnect];
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
    
    if ( textField == self.userPasswordField ) {
        [self loginAction];
    }
    
    return YES;
}

#pragma AsyncSocket
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    [self.socket readDataWithTimeout:-1 tag:0];
    [self.socket readDataWithTimeout:-1 tag:1];
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [appDelegate.client readDataWithTimeout:-1 tag:0];
//    if ( self.process == CMProcessLogin ) {
//        [self.socket readDataWithTimeout:-1 tag:0];
//    }
//    else if ( self.process == CMProcessRequireCarsInfoStateFirst ) {
//        [self.socket readDataWithTimeout:-1 tag:1];
//    }
    NSLog(@"didConnectToHost");
//    MainViewController *mainViewController = [[MainViewController alloc] init];
//    UINavigationController *carInfoNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
//    self.carInfoNavigationController = carInfoNavigationController;
//    [self presentModalViewController:carInfoNavigationController animated:NO];
//    [mainViewController release];
//    [carInfoNavigationController release];
    
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err 
{
    NSLog(@"Error");
    [self showAlert:kAlertNetWorkUnusable title:nil message:@"当前网络不可用，请检查后重新登陆"];
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"Sorry this connect is failure in LoginViewController");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{  
      NSLog(@"recvData = %@",data);
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString *recvMsg = [[NSString alloc] initWithData:data encoding:enc];
//    NSLog(@"recvMsg = %@",recvMsg);
    if ( self.process == CMProcessLogin ) {
//        NSLog(@"recvMsg = %@",recvMsg);
        NSMutableArray *carInfoArrays = [NSString parseLoginRecv:data];
        NSLog(@"Login return carInfoArrays = %@",carInfoArrays);
        CMLoginREsultType loginResultType = [[carInfoArrays objectAtIndex:0] intValue];
        switch ( loginResultType ) {
            case CMLoinResultTypeAcountNotExist:
            {
            
            }break;
            case CMLoinResultTypePasswordWrong:
            {
                [self showAlert:kAlertPasswordWrong title:nil message:@"您输入的密码有误，请重新输入"];
            }break;
            case CMLoinResultTypeServerIpWrong:
            {
            
            }break;
            case CMLoinResultTypeServerPortWrong:
            {
            
            }break;
            case CMLoinResultTypeSuccess:
            {
                
               //登陆成功
//             NSArray *carNos = [[CMCars getInstance] carNos];
                self.companyName = [carInfoArrays objectAtIndex:1];
                NSArray *terminalNos;
                terminalNos = [NSArray arrayWithArray:[[CMCars getInstance] terminalNos]];
                NSLog(@"terminalNos = %@",terminalNos);
                NSString *requireCarsInfoFirstParam = [NSString createRequireCarInfoFirstParam:terminalNos];
                NSLog(@"requireCarsInfoFirstParam = %@",requireCarsInfoFirstParam);
                NSData *requireCarsInfoFirstParamData = [requireCarsInfoFirstParam dataUsingEncoding:NSUTF8StringEncoding];
                [self.socket writeData:requireCarsInfoFirstParamData withTimeout:-1 tag:1];
                
//                NSString *requireCarsInfoSecondParam = [NSString createRequireCarInfoSecondParam:terminalNos];
//                NSLog(@"requireCarsInfoSecondParam = %@",requireCarsInfoSecondParam);
//                NSData *requireCarsInfoSecondParamData = [requireCarsInfoSecondParam dataUsingEncoding:NSUTF8StringEncoding];
//                [self.socket writeData:requireCarsInfoSecondParamData withTimeout:-1 tag:0];
                
                self.process = CMProcessRequireCarsInfoStateFirst;
            }break;
            default:NSLog(@"Login error~ %d",loginResultType);
                break;
        }
        
    }
    else if ( self.process == CMProcessRequireCarsInfoStateFirst ) {
        NSLog(@"CMProcessRequireCarsInfoStateFirst Sucess");
        NSMutableArray *terminalNos = [NSString parseRequestCarInfoRecv:data];
        NSLog(@"Login terminalNos = %@",terminalNos);
        MainViewController *mainViewController = [[MainViewController alloc] initwithCompanyName:self.companyName terminalNos:terminalNos];
        UINavigationController *carInfoNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
//        self.carInfoNavigationController = carInfoNavigationController;
        [self presentModalViewController:carInfoNavigationController animated:NO];
        [mainViewController release];
        [carInfoNavigationController release];
        
        NSLog(@"LoginViewControllerArrays = %@",self.navigationController.viewControllers);
    }
    else if ( self.process == CMProcessRequireCarsInfoStateSecond ) {
        NSLog(@"CMProcessRequireCarsInfoStateSecond Sucess");
    }
}

@end
//218.85.134.124:1439 
//shdzdwcxh  666666
//shdzfwcqp  666666
//real 61.191.55.202:1437 dt/5858
