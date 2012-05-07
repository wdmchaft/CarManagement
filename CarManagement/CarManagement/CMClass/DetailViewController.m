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
@synthesize carID = _carID;
//@synthesize detailDeleagte = _detailDelegate;

/**初始化
 *@param param:车辆ID
 *return self*/
- (id)initwithParam:(NSString *)param
{
    self = [super init];
    if ( self ) {
        self.carID = [NSString stringWithString:param];
    }
    
    return self;
}

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
    view.backgroundColor = [UIColor redColor];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self.navigationController setToolbarHidden:NO];
    
//    //test
//    UIBarButtonItem *carInfoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(callAction)];
//    UIBarButtonItem *historyTrackItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(historyTrackAction)];
//    UIBarButtonItem *locationMapItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(locationMapAction)];
//    UIBarButtonItem *takePhotoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePhotoAction)];
//    [self.navigationController.toolbar setItems:[NSArray arrayWithObjects:carInfoItem,historyTrackItem,locationMapItem,takePhotoItem,nil]];
//    [carInfoItem release];
//    [historyTrackItem release];
//    [locationMapItem release];
//    [takePhotoItem release];
    
    //2.0 tabBarController
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
  
    CarInfoViewController *carInfoViewController = [[CarInfoViewController alloc] init];
    HistoryTrackViewController *historyTracViewController = [[HistoryTrackViewController alloc] init];
    LocationMapViewController *locationMapViewController = [[LocationMapViewController alloc] init];
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
