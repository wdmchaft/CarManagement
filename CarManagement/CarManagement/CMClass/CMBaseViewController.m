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
@synthesize baseViewControllerDelegate = _baseViewControllerDelegate;
@synthesize navBar = _navBar;

- (id)init
{
    self = [super init];
    if ( self ) {
        CMNavigationBar *navBar = [[CMNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kFullScreenWidth, kCMNavigationBarHight)];
        self.navBar = navBar;
        [navBar release];
    }
    
    return self;
}

- (void)dealloc
{
    [_navBar release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    [self.view addSubview:self.navBar];
    
    //添加返回按钮
    UIImage *image = [[CMResManager getInstance] imageForKey:@"navigationbar_btn_back"];
    [self.navBar.backBtn setImage:image forState:UIControlStateNormal];
    [self.navBar.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view
    [self.view bringSubviewToFront:self.navBar];
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

/**设置navBar的显示或隐藏
 *@param hidden:是否隐藏 animated:动画
 *return nil*/
- (void)setNavBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    if ( animated ) {
        [UIView animateWithDuration:NAVIGATIONBAR_ANIMATION_TIMINTERVAL animations:^{
            self.navBar.frame = CGRectMake(0, hidden ? kCMNavigationBarHight : 0, kFullScreenWidth, kCMNavigationBarHight);
        }completion:^(BOOL finished){
            
        }];
    }
    else {
        self.navBar.hidden = hidden;
    }
}

/**重写标题
 *@param title:标题
 *return nil*/
- (void)setTitle:(NSString *)title{
    
    [super setTitle:title];
    
    self.navBar.title = title;
}

- (void)backAction
{
//    if ( self.baseViewControllerDelegate ) {
    [self.baseViewControllerDelegate popBackToMainViewController:YES];
//    }
}


@end
