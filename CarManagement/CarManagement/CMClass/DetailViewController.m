//
//  DetailViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "DetailViewController.h"
#import "HistoryTrackViewController.h"
#import "LocationMapViewController.h"
#import "CarInfoViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize CMTabBarItem = _CMTabBarItem;
@synthesize tabBarController = _tabBarController;


- (void)dealloc
{
    [_CMTabBarItem release];
    [_tabBarController release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    //0.0 view
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor whiteColor];
    
    //1.0 CMTabBarItem
    
    UITabBarItem *historyTrackItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:kHistoryTrackItemTag];
    
    //2.0 tabBarController
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    CarInfoViewController *carInfoViewController = [[CarInfoViewController alloc] init];
    LocationMapViewController *locationMapViewController = [[LocationMapViewController alloc] init];
    HistoryTrackViewController *historyTracViewController = [[HistoryTrackViewController alloc] init];
    
    tabBarController.viewControllers = [[NSArray alloc] initWithObjects:carInfoViewController,locationMapViewController,historyTrackItem,nil];
    [carInfoViewController release];
    [locationMapViewController release];
    [historyTracViewController release];
    self.tabBarController = tabBarController;
    [tabBarController release];
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
