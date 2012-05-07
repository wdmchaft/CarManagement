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
@synthesize backBtn = _backBtn;

- (void)dealloc
{
    [_backBtn release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    //1.0 view
    self.view.backgroundColor = [UIColor yellowColor];
    
    //2.0返回按钮
//    UIImage *image = [[CMResManager getInstance] imageForKey:@"navigationbar_btn_back"];
//    [self.navBar.backBtn setImage:image forState:UIControlStateNormal];
//    [self.navBar.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    //3.0 barItem
    UITabBarItem *carInfoItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:kCarInfoItemTag];
    carInfoItem.title = @"车辆信息";
    self.tabBarItem = carInfoItem;
    [carInfoItem release];
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
- (void)backAction
{
    //[self.navigationController popViewControllerAnimated:YES];
    //[self dismissModalViewControllerAnimated:YES];
    NSLog(@"CarInfoViewControllerArrays = %@",self.navigationController.viewControllers);
    NSLog(@"backAction~");
    NSLog(@"self = %@",self);
}
@end
