//
//  HistoryTrackViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "OilHistoryViewController.h"
#import "AppDelegate.h"

#define FIELD_DATE_BEGIN_Y            84
#define FIELD_DATE_BEGIN_MAX_X        155
#define FIELD_DATE_END_BEGIN_MIN_X    165    

#define kAlertEndDateWrong            2000
#define kAlertDatesIntervalWrong      2001

@interface OilHistoryViewController ()

@end

@implementation OilHistoryViewController
@synthesize terminalNo = _terminalNo;
@synthesize oilHistoryView = _oilHistoryView;
@synthesize dateView = _dateView;
@synthesize dateBegin = _dateBegin;
@synthesize dateEnd = _dataEnd;
@synthesize titleLabel = _titleLabel;
@synthesize segLabel = _segLabel;
@synthesize loadView = _loadView;
@synthesize indicator = _indicator;
@synthesize tipLabel = _tipLabel;
@synthesize pickerBackgroundView = _pickerBackgroundView;
@synthesize datePicker = _datePicker;
@synthesize dateChoiceProcess = _dateChoiceProcess;
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
    [_dateView release];
    [_dateBegin release];
    [_dateEnd release];
    [_oilHistoryView release];
    [_titleLabel release];
    [_segLabel release];
    [_loadView release];
    [_indicator release];
    [_tipLabel release];
    [_datePicker release];
    [_socket release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    //1.0 view
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"油量查询";
    
    //2.0查询按钮
    UIImage *historyBtnImg = [[CMResManager getInstance] imageForKey:@"history_trace"];
    [self addRightBtn:historyBtnImg controllerEventTouchUpInside:@selector(oilHistoryAction) target:self];
    
    //3.0标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,kCMNavigationBarHight + 10, 300, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    NSString *carNo = [[CMCars getInstance] theCarInfo:self.terminalNo].carNo;
    titleLabel.text = [NSString stringWithFormat:@"%@",carNo];
    titleLabel.textAlignment = UITextAlignmentCenter;
    self.titleLabel = titleLabel;
    [self.view addSubview:self.titleLabel];
    [titleLabel release];
    
    //4.0时间view
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(0,kCMNavigationBarHight + 40, 320, 30)];
    dateView.backgroundColor = [UIColor whiteColor];

    
    //4.1开始时间
    UITextField *dateBegin = [[UITextField alloc] initWithFrame:CGRectMake(50,0,105,30)];
    dateBegin.backgroundColor = [UIColor clearColor];
    dateBegin.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    dateBegin.textAlignment = UITextAlignmentCenter;
    dateBegin.userInteractionEnabled = NO;
    dateBegin.textColor = [UIColor blueColor];
    dateBegin.placeholder = @"查询开始日期";
    self.dateBegin = dateBegin;
    self.dateBegin.delegate = self;
    [dateView addSubview:self.dateBegin];
    [dateBegin release];
    //4.2中间分割，
    UILabel *segLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 0, 10, 30)];
    segLabel.backgroundColor = [UIColor clearColor];
    segLabel.textAlignment = UITextAlignmentCenter;
    segLabel.text = @"-";
    self.segLabel = segLabel;
    [dateView addSubview:self.segLabel];
    [segLabel release];
    
    //4.3结束时间
    UITextField *dateEnd = [[UITextField alloc] initWithFrame:CGRectMake(165, 0, 105, 30)];
    dateEnd.backgroundColor = [UIColor clearColor];
    dateEnd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    dateEnd.textAlignment = UITextAlignmentCenter;
    dateEnd.textColor = [UIColor blueColor];
    dateEnd.placeholder = @"查询结束日期";
    self.dateEnd = dateEnd;
    self.dateEnd.delegate = self;
    [dateView addSubview:self.dateEnd];
    [dateEnd release];
    
    self.dateView = dateView;
    [self.view addSubview:self.dateView];
    [dateView release];    
    
    //5.0UItextView 
    UITextView *oilHistoryView = [[UITextView alloc] initWithFrame:CGRectMake(10, kCMNavigationBarHight + 75, 300,292)];
    oilHistoryView.backgroundColor = [UIColor clearColor];
    oilHistoryView.font = [UIFont systemFontOfSize:18];
    oilHistoryView.userInteractionEnabled = YES;
    oilHistoryView.editable = NO;
    self.oilHistoryView = oilHistoryView;
    self.oilHistoryView.delegate = self;
    [self.view addSubview:self.oilHistoryView];
    [oilHistoryView release];
    
    //6.0进度指示
