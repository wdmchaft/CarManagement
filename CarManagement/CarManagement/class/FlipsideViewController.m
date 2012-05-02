//
//  FlipsideViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-3-25.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import "FlipsideViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DrawLine.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize ipLabel = _ipLabel;
@synthesize ipField = _ipField;
@synthesize portLabel = _portLabel;
@synthesize portField = _portField;
@synthesize settingView = _settingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //导航栏标题
        [self setNavigationBarTitle:@"设置"];
        
        UIView *settingView = [[UIView alloc] initWithFrame:CGRectMake(20, 150, 280, 80)];
        UIView *ipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 40)];
        UIView *portView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 280, 40)];
        
        settingView.layer.cornerRadius = 8.0f;
        settingView.layer.masksToBounds = YES;
        settingView.layer.borderWidth = 1.0f;
        settingView.backgroundColor = [UIColor whiteColor];
        
        
        NSString *ip;
        NSString *port;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        ip = [defaults objectForKey:@"ip"];
        port = [defaults objectForKey:@"port"];
        
        //ip地址和端口输入框
        _ipField = [FlipsideViewController textInputFieldForCellWithValue:ip secure:NO];
        _ipField.placeholder = @"ipAddress";
        _ipField.delegate = self;
        
        _portField = [FlipsideViewController textInputFieldForCellWithValue:port secure:NO];
        _portField.placeholder = @"pwd";
        _portField.delegate = self;
        
        [ipView addSubview:[self containerCellWithTitle:@"地址" view:self.ipField]];
        [portView addSubview:[self containerCellWithTitle:@"端口" view:self.portField]];
        
        //输入框中间的线
        DrawLine *line = [[DrawLine alloc] initWithFrame:CGRectMake(0, 40, 280, 4)];
        line.backgroundColor = [UIColor clearColor];
        [settingView addSubview:ipView];
        [settingView addSubview:portView];
        [settingView addSubview:line];
        [self.view addSubview:settingView];
        [line release];
        [ipView release];
        [portView release];
        [settingView release];
                                                            
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

- (void)dealloc
{
    [_ipLabel release];
    [_ipField release];
    [_portLabel release];
    [_portField release];
    
    [super dealloc];
}
#pragma mark - for kinds of action
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -for tableview
//secction 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

//row of section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

//title of section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

//create cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    return nil;
    
}


#pragma mark - cell
//产生输入框
+ (UITextField*)textInputFieldForCellWithValue:(NSString*)value secure:(BOOL)secure {
	
	UITextField *textField = [[[UITextField alloc] 
                               initWithFrame:CGRectMake(50,0, 210, 24)] autorelease];
	textField.text = value;
	textField.placeholder = @"";
	textField.secureTextEntry = secure;
	textField.keyboardType = UIKeyboardTypeASCIICapable;
	textField.returnKeyType = UIReturnKeyDone;
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //	textField.textColor = RGBCOLOR(0,0,0);
	//*/
	
	return textField;
	
}
//含输入提示＆输入框
- (UIView*)containerCellWithTitle:(NSString*)title view:(UIView*)view {
	UIView *cell = [[[UIView alloc] initWithFrame:CGRectMake(10, 10, 260, 50)] autorelease];
	UITextField* label = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
	label.text = title;
	label.enabled = NO;
	[cell addSubview:label];
	[label autorelease];
    
	[cell addSubview:view];
    
	return cell;
}

@end
