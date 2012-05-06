//
//  CarInfoViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "CarInfoViewController.h"

@interface CarInfoViewController ()

@end

@implementation CarInfoViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    //1.0 view
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor blueColor];
    
    //2.0 barItem
    UITabBarItem *carInfoItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:kCarInfoItemTag];
    carInfoItem.title = @"车辆信息";
    self.tabBarItem = carInfoItem;
    [carInfoItem release];
    
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

@end
