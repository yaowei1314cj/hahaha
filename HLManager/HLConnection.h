//
//  HLConnection.h
//  LoveLimit
//
//  Created by MS on 15-9-6.
//  Copyright (c) 2015年 qf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLConnection : NSObject <NSURLConnectionDataDelegate>

{
    NSURLConnection *_uc;
}

@property (nonatomic, copy)   NSString      *urlStr;
@property (nonatomic, retain) NSMutableData *downloadData;
@property (nonatomic, assign) NSInteger     tag;
@property (nonatomic, assign) BOOL          isSuccess;

//记录一个对象
@property (nonatomic, weak) id target;
//记录一个方法
@property (nonatomic, assign) SEL action;

- (id)initWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action tag:(NSInteger)tag;

+ (instancetype)connectionWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action tag:(NSInteger)tag;

+ (instancetype)connectionWithUrlStr:(NSString *)urlStr target:(id)target action:(SEL)action;

- (void)start;

- (void)stop;

@end





