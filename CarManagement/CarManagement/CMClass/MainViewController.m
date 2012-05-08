//
//  MainViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "CMTableViewCell.h"


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
@synthesize carIDs = _carIDs;
@synthesize searchResult = _searchResult;
      

/**初始化
 *@param param:初始化参数
 *return nil*/
- (id)initWithParam:(NSMutableArray *)param
{
    self = [super init];
    if ( self ) {
        NSLog(@"MainView param = %@",param);
        NSMutableArray *arrays = [NSMutableArray arrayWithArray:param];
        self.companyName = [arrays objectAtIndex:1];
        [arrays removeObjectAtIndex:0];
        [arrays removeObjectAtIndex:0];
        NSMutableArray *carInfoKind = [[NSMutableArray alloc] initWithArray:arrays];
        self.carInfoKind = carInfoKind;
        [carInfoKind release];

        NSLog(@"MainView self.carInfoKind = %@",self.carInfoKind);
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
    [_carIDs release];
    [_searchResult release];
    
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
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
    //1.0复制车ID到carID
    NSString *carID;
    NSMutableArray *tmpCarIDs = [[NSMutableArray alloc] init];
    for ( NSArray *array in self.carInfoKind ) {
        carID = [array objectAtIndex:0];
        [tmpCarIDs addObject:carID];
    }
    
    self.carIDs = tmpCarIDs;
    [tmpCarIDs release];
    
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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

- (void)logoutAction
{
    NSLog(@"退出啦~");
}

#pragma tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    
    CMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];

    if ( !cell ) {
        cell = [[[CMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier
                                                      :cellIndentifier] autorelease];
    }
    
    NSString *carNo;
    if ( _isSearchOn ) {
        carNo = [self.searchResult objectAtIndex:[indexPath row]];
    }
    else {
        NSArray *carInfo = [self.carInfoKind objectAtIndex:[indexPath row]];
        CarInfo *theCarIno = [[CarInfo alloc] initWithParam:carInfo];
        cell.theCarInfo = theCarIno;
        [theCarIno release];
        NSLog(@"%d",[indexPath section]);
        carNo = cell.theCarInfo.carNo;
        CMCarType carType = cell.theCarInfo.carType;
        NSLog(@"carID = %@",carNo);
        //NSString *carType = [carInfo objectAtIndex:2];
        
        UIImage *image =  [[CMResManager getInstance] imageForKey:@"car_red"];
        UIImage *craneImg = [[CMResManager getInstance] imageForKey:@"crane"];
        NSLog(@"carType = %d",carType);
        if ( carType == CMCarTypeCar ) {
            cell.imageView.image = image;
        }
        else if ( carType == CMCarTypeCrane ) {
            cell.imageView.image = craneImg;
        }
        else 
            cell.imageView.image = nil;
    }
        cell.textLabel.text = carNo;
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
    
    return [self.carInfoKind count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc] initwithParam:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
    NSLog(@"MainViewControllerArrays = %@",self.navigationController.viewControllers);
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma searchBar
- (void)searchAction
{
    [self.searchResult removeAllObjects];
    
    for ( NSString *carID in self.carIDs )
    {
        NSRange carIDResultRange = [carID rangeOfString:self.searchBar.text options:NSCaseInsensitiveSearch];
        if ( carIDResultRange.length > 0 ) {
            [self.searchResult addObject:carID];
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

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    _isSearchOn = NO;
//    _canSelectRow = YES;
//    self.carInfoTView.scrollEnabled = YES;
//    [self.searchBar resignFirstResponder];
//    
//    [self.carInfoTView reloadData];
//    
//    return YES;
//}

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
