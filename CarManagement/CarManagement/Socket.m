//
//  Socket.m
//  CarManagement
//
//  Created by YongFeng.li on 12-5-2.
//  Copyright (c) 2012年 renren.com. All rights reserved.
//

#import "Socket.h"
#import <iconv.h>

#define HTTPMETHOD @"GET"
#define HTTPVERSION @"HTTP/1.1"
#define HTTPHOST @"Host"
#define KENTER @"\r\n"
#define KBLANK @" "


@implementation Socket
@synthesize receiveContent;
void error_handle(char *errorMsg)
{	
    fputs(errorMsg, stderr);	
    fputc('\n',stderr);	
    exit(1);	
}

- (void)Connect:(NSString *)ip prot:(int)port content:(NSString *)contentInit
{  	
	NSLog(@"send to %@:%d   %@",ip,port,contentInit);
    if((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1)		
    {		
        perror("socket");		
        exit(1);		
    }
	NSLog(@"socketid : %d",sockfd);
	their_addr.sin_family = AF_INET;
	their_addr.sin_addr.s_addr = inet_addr([ip UTF8String]);		
	their_addr.sin_port = htons(port);	
	bzero(&(their_addr.sin_zero), 8);	
	int conn = connect(sockfd, (struct sockaddr*)&their_addr, sizeof(struct sockaddr));	
	if(conn != -1)		
	{
		// connect success
		NSLog(@"connect success");
		[self sendMessage:contentInit];
		NSMutableString* readString = [[NSMutableString alloc] init];		
		char readBuffer[1024];		
		int br = 0;		
		while((br = recv(sockfd, readBuffer, sizeof(readBuffer), 0)) < sizeof(readBuffer))			
		{					
            NSLog(@"++cvdfd..%d",br);
            printf("readBuffer = %s\n",readBuffer);
            
            char *testStr = "helloworld哈";
            NSString *recv11 = [NSString stringWithCString:readBuffer encoding:NSUTF8StringEncoding];
            NSLog(@"recv11 = %@\n",recv11);
            
            NSString *recv12 = [NSString stringWithUTF8String:testStr];
            NSLog(@"recv12 = %@\n",recv12);
            
            NSString *recv4 = [NSString stringWithCString:testStr encoding:kCFStringEncodingGB_2312_80];
            NSLog(@"recv4 = %@\n",recv4);
            
            // CFStringRef cfStr = CFStringCreateWithCString(kCFAllocatorDefault, readBuffer, NSUTF8StringEncoding);
            
            
            NSString *recv10 = [NSString stringWithCString:testStr encoding:NSUTF8StringEncoding];
            NSLog(@"recv10 = %@\n",recv10);
            
            NSString *recv13 = [[NSString alloc] initWithFormat:@"%s",readBuffer];
            NSLog(@"recv13 = %@\n",recv13);
            
            NSString *recvStr = [NSString stringWithCString:testStr encoding:2147485234];
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            UInt32 encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSString *recv6 = [NSString stringWithCString:testStr encoding:encoding];
            //NSString *recv = [NSString stringWithCString:readBuffer encoding:enc];
            NSString *recv = [NSString stringWithCString:testStr encoding:enc];
            NSString *recv1 = [NSString stringWithCString:testStr encoding:NSUTF8StringEncoding];
            NSString *recv2 = [NSString stringWithCString:testStr encoding:NSASCIIStringEncoding];
            NSLog(@"recv2 = %@\n",recv2);
            NSLog(@"recv1 = %@\n",recv1);
            NSLog(@"recv6 = %@\n",recv6);
            
            
            //编码转换gb2312-->utf8
            //  NSString *recv = [self getANSIString:test length:br];
            NSLog(@"recvStr = %@\n",recvStr);
            NSLog(@"Hava received datas is :%@",recv);
            
            //if ([readString hasSuffix:@";"]) {
            // NSLog(@"Hava received datas is :%@",readString);
            self.receiveContent = readString;
            readString = nil; 
            readString = [[NSMutableString alloc] init];
			//}
			if (br<=0) {
				NSLog(@"read fail......br .....");
				close(sockfd);	
				[NSThread sleepForTimeInterval:2];
				[[NSNotificationCenter defaultCenter] postNotificationName:@"notifySocket" object:self];
				break;
			}
		}					
	}else {		
		NSLog(@"connet fail......br .....");
		close(sockfd);
		[NSThread sleepForTimeInterval:3];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"notifySocket" object:self];
	}
	
}

-(void)sendMessage:(NSString *)content{
	NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];		
	ssize_t dataSended = send(sockfd, [data bytes], [data length], 0);		
	if(dataSended == [data length])			
	{			
		NSLog(@"Datas have been sended over!");	
    }
}

#pragma mark Encode Chinese to ISO8859-1 in URL  
int code_convert(char *from_charset, char *to_charset, char *inbuf, size_t inlen, char *outbuf, size_t outlen) {
    iconv_t cd = NULL;
    
    cd = iconv_open(to_charset, from_charset);
    if(!cd)
        return -1;
    
    memset(outbuf, 0, outlen);
    if(iconv(cd, &inbuf, &inlen, &outbuf, &outlen) == -1)
        return -1;
    
    iconv_close(cd);
    return 0;
}

int u2g(char *inbuf, size_t inlen, char *outbuf, size_t outlen) {
    return code_convert("utf-8", "gb2312", inbuf, inlen, outbuf, outlen);
}

int g2u(char *inbuf, size_t inlen, char *outbuf,size_t outlen) {
    return code_convert("gb2312", "utf-8", inbuf, inlen, outbuf, outlen);
}


- (NSString *)getANSIString:(char *)orginal length:(int) length
{
    int utf8Len = length * 2;
    char *utf8String = (char *)malloc(utf8Len);
    memset(utf8String, 0, utf8Len); //虽然code_convert中也memset了, 但还是自己分配后就set一次比较好
    int result = code_convert("gb2312", "utf-8", orginal, length , utf8String, utf8Len);
    if(result == -1) {
        free(utf8String);
        return nil;
    }
    NSString *retString = [NSString stringWithUTF8String:utf8String];
    free(utf8String);
    return retString;
    
}

//转换成GB2312----uif8
/*
 -(CFStringRef)EncodeUTF8Str:(NSString *)encodeStr{
 CFStringRef nonAlphaNumValidChars = CFSTR("![        DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");        
 CFStringRef preprocessedString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(__bridge CFStringRef)encodeStr, CFSTR(""), kCFStringEncodingUTF8);        
 CFStringRef newStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingUTF8);
 return newStr;
 }
 
 
 //uft8-----gb2312
 -(NSString *)EncodeGB2312Str:(NSString *)encodeStr{  
 CFStringRef nonAlphaNumValidChars = CFSTR("![        DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");          
 NSString *preprocessedString = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)encodeStr, CFSTR(""), kCFStringEncodingGB_18030_2000);          
 NSString *newStr = [(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingGB_18030_2000) autorelease];  
 [preprocessedString release];  
 return newStr;          
 }
 */

@end
