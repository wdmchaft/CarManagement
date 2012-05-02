//
//  Socket.h
//  CarManagement
//
//  Created by YongFeng.li on 12-5-2.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <stdio.h>
#import <stdlib.h>
#import <unistd.h>
#import <arpa/inet.h>
#import <sys/types.h>
#import <sys/socket.h>
#import <netdb.h>

@interface Socket : NSObject
{
    int sockfd;
	
    struct sockaddr_in their_addr;
	NSString * receiveContent;
}
@property (nonatomic, retain) NSString *receiveContent;
- (void)Connect:(NSString *)ip prot:(int)port content:(NSString *)contentInit;
- (void)sendMessage:(NSString *)content;
@end
