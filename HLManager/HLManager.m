//
//  HLManager.m
//  LoveLimit
//
//  Created by MS on 15-9-6.
//  Copyright (c) 2015年 qf. All rights reserved.
//

#import "HLManager.h"

@implementation HLManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (instancetype)defaultManager
{
    static HLManager *hm = nil;
    @synchronized(self){
        if (!hm) {
            hm = [[HLManager alloc] init];
        }
    }
    return hm;
}

- (void)startConnectionWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action tag:(NSInteger)tag
{
    //从记录里查询这个网址
    HLConnection *hc = [_dataDic objectForKey:urlStr];
    
    //如果查到了说明有相同的联网
    if (hc) {
        NSLog(@"相同的网络请求已经存在");
        return;
    }
    
    //创建网络请求并启动
    hc = [HLConnection connectionWithUrlStr:urlStr target:target action:action tag:tag];
    [hc start];
}

- (void)insertHLConnection:(HLConnection *)hc
{
    [_dataDic setObject:hc forKey:hc.urlStr];
}

- (void)deleteHLConnection:(HLConnection *)hc
{
    [_dataDic removeObjectForKey:hc.urlStr];
}

- (void)stopAllConnectionForTarget:(id)target
{
    for (NSString *keyStr in _dataDic) {
        HLConnection *hc = [_dataDic objectForKey:keyStr];
        if (hc.target == target) {
            [hc stop];
        }
    }
}

@end









