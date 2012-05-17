//
//  CarInfoViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "TakePhotoViewController.h"
#import "AppDelegate.h"

@interface TakePhotoViewController ()

@end

@implementation TakePhotoViewController
@synthesize backBtn = _backBtn;
@synthesize terminalNo = _terminalNo;
@synthesize photoInfoLabel = _photoInfoLabel;
@synthesize carImgView = _carImgView;
@synthesize socket = _socket;
@synthesize photoLoadingView = _photoLoadingView;
@synthesize photoLoadLabel = _photoLoadLabel;
@synthesize photoLoadProcessView = _photoLoadProcessView;
@synthesize callList = _callList;
@synthesize isReadyCall = _isReadyCall;

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
    [_photoInfoLabel release];
    [_carImgView release];
    [_socket release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    //1.0 view
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"车辆照片";
    
    UIImage *takePhotoImg = [[CMResManager getInstance] imageForKey:@"take_photo"];
    UIImage *callImg = [[CMResManager getInstance] imageForKey:@"call"];
    [self setRightBtnEnabled:NO];
    [self addExtendBtnWithTarget:self touchUpInsideSelector:@selector(takePhotoAction) normalImage:takePhotoImg hightLightedImage:nil];
    [self addExtendBtnWithTarget:self touchUpInsideSelector:@selector(callAction) normalImage:callImg hightLightedImage:nil];
    
    //2.0标题
    UILabel *photoInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 300, 40)];
    photoInfoLabel.font = [UIFont systemFontOfSize:15];
    photoInfoLabel.textColor = [UIColor blueColor];
    photoInfoLabel.backgroundColor = [UIColor yellowColor];
    self.photoInfoLabel = photoInfoLabel;
    [self.view addSubview:self.photoInfoLabel];
    [photoInfoLabel release];
    
    //3.0carImg
    UIImageView *carImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
    carImgView.userInteractionEnabled = NO;
    carImgView.backgroundColor = [UIColor redColor];
    self.carImgView = carImgView;
    [self.view addSubview:self.carImgView];
    [carImgView release];    
    
    //4.0下载图片加载
    UIView *photoLoadView = [[UIView alloc] initWithFrame:CGRectMake(10, 55, 300, 400 - 55)];
    photoLoadView.backgroundColor = [UIColor whiteColor];
    
    UIActivityIndicatorView *photoLoadIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    photoLoadIndicator.frame = CGRectMake(60, 40, 30, 30);
    self.photoLoadProcessView = photoLoadIndicator;
    [self.photoLoadProcessView startAnimating];
    [photoLoadView addSubview:self.photoLoadProcessView];
    [photoLoadIndicator release];
    
    UILabel *photoLoadLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 200, 30)];
    photoLoadLabel.text = @"正在加载车辆照片...";
    photoLoadLabel.backgroundColor = [UIColor clearColor];
    self.photoLoadLabel = photoLoadLabel;
    [photoLoadView addSubview:self.photoLoadLabel];
    
    self.photoLoadingView = photoLoadView;
    [self.view addSubview:self.photoLoadingView];
    [photoLoadView release];
    
    CarInfo *testcar = [[CMCars getInstance] theCarInfo:self.terminalNo];
    for ( Dirver *dirver in testcar.drivers ) {
        NSLog(@"dirver.dirverName = %@,dirver.dirverTel = %@",dirver.dirverName,dirver.dirverTel);
    }
    
    //5.0callList
    CarInfo *theCarInfo = [[CMCars getInstance] theCarInfo:self.terminalNo];
    NSInteger rows = [theCarInfo.drivers count] > 0 ? [theCarInfo.drivers count] : 1;
    UITableView *callList = [[UITableView alloc] initWithFrame:CGRectMake(10,kCMNavigationBarHight + 10, kFullScreenWidth - 20, 40 + rows * 40) style:UITableViewStyleGrouped];
    callList.backgroundColor = [UIColor grayColor];
    callList.tableHeaderView = nil;
    callList.delegate = self;
    callList.dataSource = self;
    self.callList = callList;
    [self.view addSubview:self.callList];
    [callList release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //读取照片数据,如果本地没有,则请求终端拍照,默认拍取前景
    NSDictionary *photoData = [[CMUser getInstance] readData:kCarPhotoFileName];
    
    //获取当前socket
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.client.delegate = self;
    self.socket = [appDelegate.client retain];
    
    //如果有数据,则取最后拍照的数据加载
    if ( photoData ) {
        NSString *theKey = [[photoData allKeys] objectAtIndex:([photoData count] - 1)];
        NSData *imgData = [photoData objectForKey:theKey];
        [self.carImgView setImage:[UIImage imageWithData:imgData]];
        [self.photoLoadingView removeFromSuperview];
    }
    else {
        NSString *takePhotoParam = [NSString createTakePhotoParam:self.terminalNo cameraType:CMCameraTypeFront];
        NSLog(@"takePhotoParam = %@",takePhotoParam);
        [self.socket writeData:[takePhotoParam dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    }
    
    //_isReadyCall = NO 不显示电话列表
    _isReadyCall = YES;
    self.callList.hidden = YES;
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
- (void)takePhotoAction
{
    //[self.navigationController popViewControllerAnimated:YES];
    //[self dismissModalViewControllerAnimated:YES];
    NSLog(@"CarInfoViewControllerArrays = %@",self.navigationController.viewControllers);
    NSLog(@"backAction~");
    NSLog(@"self = %@",self);
}

- (void)callAction
{
    NSLog(@"call~");
    if ( _isReadyCall ) {
       // [self showCallList];
        self.callList.hidden = NO;
        _isReadyCall = NO;
    }
    else {
       // [self hideCallList];
        self.callList.hidden = YES;
        _isReadyCall = YES;
    }
}

/**显示电话列表
 *@param nil
 *return nil*/
- (void)showCallList
{
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.3];
    self.callList.center = CGPointMake(160, 100);
    [UIView commitAnimations];
}

/**隐藏电话列表
 *@param nil
 *return nil*/
- (void)hideCallList
{
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.3];
    self.callList.center = CGPointMake(160, -80);
    [UIView commitAnimations];
}

#pragma mark - AsyncSocketDelegate
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{

    [self.socket readDataWithTimeout:-1 tag:0];
  
    NSLog(@"didConnectToHost");

}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err 
{
    NSLog(@"Error");
//    [self showAlert:kAlertNetWorkUnusable title:nil message:@"当前网络不可用，请检查后重新登陆"];
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"Sorry this connect is failure");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"data = %@",data);
    if ( data ) {
        [self.carImgView setImage:[UIImage imageWithData:data]];
        
    }
}

#pragma mark for - CallList
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( !cell ) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    NSString *cellValue = nil;
    CarInfo *theCarInfo = [[CMCars getInstance] theCarInfo:self.terminalNo];
    if ( [theCarInfo.drivers count] == 0 ) {
        cellValue = @"无电话信息";
    }
    else {
        Dirver *dirver = [theCarInfo.drivers objectAtIndex:[indexPath row]];
        cell.textLabel.text = dirver.dirverName;
        cell.detailTextLabel.text = dirver.dirverTel;
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CarInfo *theCarInfo = [[CMCars getInstance] theCarInfo:self.terminalNo];
    if ( [theCarInfo.drivers count] < 1 || theCarInfo.drivers == nil ) {
        return 1;
    }
    
    return [theCarInfo.drivers count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url = [NSString stringWithFormat:@"tel://%@",[tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}
@end
