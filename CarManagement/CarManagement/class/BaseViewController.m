//
//  BaseViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-3-26.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize navigationBar = _navigationBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NavBar *bar = [[NavBar alloc] initWithFrame:CGRectMake(0, 0, FULL_SCREEN_WIDTH, CONTENT_NAVIGATIONBAR_HEIGHT)];
        self.navigationBar = bar;
        UIImage *image = [UIImage imageNamed:@"back"];
        [self setNavigationBarLeftButtonBackground:image imageClicked:image touchUpInSideSelector:@selector(backAction)];
        [self setNavigationBarTitle:@"CarList"];
        [self.view addSubview:self.navigationBar];
        
        [bar release];
    }
    return self;
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


//back buttom clicked
- (void)backAction
{
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - setting the navbar
//setting the backbutton's background of the navbar
- (void)setNavigationBarLeftButtonBackground:(UIImage *)imageNormal
                                imageClicked:(UIImage *)imageClicked 
                       touchUpInSideSelector:(SEL)selector                    
{
    [self.navigationBar.backButton setImage:imageNormal forState:UIControlStateNormal];
    [self.navigationBar.backButton setImage:imageClicked forState:UIControlEventTouchUpInside];
    [self.navigationBar.backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void)setNavigationBarTitle:(NSString *)title
{
    self.navigationBar.title = title;
    [super setTitle:title];
}

@end
