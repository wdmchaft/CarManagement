//
//  LocationMapViewController.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-6.
//  Copyright (c) 2012年 gpssos.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CMBaseViewController.h"

@interface LocationMapViewController : CMBaseViewController
{
    MKMapView *_mapView;
    
    NSString *_terminalNo;
}

@property (nonatomic,retain) MKMapView *mapView;
@property (nonatomic,copy) NSString *terminalNo;

/**初始化
 *@param terminalNo:终端号码
 *return self*/
- (id)initWithTerminalNo:(NSString *)terminalNoParam;
@end
