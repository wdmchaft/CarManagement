//
//  LoginViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-3-25.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import "LoginViewController.h"
#import "NSString+NSStringEx.h"
#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"
#import "DrawLine.h"

#define ALERT_LOGIN_LOSS_MSG_TAG                2000      //缺少账户/密码信息
#define ALERT_LOGIN_LOSS_SERVER_MSG_TAG         2001      //缺少服务器信
#define LOGIN_VIEW_Y                            150
#define LOGIN_TEXTFIELD_WIDTH                   280
#define LOGIN_TEXTFIELD_HIGHT                   40



@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize picView = _picView;
@synthesize accountField = _accountField;
@synthesize passwdField = _passwdField;
@synthesize settingBtn = _settingBtn;
@synthesize msgTView = _msgTView;
@synthesize loginBtn = _loginBtn;
@synthesize socketDef = _socketDef;

- (void)dealloc
{
    [_picView release];
    [_accountField release];
    [_passwdField release];
    [_settingBtn release];
    [_msgTView release];
    [_socketDef release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    // Custom initialization
    //self.navigationController.navigationBarHidden = YES;
    
    UIView *loginView = [[UIView alloc] initWithFrame:CGRectMake(20, 150, 280, 80)];
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 40)];
    UIView *passwdView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 280, 40)];
    
    loginView.layer.cornerRadius = 8.0f;
    loginView.layer.masksToBounds = YES;
    loginView.layer.borderWidth = 1.0f;
    loginView.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:@"nar_bar_background.png"];
    NSLog(@"image.width = %f,image.height = %f\n",image.size.width,image.size.height);
    
    //胖总管图片
    UIImage *pic = [UIImage imageNamed:@"image.png"];
    UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake( 110, 40, 100, 80)];
    [picView setImage:pic];
    
    //版权说明
    UITextView *view = [[UITextView alloc] initWithFrame:CGRectMake(20, 400, 280, 60)];
    view.textAlignment = UITextAlignmentCenter;
    [view setText:@"Copyright 2012-2014©gpssos \nAll rights reserved."];
    view.editable = NO;
    self.msgTView = view;
    
    //设置
    UIButton *setting = [UIButton buttonWithType:UIButtonTypeInfoDark];
    setting.frame = CGRectMake(260, 20, 18, 18);
    [setting addTarget:self action:@selector(settingInfoAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *user;
    NSString *pwd;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    user = [defaults objectForKey:@"user"];
    pwd = [defaults objectForKey:@"pwd"];
    
    //账号密码输入框
    _accountField = [LoginViewController textInputFieldForCellWithValue:user secure:NO];
    _accountField.placeholder = @"UID";
    _accountField.delegate = self;
    _accountField.keyboardType = UIKeyboardTypeASCIICapable;
    _accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _passwdField = [LoginViewController textInputFieldForCellWithValue:pwd secure:YES];
    _passwdField.placeholder = @"pwd";
    _passwdField.delegate = self;
    _passwdField.keyboardType = UIKeyboardTypeASCIICapable;
    _passwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [accountView addSubview:[self containerCellWithTitle:@"账号" view:self.accountField]];
    [passwdView addSubview:[self containerCellWithTitle:@"密码" view:self.passwdField]];
    
    //登陆view中间划线
    DrawLine *line = [[DrawLine alloc] initWithFrame:CGRectMake(0,40,280,5)];
    line.backgroundColor = [UIColor clearColor];
    
    [loginView addSubview:accountView];
    [loginView addSubview:passwdView];
    [loginView addSubview:line];
    [line release];
    [accountView release];
    [passwdView release];
    
    //登陆
    UIButton *loginBtn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    loginBtn.frame = CGRectMake(20, 250, 280, 40);
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn = loginBtn;
    [self.view addSubview:self.loginBtn];
    
    //socket
    Socket *socketDef = [[Socket alloc] init];
    [socketDef addObserver:self forKeyPath:@"receiveContent" options:NSKeyValueObservingOptionNew context:nil];
    self.socketDef = socketDef;
    [socketDef release];
    
    NSLog(@"text md5 %@",[@"181125" md5]);
    NSLog(@"test 1 = %@",[@"1" md5]);
    
    [self.view addSubview:loginView];
    [self.view addSubview:picView];
    [self.view addSubview:view];
    [self.view addSubview:setting];
    [picView release];
    [loginView release];
    [view release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.accountField becomeFirstResponder];
    
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


#pragma mark - cell
+ (UITextField*)textInputFieldForCellWithValue:(NSString*)value secure:(BOOL)secure {
	
	UITextField *textField = [[[UITextField alloc] 
                               initWithFrame:CGRectMake(50,0, 210, 24)] autorelease];
	textField.text = value;
	textField.placeholder = @"";
	textField.secureTextEntry = secure;
	textField.keyboardType = UIKeyboardTypeASCIICapable;
	textField.returnKeyType = UIReturnKeyGo;
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //	textField.textColor = RGBCOLOR(0,0,0);
	//*/
	
	return textField;
	
}

- (UIView*)containerCellWithTitle:(NSString*)title view:(UIView*)view {
	UIView *cell = [[[UIView alloc] initWithFrame:CGRectMake(10, 10, 260, 50)] autorelease];
	UITextField* label = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
	label.text = title;
	label.enabled = NO;
	[cell addSubview:label];
	[label autorelease];
    
	[cell addSubview:view];
    
	return cell;
}

#pragma mark - buttonAction

/**点击GO时执行
 *@param nil
 *return nil*/
- (void)goAction {	
    
	NSString* user = [self.accountField text];
	NSString* pwd = [self.passwdField text];
	
	if (user == nil || pwd == nil || [user length] <= 0 || [pwd length] <= 0) {
        
        [self showAlert:ALERT_LOGIN_LOSS_MSG_TAG title:@"胖总管提醒您" message:@"帐号/密码不能为空"];
        
        return;
	} 
    else
    {
		self.accountField.enabled = FALSE;
		self.passwdField.enabled = FALSE;
		[self.accountField endEditing:YES];
		[self.passwdField endEditing:YES];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *ipAddress = [defaults objectForKey:kIpAddress];
        NSString *portNum = [defaults objectForKey:kPort];
        
        if ( (ipAddress == nil || portNum == nil) || ([ipAddress isEqualToString:@""] || [portNum isEqualToString:@""] ))
        {//未设置ip/port
            [self showAlert:ALERT_LOGIN_LOSS_SERVER_MSG_TAG title:@"胖总管提醒您" message:@"服务器地址/端口不能为空"];
            
            return;
        }
        [defaults setObject:user forKey:kUser];
        [defaults setObject:pwd forKey:kPassword];
        
        NSString *content = [NSString stringWithFormat:@"$187:super:181125:11"];
        [self.socketDef Connect:ipAddress prot:[portNum intValue] content:content];
        
        MainViewController *mainViewController = [[MainViewController alloc] init];
        mainViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentModalViewController:mainViewController animated:YES];
        [mainViewController release];
    }
    
    [self pickUpTheKeyBorad];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSString *receiveString = [object valueForKey:@"receiveContent"];
    NSLog(@"-receiveString---%@",receiveString);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    if ( touchPoint.y > LOGIN_VIEW_Y && touchPoint.y < LOGIN_VIEW_Y + LOGIN_TEXTFIELD_HIGHT ) {
        [self.accountField becomeFirstResponder];
    }
    else if ( touchPoint.y > LOGIN_VIEW_Y + LOGIN_TEXTFIELD_HIGHT && touchPoint.y < LOGIN_VIEW_Y + 2 * LOGIN_TEXTFIELD_HIGHT) {
        [self.passwdField becomeFirstResponder];
    }
    else {
        [self.accountField resignFirstResponder];
        [self.passwdField resignFirstResponder];
    }
}

#pragma mark - for keyborad

- (void)pickUpTheKeyBorad
{
    [self.accountField resignFirstResponder];
    [self.passwdField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self goAction];
    return YES;
}


#pragma mark - Flipside View

- (void)SettingViewControllerDidFinish:(SettingViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)settingInfoAction
{    
    SettingViewController *controller = [[SettingViewController alloc] init];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController pushViewController:controller animated:YES];
   // [self presentModalViewController:controller animated:NO];
    [controller release];
}

#pragma mark - for alert

/**现实alert
 *@param alertTag:view‘s tag  title:标题 message:现实信息
 *return nil*/
- (void)showAlert:(NSInteger)alertTag title:(NSString *)title message:(NSString *)message
{
    UIAlertView *tip = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    tip.tag = alertTag;
    [tip show];
    [tip release];
}


/**alert按钮相应事件
 *@param alertView:显示的alertView buttonIndex:按钮索引
 *return nil*/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch ( alertView.tag ) {
        case ALERT_LOGIN_LOSS_MSG_TAG:
        {
            
        }break; 
        case ALERT_LOGIN_LOSS_SERVER_MSG_TAG:
        {
            [self settingInfoAction];
        }break;
        default:NSLog(@"Error");
            break;
    }
}
@end

