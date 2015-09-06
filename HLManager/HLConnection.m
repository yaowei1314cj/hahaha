//
//  HLConnection.m
//  LoveLimit
//
//  Created by MS on 15-9-6.
//  Copyright (c) 2015年 qf. All rights reserved.
//

#import "HLConnection.h"
#import "HLManager.h"

@implementation HLConnection

- (id)initWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action tag:(NSInteger)tag
{
    if (self = [super init]) {
        self.urlStr = urlStr;
        self.target = target;
        self.action = action;
        self.tag = tag;
        NSLog(@"url = %@", urlStr);
    }
    return self;
}

+ (instancetype)connectionWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action tag:(NSInteger)tag
{
    return [[HLConnection alloc] initWithUrlStr:urlStr target:target action:action tag:tag];
}

+ (instancetype)connectionWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action
{
    return [HLConnection connectionWithUrlStr:urlStr target:target action:action tag:0];
}

- (void)start
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    _downloadData = [[NSMutableData alloc] init];
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _uc = [NSURLConnection connectionWithRequest:request delegate:self];
    
    //添加记录
    [[HLManager defaultManager] insertHLConnection:self];
}

- (void)stop
{
    [_uc cancel];
    
    //删除记录
    [[HLManager defaultManager] deleteHLConnection:self];
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _downloadData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_downloadData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _isSuccess = YES;
    
    [self.target performSelector:self.action withObject:self afterDelay:0];
    
    [[HLManager defaultManager] deleteHLConnection:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _isSuccess = NO;
    
    [self.target performSelector:self.action withObject:self afterDelay:0];
    
    [[HLManager defaultManager] deleteHLConnection:self];
}

- (void)dealloc
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end







