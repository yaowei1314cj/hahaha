//
//  HLManager.h
//  LoveLimit
//
//  Created by MS on 15-9-6.
//  Copyright (c) 2015年 qf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLConnection.h"

@interface HLManager : NSObject

{
    //用来记录所有的hc对象
    NSMutableDictionary *_dataDic;
}

//单例方法
+ (instancetype)defaultManager;

//通过管理者启动网络请求
- (void)startConnectionWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action tag:(NSInteger)tag;

//添加、删除记录
- (void)insertHLConnection:(HLConnection *)hc;
- (void)deleteHLConnection:(HLConnection *)hc;

//停止某一个页面里所有的网络请求
- (void)stopAllConnectionForTarget:(id)target;

@end
















