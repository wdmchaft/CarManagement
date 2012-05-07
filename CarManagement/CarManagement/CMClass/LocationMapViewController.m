//
//  LocationMapViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "LocationMapViewController.h"

@interface LocationMapViewController ()

@end

@implementation LocationMapViewController
@synthesize mapView = _mapView;

- (void)dealloc
{
    [_mapView release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    //2.0当前位置
    UIImage *currentLocationImg = [[CMResManager getInstance] imageForKey:@"current_location"];
    UIBarButtonItem *currentLocationItem = [[UIBarButtonItem alloc] initWithImage:currentLocationImg 
                                                                           style:UIBarButtonItemStylePlain 
                                                                          target:self 
                                                                          action:@selector(locationAction)];
    self.navigationItem.rightBarButtonItem = currentLocationItem;
    self.navigationController.navigationBarHidden = YES;

    //3.0mapView
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, kCMNavigationBarHight, kFullScreenWidth, 400)];
    mapView.showsUserLocation = YES;
    self.mapView = mapView;
    [self.view addSubview:self.mapView];
    [mapView release];
    
    //3.0 barItem
    UITabBarItem *locationMapItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:kCarInfoItemTag];
    locationMapItem.title = @"GPS定位";
    self.tabBarItem = locationMapItem;
    [locationMapItem release];
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
- (void)locationAction
{
    self.mapView.showsUserLocation = YES;
}

@end
