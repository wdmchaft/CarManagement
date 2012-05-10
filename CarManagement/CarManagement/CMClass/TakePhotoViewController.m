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
    
    UIImage *btnImg = [[CMResManager getInstance] imageForKey:@"take_photo"];
    [self addRightBtn:btnImg controllerEventTouchUpInside:@selector(takePhotoAction) target:self];
    
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
    }
    else {
        NSString *takePhotoParam = [NSString createTakePhotoParam:self.terminalNo cameraType:CMCameraTypeFront];
        [self.socket writeData:[takePhotoParam dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    }
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

@end