//    UIView *loadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicator.frame = CGRectMake(35, 20, 30, 30);
//    [indicator startAnimating];
//    self.indicator = indicator;
//    [loadView addSubview:self.indicator];
//    [indicator release];
//    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 100, 30)];
//    tipLabel.backgroundColor = [UIColor clearColor];
//    tipLabel.textAlignment = UITextAlignmentCenter;
//    tipLabel.text = @"正在加载数据...";
//    self.tipLabel = tipLabel;
//    [loadView addSubview:self.tipLabel];
//    [tipLabel release];
//    self.loadView = loadView;
//    self.loadView.center = self.view.center;
//    [loadView release];
//    
//    [self.view addSubview:self.loadView];
    
    //7.0UIPickerView
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,460 - kCMNavigationBarHight, kFullScreenWidth, 216)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(pickerValueChangedAction) forControlEvents:UIControlEventValueChanged];
    self.datePicker = datePicker;
    [self.view addSubview:self.datePicker];
    [datePicker release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //查询日期默认
    //获取当前时间
    NSDateFormatter *dateFormater = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormater setDateFormat:kDateFormater];
    NSString *theRightEndDate = [dateFormater stringFromDate:[NSDate date]];
    //获取一周前的时间
    NSDate *now = [NSDate date];
    NSString *theRightBeginDate = [dateFormater stringFromDate:[now dateByAddingTimeInterval:-kQueryOilTimeInterval*3600*24]];
    self.dateBegin.text = theRightBeginDate;
    self.dateEnd.text = theRightEndDate;
    
    NSDate *currentTime = [[NSDate alloc] init];
    [self.datePicker setDate:currentTime animated:YES];
    //socket
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.client.delegate = self;
    self.socket = appDelegate.client;
    NSString *oilHistoryQueryParam = [NSString createOilAnalysisParam:self.terminalNo beginTime:theRightBeginDate endTime:theRightEndDate];
    NSLog(@"oilHistoryQueryParam = %@",oilHistoryQueryParam);
    NSData *query = [oilHistoryQueryParam dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:query withTimeout:-1 tag:5];
    [self.socket readDataWithTimeout:-1 tag:5];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.tipLabel = nil;
    self.titleLabel = nil;
    self.dateView = nil;
    self.dateBegin = nil;
    self.dateEnd = nil;
    self.datePicker = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark buttonAction
/**查询车辆油量历史记录
 *@param nil
 *return nil*/
