//
//  SettingViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-4.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "SettingViewController.h"

#define kServerSettingKey             @"服务器配置"
#define kSetServerIpAddress           @"ip地址"
#define kSetServerIpPort              @"端口号"
#define kSetAoubtCarManager           @"胖总车管"
#define kSettingTableCellHight        40
@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize settingTView = _settingTView;
@synthesize settingsDic = _settingDic;
@synthesize settingKeys = _settingKeys;
@synthesize serverIpAddressField = _serverIpAddressField;
@synthesize serverIpPortField = _serverIpPortField;

- (void)dealloc
{
    [_settingTView release];
    [_settingDic release];
    [_settingKeys release];
    [_serverIpAddressField release];
    [_serverIpPortField release];
    
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    //0.0self.view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kFullScreenWidth, kFullScreenWidth)];
    view.backgroundColor = [UIColor whiteColor];
    
    //1.0tableview
    UITableView *settingTView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    settingTView.backgroundColor = [UIColor whiteColor];
    settingTView.sectionHeaderHeight = 20;
    settingTView.sectionFooterHeight = 10;
    self.settingTView = settingTView;
    self.settingTView.delegate = self;
    self.settingTView.dataSource = self;
    [settingTView release];
    
    [view addSubview:self.settingTView];
    self.view = view;
    [view release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSArray *settingKeys = [[NSArray alloc] initWithObjects:kServerSettingKey,kSetAoubtCarManager,nil];
    self.settingKeys = settingKeys;
    [settingKeys release];
    
    NSArray *serverSetting = [NSArray arrayWithObjects:kSetServerIpAddress,kSetServerIpPort,nil];
    NSArray *aboutCarManager = [NSArray arrayWithObjects:kSetAoubtCarManager,nil];
    NSMutableDictionary *settingDics = [[NSMutableDictionary alloc] init];
    [settingDics setObject:serverSetting forKey:kServerSettingKey];
    [settingDics setObject:aboutCarManager forKey:kSetAoubtCarManager];
    self.settingsDic = [NSDictionary dictionaryWithDictionary:settingDics];
    [settingDics release];
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

#pragma tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *key = [self.settingKeys objectAtIndex:[indexPath section]];
    NSString *settingName = [[self.settingsDic objectForKey:key] objectAtIndex:[indexPath row]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ( [settingName isEqualToString:kSetServerIpAddress] ) {
        if ( !self.serverIpAddressField ) {
            UITextField *serverIpAddressField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, 200, kSettingTableCellHight)];
            serverIpAddressField.placeholder = kSetServerIpAddress;
            serverIpAddressField.text = [defaults objectForKey:kLastServerIpAddress];
            serverIpAddressField.keyboardType = UIKeyboardTypeASCIICapable;
            serverIpAddressField.clearButtonMode  = UITextFieldViewModeWhileEditing;
            serverIpAddressField.returnKeyType = UIReturnKeyDone;
            self.serverIpAddressField = serverIpAddressField;
            self.serverIpAddressField.delegate = self;
            [serverIpAddressField release];
        }
        
        cell.accessoryView = self.serverIpAddressField;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if ( [settingName isEqualToString:kSetServerIpPort] ) {
        if ( !self.serverIpPortField ) {
            UITextField *serverIpPortField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, 200, kSettingTableCellHight)];
            serverIpPortField.placeholder = kSetServerIpPort;
            serverIpPortField.text = [defaults objectForKey:kLastServerIpPort];
            serverIpPortField.keyboardType = UIKeyboardTypeASCIICapable;
            serverIpPortField.clearButtonMode  = UITextFieldViewModeWhileEditing;
            serverIpPortField.returnKeyType = UIReturnKeyDone;
            self.serverIpPortField = serverIpPortField;
            self.serverIpPortField.delegate = self;
            [serverIpPortField release];
        }
        
        cell.accessoryView = self.serverIpPortField;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }

    cell.textLabel.text = settingName;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.settingKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.settingKeys objectAtIndex:section];
    
    return [[self.settingsDic objectForKey:key] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = [self.settingKeys objectAtIndex:section];
    
    return key;
}

#pragma textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
       
    return YES;
}
@end
