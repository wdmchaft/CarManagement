//
//  AboutCarManagerViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "AboutCarManagerViewController.h"

@interface AboutCarManagerViewController ()

@end

@implementation AboutCarManagerViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    self.title = @"胖总车管";
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
