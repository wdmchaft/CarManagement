//
//  LoginViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize logoImage = _logoImage;
@synthesize loginInputView = _loginInPutView;
@synthesize userAccountField = _userAccountField;
@synthesize userPasswordField = _userPasswordField;
@synthesize loginBtn = _loginBtn;
@synthesize reserveTView = _reserveTView;

- (void)dealloc
{
    [_logoImage release];
    [_loginInPutView release];
    [_userAccountField release];
    [_userPasswordField release];
    [_loginBtn release];
    [_reserveTView release];
    
    [super dealloc];
}

- (void)loadView
{
    
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

@end
