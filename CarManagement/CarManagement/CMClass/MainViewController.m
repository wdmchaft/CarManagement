//
//  MainViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize searchBar = _searchBar;
@synthesize carInfoTView = _carInfoTView;
@synthesize refreshBtn = _refreshBtn;
@synthesize toolBar = _toolBar;
         
- (id)init
{
    self = [super init];
    
    return self;
}

- (void)dealloc
{
    [_searchBar release];
    [_carInfoTView release];
    [_refreshBtn release];
    [_toolBar release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    self.title = @"车辆列表情况";
    
    //0.0
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor whiteColor];
    
    //1.0刷新
    UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction)];
    self.refreshBtn = refreshBtn;
    self.navigationItem.rightBarButtonItem = self.refreshBtn;
    [refreshBtn release];
    
    //2.0tableview
    UITableView *carInfoTView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    carInfoTView.backgroundColor = [UIColor whiteColor];
    carInfoTView.sectionFooterHeight = 10;
    carInfoTView.sectionFooterHeight = 2;
    self.carInfoTView = carInfoTView;
    self.carInfoTView.delegate = self;
    self.carInfoTView.dataSource = self;
    [carInfoTView release];
    
    //2.1搜索
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kFullScreenWidth, kCMNavigationBarHight)];
    self.searchBar = searchBar;
    self.carInfoTView.tableHeaderView = self.searchBar;
    searchBar.autocorrectionType = UITextAutocorrectionTypeYes;
    [searchBar release];
        
    
    
    
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
/**刷新
 *@param nil
 *return nil*/
- (void)refreshAction
{
    NSLog(@"刷新啦~");
}

#pragma tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    
}

@end
