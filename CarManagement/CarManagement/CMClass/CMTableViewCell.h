//
//  CMTableViewCell.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-8.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarInfo.h"

@interface CMTableViewCell : UITableViewCell
{
    CarInfo *_theCarInfo;
}

@property (nonatomic,retain) CarInfo *theCarInfo;
@end