- (void)oilHistoryAction
{
    NSLog(@"History Oil~");
    //1.0时间判断
    //1.1获取日期之差,判断是否大于系统查询间隔
    NSDateFormatter *formater = [[[NSDateFormatter alloc] init] autorelease];
    [formater setDateFormat:kDateFormater];
    NSDate *beginDate = [formater dateFromString:self.dateBegin.text];
    NSDate *endDate = [formater dateFromString:self.dateEnd.text];
    NSDate *currentDate = [NSDate date];
    
    NSInteger daysBetweenEB = (NSInteger)([endDate timeIntervalSinceDate:beginDate] / ( 3600 * 24 ));
    NSInteger daysBetweenNE = (NSInteger)([currentDate timeIntervalSinceDate:endDate] / ( 3600 * 24 ));
    NSInteger daysBetweenNB = (NSInteger)([currentDate timeIntervalSinceDate:beginDate] / ( 3600 * 24 ));

    NSLog(@"daysBetweenEB=%d,daysBetweenNE=%d,daysBetweenNB=%d",daysBetweenEB,daysBetweenNE,daysBetweenNB);
    NSLog(@"beginDate=%@,endDate=%@,currentDate=%@",beginDate,endDate,currentDate);
    if ( daysBetweenNE >= 0 && daysBetweenNB >= 0 ) {
        if ( daysBetweenEB < 0 ) {
            [self showAlert:kAlertDatesIntervalWrong title:nil message:@"查询开始时间不可大于结束时间"];
        }
        else if ( daysBetweenEB > kQueryOilTimeInterval ) {
            [self showAlert:kAlertDatesIntervalWrong title:nil message:[NSString stringWithFormat:@"查询日期差不可超过%d天",kQueryOilTimeInterval]];
        }
        else {
            NSString *oilHistoryQueryParam = [NSString createOilAnalysisParam:self.terminalNo beginTime:self.dateBegin.text endTime:self.dateEnd.text];
            NSLog(@"oilHistoryQueryParam = %@",oilHistoryQueryParam);
            NSData *query = [oilHistoryQueryParam dataUsingEncoding:NSUTF8StringEncoding];
            [self.socket writeData:query withTimeout:-1 tag:12];
            [self.socket readDataWithTimeout:-1 tag:12];
            [self hidePickerView];
        }
    }
    else {
        [self showAlert:kAlertEndDateWrong title:nil message:@"查询开始/结束时间不可超过当日"];
    }
}

/*@手指触发事件*/
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if ( point.y > kCMNavigationBarHight && point.y < FIELD_DATE_BEGIN_Y + 30 ) {
        
        [self showPickerView];
        if ( point.x < FIELD_DATE_BEGIN_MAX_X ) {
            self.dateBegin.text = @"";
            self.dateChoiceProcess = CMDateChoiceProcessBegin;
        }
        else {
            self.dateEnd.text = @"";
            self.dateChoiceProcess = CMDateChoiceProcessEnd;
        }
    }
}

/**显示滚轮
 *@param nil
 *return nil*/
- (void)showPickerView
{
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.3];
    self.datePicker.center = CGPointMake(160, 308);
    [UIView commitAnimations];
}

/**隐藏滚轮
 *@param nil
 *return nil*/
- (void)hidePickerView
{
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.3];
    self.datePicker.center = CGPointMake(160, 524);
    [UIView commitAnimations];    
}

/**滚轮数值改变
 *@param nil
 *return nil*/
- (void)pickerValueChangedAction
{
    NSDate *selected = [self.datePicker date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:kDateFormater];
    NSString *theDate = [dateFormat stringFromDate:selected];
    switch ( self.dateChoiceProcess ) {
        case CMDateChoiceProcessBegin:
        {
            self.dateBegin.text = theDate;
        }break;
        case CMDateChoiceProcessEnd:
        {
            self.dateEnd.text = theDate;
        }break;
        default:NSLog(@"date choice error～");
            break;
    }
}

/**提醒
 *@param
 *return nil*/
- (void)showAlert:(NSInteger)alertTag title:(NSString *)title message:(NSString *)message
{
    if ( !title ) {
        title = kAlertTitleDefault;
    }
    UIAlertView *tip = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    tip.tag = alertTag;
    [tip show];
    [tip release];
}
#pragma mark - for UITextFieldDelegate
/*@=UITextFieldDelegate*/
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

#pragma AsyncSocket
- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"Sorry this connect is failure");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{  
    NSLog(@"Tag = %ld ,recvData = %@",tag,data);
    NSString *recv = [NSString parseQueryOilAnalysisRecv:data];
    NSLog(@"Tag = %ld ,oilHistoruQuery recv = %@",tag,recv); 
    self.oilHistoryView.text = recv;
}
@end


