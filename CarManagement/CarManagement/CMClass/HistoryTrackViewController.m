//
//  HistoryTrackViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "HistoryTrackViewController.h"

@interface HistoryTrackViewController ()

@end

@implementation HistoryTrackViewController
@synthesize terminalNo = _terminalNo;

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
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    //1.0 view
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"历史记录";
//    
//    //2.0 barItem
//    UITabBarItem *historyTrackItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:kCarInfoItemTag];
//    historyTrackItem.title = @"历史轨迹";
//    self.tabBarItem = historyTrackItem;
//    [historyTrackItem release];
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
