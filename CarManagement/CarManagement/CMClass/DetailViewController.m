//
//  DetailViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "DetailViewController.h"
#import "CMBaseViewController.h"
#import "HistoryTrackViewController.h"
#import "LocationMapViewController.h"
#import "CarInfoViewController.h"



@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize CMTabBarItem = _CMTabBarItem;
@synthesize tabBarController = _tabBarController;
@synthesize theCarInfo = _theCarInfo;
//@synthesize detailDeleagte = _detailDelegate;

/**初始化
 *@param param:车辆ID
 *return self*/
- (id)initwithParam:(CarInfo *)theCarInfo
{
    self = [super init];
    if ( self ) {
        self.theCarInfo = [theCarInfo retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_CMTabBarItem release];
    [_tabBarController release];
    [_theCarInfo release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    //0.0 view
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor redColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //2.0 tabBarController
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
  
    CarInfoViewController *carInfoViewController = [[CarInfoViewController alloc] init];
    carInfoViewController.delegate = self;
    HistoryTrackViewController *historyTracViewController = [[HistoryTrackViewController alloc] init];
    historyTracViewController.delegate = self;
    LocationMapViewController *locationMapViewController = [[LocationMapViewController alloc] init];
    locationMapViewController.delegate = self;
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:carInfoViewController,historyTracViewController,locationMapViewController,nil];
    tabBarController.viewControllers = viewControllers;
    [carInfoViewController release];
    [locationMapViewController release];
    [historyTracViewController release];
    [viewControllers release];
    self.tabBarController = tabBarController;
    [tabBarController release];
 
    [view addSubview:self.tabBarController.view];
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

#pragma DetailViewControllerDelegate
- (void)popBackToMainViewController:(BOOL)animated
{
    NSLog(@"DetailViewControllerArrays = %@",self.navigationController.viewControllers);
    [self.navigationController popViewControllerAnimated:animated];

}
@end
