//
//  MainViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "LoginViewController.h"
#import "CMTableViewCell.h"
#import "AppDelegate.h"

#define kAlertLogoutTag         2000


@interface MainViewController ()

@end

@implementation MainViewController
@synthesize searchBar = _searchBar;
@synthesize carInfoTView = _carInfoTView;
@synthesize refreshBtn = _refreshBtn;
@synthesize logoutBtn = _logoutBtn;
@synthesize toolBar = _toolBar;
@synthesize companyName = _companyName;
@synthesize carInfoKind = _carInfoKind;
@synthesize carInfoDics = _carInfoDics;
@synthesize isSearchOn = _isSearchOn;
@synthesize canSelectRow = _canSelectRow;
@synthesize terminalNos = _terminalNos;
@synthesize searchResult = _searchResult;
@synthesize carNos = _carNos;
      

/**初始化
 *@param param:初始化参数
 *return nil*/
//- (id)initWithParam:(NSMutableArray *)param
//{
//    self = [super init];
//    if ( self ) {
//        NSLog(@"MainView param = %@",param);
//        NSMutableArray *arrays = [NSMutableArray arrayWithArray:param];
//        self.companyName = [arrays objectAtIndex:1];
//        [arrays removeObjectAtIndex:0];
//        [arrays removeObjectAtIndex:0];
//        NSMutableArray *carInfoKind = [[NSMutableArray alloc] initWithArray:arrays];
//        self.carInfoKind = carInfoKind;
//        [carInfoKind release];
//
//        NSLog(@"MainView self.carInfoKind = %@",self.carInfoKind);
//    }
//    
//    return self;
//}

/**初始化
 *@param companyName:公司名称 terminalNos:终端号码数组
 *return self*/
- (id)initwithCompanyName:(NSString *)companyName terminalNos:(NSMutableArray *)terminalNosParam
{
    self = [super init];
    if ( self ) {
        self.companyName = companyName;
        NSMutableArray *terminalNos = [[NSMutableArray alloc] initWithArray:terminalNosParam];
        self.terminalNos = terminalNos;
        [terminalNos release];
    }
    
    return self;
}

- (void)dealloc
{
    [_searchBar release];
    [_carInfoTView release];
    [_refreshBtn release];
    [_logoutBtn release];
    [_toolBar release];
    [_carInfoKind release];
    [_carInfoDics release];
    [_terminalNos release];
    [_carNos release];
    [_searchResult release];
    
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    [self.navigationItem.titleView sizeToFit];
    self.title = self.companyName;
    
    //0.0
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor whiteColor];
    
    //[self.navigationController setToolbarHidden:YES];
    
    //navigationbar
    //1.0登出
    UIBarButtonItem *logoutBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(logoutAction)];
    self.logoutBtn = logoutBtn;
    self.navigationItem.leftBarButtonItem = self.logoutBtn;
    [logoutBtn release];
    
    //1.1刷新
    UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction)];
    self.refreshBtn = refreshBtn;
    self.navigationItem.rightBarButtonItem = self.refreshBtn;
    [refreshBtn release];
    
    //2.0tableview
    UITableView *carInfoTView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kFullScreenWidth, 416) style:UITableViewStyleGrouped];
    carInfoTView.backgroundColor = [UIColor whiteColor];
    carInfoTView.sectionFooterHeight = 10;
    carInfoTView.sectionFooterHeight = 2;
    self.carInfoTView = carInfoTView;
    self.carInfoTView.delegate = self;
    self.carInfoTView.dataSource = self;
    [carInfoTView release];
    
    //2.1搜索
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kFullScreenWidth, kCMNavigationBarHight)];
    searchBar.autocorrectionType = UITextAutocorrectionTypeYes;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.keyboardType = UIKeyboardTypeAlphabet; 
    searchBar.showsCancelButton = NO;
    self.searchBar = searchBar;
    self.searchBar.delegate = self;
    self.carInfoTView.tableHeaderView = self.searchBar;
    [searchBar release];
    
    [view addSubview:self.carInfoTView];
    self.view = view;
    [view release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //获取carNos
    NSMutableArray *carNos = [[NSMutableArray alloc] initWithArray:[[CMCars getInstance] carNos]];
    self.carNos = carNos;
    [carNos release];
    
    //2.0
    NSMutableArray *searchResult = [[NSMutableArray alloc] init];
    self.searchResult = searchResult;
    [searchResult release];
    
    _isSearchOn = NO;
    _canSelectRow = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.searchBar = nil;
    self.carInfoTView = nil;
    self.refreshBtn = nil;
    self.logoutBtn = nil;
    self.toolBar = nil;

}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self printout:@"lyfing"];
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
    NSLog(@"refresh~");
}

