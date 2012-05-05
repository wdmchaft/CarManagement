//
//  CMBaseViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-5.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "CMBaseViewController.h"

@interface CMBaseViewController ()

@end

@implementation CMBaseViewController
@synthesize navBar = _navBar;

- (void)dealloc
{
    [_navBar release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    CMNavigationBar *navBar = [[CMNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kFullScreenWidth, kCMNavigationBarHight)];
    //navBar.backgroundColor = [UIColor redColor];
    self.navBar = navBar;
    [navBar release];
    
    [self.view addSubview:self.navBar];
    [self.view bringSubviewToFront:self.navBar];
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
