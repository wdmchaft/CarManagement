//
//  CMTableViewCell.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-8.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarInfo.h"

@class CMTextView;
@interface CMTableViewCell : UITableViewCell
{
    NSString *_terminalNo;
    
    UIImageView *_carImgView;
    
    CMTextView *_carNoCMView;
    
    CMTextView *_speedCMView;
    
    CMTextView *_stateCMView;
    
    CMTextView *_positionCMView;
}

@property (nonatomic,copy) NSString *terminalNo;
@property (nonatomic,retain) UIImageView *carImgView;
@property (nonatomic,retain) CMTextView *carNoCMView;
@property (nonatomic,retain) CMTextView *speedCMView;
@property (nonatomic,retain) CMTextView *stateCMView;
@property (nonatomic,retain) CMTextView *positionCMView;

@end


@interface CMTextView : UIView
{
    UILabel *_titleLabel;
    UILabel *_contentLabel;
}
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UILabel *contentLabel;

@end