- (void)logoutAction
{
    UIAlertView *tip = [[UIAlertView alloc] initWithTitle:kAlertTitleDefault message:@"您确定要退出?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    tip.tag = kAlertLogoutTag;
    [tip show];
    [tip release];
}

- (void)printout:(NSString *)string
{
    NSLog(@"hello %@",string);
}

#pragma UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  
{
    NSLog(@"alertView.tag = %d,buttonIndex = %d",alertView.tag,buttonIndex);
    if ( alertView.tag == kAlertLogoutTag ) {
        if ( buttonIndex == 1 ) {
            //确定退出
            NSLog(@"退出啦~");
            NSLog(@"logout~");
            //断开socket
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            appDelegate.client.delegate = self;
            [appDelegate.client disconnect];
            //清除缓存
            
            //切换到登陆页面
            [self dismissModalViewControllerAnimated:NO];
        }
    }
}

#pragma tableView
- (CMTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    
    CMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];

    if ( !cell ) {
        cell = [[[CMTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier
                                                      :cellIndentifier] autorelease];
    }
    
    //CMTableViewCell *cell = [[[CMTableViewCell alloc] init] autorelease];
    
    NSString *carNo = nil;
    if ( _isSearchOn ) {
        carNo = [self.searchResult objectAtIndex:[indexPath row]];
    }
    else {
        cell.terminalNo = [self.terminalNos objectAtIndex:[indexPath row]];
        CurrentCarInfo *theCurrentCarInfo = [[CMCurrentCars getInstance] theCurrentCarInfo:cell.terminalNo];
        CarInfo *theCarInfo = [[CMCars getInstance] theCarInfo:cell.terminalNo];
        NSLog(@"theCarInfo.carNo = %@",theCarInfo.carNo);
        NSLog(@"theCurrentCarInfo.carPosition = %@",theCurrentCarInfo.carPosition);
        NSLog(@"carType = %d",theCarInfo.carType);
        cell.carNoCMView.contentLabel.text = [NSString carNoAdjustmentParam:[[CMCars getInstance] theCarInfo:cell.terminalNo].carNo];
        cell.speedCMView.contentLabel.text = [NSString carSpeedAdjustmentParam:[[CMCurrentCars getInstance] theCurrentCarInfo:cell.terminalNo].speed];
        NSString *carWarn = [[CarWarn globalConfig] currentCarWarn:theCurrentCarInfo.warn carType:theCarInfo.carType logicLevel:nil];
        cell.stateCMView.contentLabel.text = [NSString carStateAdjustmentParam:carWarn];
        cell.positionCMView.contentLabel.text =[NSString carPositionAdjustmentParam:[[CMCurrentCars getInstance] theCurrentCarInfo:cell.terminalNo].carPosition];

        UIImage *carImg = [[CMResManager getInstance] imageForKey:[NSString carImage:theCarInfo.carType]];
        cell.carImgView.image = carImg; 
    }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( _isSearchOn ) {
        return [self.searchResult count];
    }
    
    return [self.terminalNos count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMTableViewCell *cell = (CMTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithTerminalNo:cell.terminalNo];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
    NSLog(@"MainViewControllerArrays = %@",self.navigationController.viewControllers);
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.terminalNos objectAtIndex:[indexPath row]];
    NSString *carPosition = [[CMCurrentCars getInstance] theCurrentCarInfo:key].carPosition;
    CGSize size = [carPosition sizeWithFont:[UIFont systemFontOfSize:16]];
    NSLog(@"cell.terminalNo = %@",[[CMCars getInstance] theCarInfo:key].carNo);
    NSLog(@"size.width = %f",size.width);
    NSLog(@"carPosition.length = %d",carPosition.length);
    
    NSInteger lineNum  = 1;
    if ( size.width > 205 ) {
        lineNum = (NSInteger)(( size.width - 205 ) / 245 + 1 );
        if ( size.width > 455 ) {
            lineNum ++;
        }
        else if ( size.width > 210 && size.width < 455 )
        {
            lineNum ++;
        }
    }
    
    float cellHight = 80 + lineNum * 20;
    
    return cellHight;
}

#pragma searchBar
- (void)searchAction
{
    [self.searchResult removeAllObjects];
    
    for ( NSString *carNo in self.carNos )
    {
        NSRange carIDResultRange = [carNo rangeOfString:self.searchBar.text options:NSCaseInsensitiveSearch];
        if ( carIDResultRange.length > 0 ) {
            [self.searchResult addObject:carNo];
        }
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _isSearchOn = YES;
    _canSelectRow = NO;
    self.carInfoTView.scrollEnabled = NO;
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText 
{
    if ( [self.searchBar.text length] > 0 ) {
        _isSearchOn = YES;
        _canSelectRow = YES;
        self.carInfoTView.scrollEnabled = YES;
        [self searchAction];
    }
    else {
        _isSearchOn = NO;
        _canSelectRow = NO;
        self.carInfoTView.scrollEnabled = NO;
    }
    
    [self.carInfoTView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _isSearchOn = NO;
    _canSelectRow = YES;
    self.carInfoTView.scrollEnabled = YES;
    [searchBar resignFirstResponder];
    [self searchAction];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [self.carInfoTView reloadData];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ( ![self.searchBar isExclusiveTouch] ) {
        [self.searchBar resignFirstResponder];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar   
{
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    _canSelectRow = YES;
    self.carInfoTView.scrollEnabled = YES;
}

@end
