//
//  DrawLine.m
//  CarManagement
//
//  Created by YongFeng.li on 12-4-4.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import "DrawLine.h"
#import <QuartzCore/QuartzCore.h>

@implementation DrawLine

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
   CGContextRef context = UIGraphicsGetCurrentContext();
   [[UIColor blackColor] set];
   CGContextSetLineWidth(context, 2.0f);
   CGContextMoveToPoint(context, 0, 0);
   CGContextAddLineToPoint(context, 320, 0);
   CGContextStrokePath(context);
 
}


@end
