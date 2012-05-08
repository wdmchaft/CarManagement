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
    NSString *_terminalNo;
}

@property (nonatomic,copy) NSString *terminalNo;
@end
