//
//  MainViewController.m
//  CarManagement
//
//  Created by YongFeng.li on 12-3-25.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize contentView = _contentView;
@synthesize carInfoDic = _carInfoDic;
@synthesize carType = _carType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectMake(0, CONTENT_NAVIGATIONBAR_HEIGHT,FULL_SCREEN_WIDTH , FULL_SCREEN_HEIGHT - CONTENT_NAVIGATIONBAR_HEIGHT) style:UITableViewStyleGrouped];
        view.delegate = self;
        view.dataSource = self;
        [self.view addSubview:view];
        [view release];
        
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

#pragma mark - tableview
//section number of the tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.carType count];
}


//row number of the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *carType = [self.carType objectAtIndex:section];
    NSArray *theCarTypeInfo = [self.carInfoDic objectForKey:carType];
    
    return [theCarTypeInfo count];
}

//create the UItableviewcell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if ( cell == nil ) {
        UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier] autorelease];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    //configure the cell
    
    return cell;
    
}

//set the height of the cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}
@end
