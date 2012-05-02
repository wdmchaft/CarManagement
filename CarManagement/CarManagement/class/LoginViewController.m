//
//  LoginViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-3-25.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"
#import "DrawLine.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize picView = _picView;
@synthesize accountField = _accountField;
@synthesize passwdField = _passwdField;
@synthesize setting = _setting;
@synthesize msg = _msg;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
        self.msg = view;
        
        //设置
        UIButton *setting = [UIButton buttonWithType:UIButtonTypeInfoDark];
        setting.frame = CGRectMake(260, 20, 18, 18);
        [setting addTarget:self action:@selector(settingInfo) forControlEvents:UIControlEventTouchUpInside];
        
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
        
        [self.view addSubview:loginView];
        [self.view addSubview:picView];
        [self.view addSubview:view];
        [self.view addSubview:setting];
        [picView release];
        [loginView release];
        [view release];
        
    }
    return self;
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
// 点击GO时执行。
- (void)goAction {	
    
	NSString* user = [self.accountField text];
	NSString* pwd = [self.passwdField text];
	
	if (user == nil || pwd == nil || [user length] <= 0 || [pwd length] <= 0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"胖总管提醒您"
														message:@"帐号/密码不能为空"
													   delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles: nil];
		[alert show];
		[alert release];
	} 
    else
    {
		self.accountField.enabled = FALSE;
		self.passwdField.enabled = FALSE;
		[self.accountField endEditing:YES];
		[self.passwdField endEditing:YES];
		
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:user forKey:@"user"];
        [defaults setObject:pwd forKey:@"pwd"];
        
        MainViewController *mainViewController = [[MainViewController alloc] init];
        mainViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentModalViewController:mainViewController animated:YES];
        [mainViewController release];
    }
    
    [self pickUpTheKeyBorad];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

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



#pragma mark - alterView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self pickUpTheKeyBorad];
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)settingInfo
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] init];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
 
    [self presentModalViewController:controller animated:NO];
    [controller release];
}

@end

