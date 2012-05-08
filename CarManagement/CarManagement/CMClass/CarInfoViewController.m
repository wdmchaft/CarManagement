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
@synthesize terminalNo = _terminalNo;
@synthesize carInfoDisplayView = _carInfoDisplayView;
@synthesize carImgView = _carImgView;
/**初始化
 *@param terminalNo:终端号码
 *return self*/
- (id)initWithTerminalNo:(NSString *)terminalNoParam
{
    self = [super init];
    if ( self ) {
        self.terminalNo = terminalNoParam;
    }
    
    return self;
}

- (void)dealloc
{
    [_backBtn release];
    [_carInfoDisplayView release];
    [_carImgView release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    //1.0 view
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"车辆信息";
    
    //2.0UIscrollView
    UIScrollView *carInfoDisplayView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kCMNavigationBarHight, kFullScreenWidth, kFullScreenHight - kCMNavigationBarHight)];
    carInfoDisplayView.backgroundColor = [UIColor whiteColor];
    self.carInfoDisplayView = carInfoDisplayView;
    self.carInfoDisplayView.delegate = self;
    [carInfoDisplayView release];
    
    //3.0 barItem
    UITabBarItem *carInfoItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:kCarInfoItemTag];
    carInfoItem.title = @"车辆信息";
    self.tabBarItem = carInfoItem;
    [carInfoItem release];
   
    //4.0有call功能
    UIImage *callImg = [[CMResManager getInstance] imageForKey:@"call"];
    [self.navBar addExtendButtonWithTarget:self touchUpInsideSelector:@selector(callAction) normalImage:callImg hightLightedImage:callImg];
    
    //carImg
    UIImageView *carImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 80, 80)];
    carImgView.userInteractionEnabled = NO;
    self.carImgView = carImgView;
    [self.carInfoDisplayView addSubview:self.carImgView];
    [carImgView release];
    
    //标签车牌
    UILabel *carNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 80, 20)];
    carNoLabel.text = @"车牌:";
    [self.carInfoDisplayView addSubview:carNoLabel];
    
    //车牌数据
    UITextField *carNoField = [[UITextField alloc] initWithFrame:CGRectMake(160, 20, 180, 20)];
    carNoLabel.backgroundColor = [UIColor clearColor];
    CarInfo *theCarInfo = [[CMCars getInstance] theCarInfo:self.terminalNo];
    carNoField.text = theCarInfo.carNo;
    [self.carInfoDisplayView addSubview:carNoField];
    
    //
    
    [self.view addSubview:self.carInfoDisplayView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CarInfo *theCarInfo = [[CMCars getInstance] theCarInfo:self.terminalNo];
    UIImage *carImg = [CMResManager middleStretchableImageWithKey:[NSString carImage:theCarInfo.carType]];
    [self.carImgView setImage:carImg];
    
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
//- (void)backAction
//{
//    //[self.navigationController popViewControllerAnimated:YES];
//    //[self dismissModalViewControllerAnimated:YES];
//    NSLog(@"CarInfoViewControllerArrays = %@",self.navigationController.viewControllers);
//    NSLog(@"backAction~");
//    NSLog(@"self = %@",self);
//}

- (void)callAction
{
    NSLog(@"call~");
}
@end
