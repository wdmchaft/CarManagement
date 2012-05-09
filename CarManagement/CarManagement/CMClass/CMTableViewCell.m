//
//  CMTableViewCell.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-8.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import "CMTableViewCell.h"

@implementation CMTableViewCell
@synthesize terminalNo = _terminalNo;
@synthesize carImgView = _carImgView;
@synthesize carNoCMView = _carNoCMView;
@synthesize speedCMView = _speedCMView;
@synthesize stateCMView = _stateCMView;
@synthesize positionCMView = _positionCMView;

- (void)dealloc
{
    [_carImgView release];
    [_carNoCMView release];
    [_speedCMView release];
    [_stateCMView release];
    [_positionCMView release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //1.0carImgView
        UIImageView *carImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 40, 40)];
        carImgView.backgroundColor = [UIColor clearColor];
        self.carImgView = carImgView;
        [self addSubview:self.carImgView];
        [carImgView release];
        
        //2.0carNoCMView
        CMTextView *carNoCMView = [[CMTextView alloc] initWithFrame:CGRectMake(70, 5, 230, 20)];
        carNoCMView.backgroundColor = [UIColor clearColor];
        carNoCMView.titleLabel.text = @"车牌:";
        self.carNoCMView = carNoCMView;
        [self addSubview:self.carNoCMView];
        [carNoCMView release];
        
        //3.0speedCMView
        CMTextView *speedCMView = [[CMTextView alloc] initWithFrame:CGRectMake(70, 25, 230, 20)];
        speedCMView.backgroundColor = [UIColor clearColor];
        speedCMView.titleLabel.text = @"速度(km/h):";
        self.speedCMView = speedCMView;
        [self addSubview:self.speedCMView];
        [speedCMView release];
        
        //4.0stateCMView
        CMTextView *stateCMView = [[CMTextView alloc] initWithFrame:CGRectMake(20, 50, 280, 20)];
        stateCMView.backgroundColor = [UIColor clearColor];
        //test 2lines
        stateCMView.titleLabel.backgroundColor = [UIColor blueColor];
        stateCMView.contentLabel.backgroundColor = [UIColor yellowColor];
        stateCMView.titleLabel.text = @"状态:";
        self.stateCMView = stateCMView;
        [self addSubview:self.stateCMView];
        [stateCMView release];
        
        //5.0positionCMView
        CMTextView *positionCMView = [[CMTextView alloc] initWithFrame:CGRectMake(20, 70, 260, 40)];
        positionCMView.backgroundColor = [UIColor clearColor];
        //test 2lines
        positionCMView.titleLabel.backgroundColor = [UIColor redColor];
        positionCMView.contentLabel.backgroundColor = [UIColor purpleColor];
        positionCMView.titleLabel.text = @"位置:";
        self.positionCMView = positionCMView;
        [self addSubview:self.positionCMView];
        [positionCMView release];
        

        
//        //2.0speedField
//        UITextField *carNoField = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, 220, 20)];
//        carNoField.backgroundColor = [UIColor clearColor];
//        carNoField.font = [UIFont systemFontOfSize:15];
//        carNoField.enabled = NO;
//        self.carNoField = carNoField;
//        [self addSubview:self.carNoField];
//        [carNoField release];
//        
//        //3.0speedField
//        UITextField *speedField = [[UITextField alloc] initWithFrame:CGRectMake(70, 25, 220, 20)];
//        speedField.backgroundColor = [UIColor clearColor];
//        speedField.font = [UIFont systemFontOfSize:15];
//        speedField.enabled = NO;
//        self.speedField = speedField;
//        [self addSubview:self.speedField];
//        [speedField release];
//        
//        //4.0carState
//        UITextField *stateField = [[UITextField alloc] initWithFrame:CGRectMake(20, 46, 263, 20)];
//        stateField.backgroundColor = [UIColor clearColor];
//        stateField.font = [UIFont systemFontOfSize:15];
//        stateField.enabled = NO;
//        self.stateField = stateField;
//        [self addSubview:self.stateField];
//        [stateField release];
//        
//        //5.0carPosition
//        UITextField *positionField = [[UITextField alloc] initWithFrame:CGRectMake(20, 66, 263, 40)];
//        positionField.backgroundColor = [UIColor clearColor];
//        positionField.font = [UIFont systemFontOfSize:15];
//        positionField.enabled = NO;
//        self.positionField = positionField;
//        [self addSubview:self.positionField];
//        [positionField release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation CMTextView
@synthesize titleLabel = _titleLabel;
@synthesize contentLabel = _contentLabel;

///**初始化
// *@param title:标题 content:内容
// *return self*/
//- (id)initWithTitle:(NSString *)title content:(NSString *)content
//{
//    self = [super init];
//    if ( self ) {
//        
//    }
//}

- (void)dealloc
{
    [_titleLabel release];
    [_contentLabel release];
    
    [super dealloc];
}

/**初始化
 *@param frame:CMTextView大小
 *return self*/
- (id)initWithFrame:(CGRect)frame  
{
    self = [super initWithFrame:frame];
    if ( self ) {
 
        CGRect bounds = [self bounds];
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blueColor];
        self.titleLabel = titleLabel;
        [titleLabel release];
        
//        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
        UILabel *contentLabel = [[UILabel alloc] init];
//        contentLabel.numberOfLines = 3;
        contentLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;    
        //contentLabel.adjustsFontSizeToFitWidth = YES;
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.contentMode = UIViewContentModeScaleToFill;
        
        self.contentLabel = contentLabel;
        [self.contentLabel addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [contentLabel release];
    }
    
    return self;
}

- (void)layoutSubviews
{
    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    self.titleLabel.frame = CGRectMake(0, 0, titleSize.width * 1.2, titleSize.height);
    
    CGSize contentSize = [self.contentLabel.text sizeWithFont:self.contentLabel.font];
    NSInteger lineNum  = 1;
    if ( contentSize.width > 205 ) {
        lineNum = (NSInteger)(( contentSize.width - 205 ) / 245 + 1 );
        if ( contentSize.width > 450 ) {
            lineNum ++;
        }
    }
    NSLog(@"contentSize.width = %f lineNum = %d",contentSize.width,lineNum);  
    float contentLabelHight = lineNum * contentSize.height;
    self.contentLabel.frame = CGRectMake(0, 0, 260, contentLabelHight);
    self.contentLabel.numberOfLines = lineNum;
}
@end
