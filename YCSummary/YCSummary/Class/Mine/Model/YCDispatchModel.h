//
//  YCDispatchModel.h
//  YCSummary
//
//  Created by wuyongchao on 2018/11/8.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCDispatchModel : NSObject
#pragma mark - 异步执行 + 并行队列
-(void)asyncConcurrent;
#pragma mark - 异步执行+串行队列
-(void)asyncSerial;
#pragma mark - 同步执行 + 并行队列
- (void)syncConcurrent;
#pragma mark - 同步执行 + 串行队列
- (void)syncSerial;
#pragma mark - 异步执行+主队列
-(void)asyncMain;
#pragma mark - 线程间的通信
-(void)communication;
#pragma mark - 栅栏方法
-(void)barrier;
#pragma mark - 快速迭代方法 dispatch_apply
- (void)apply ;
#pragma mark - dispatch_group_notify
-(void)groupNotify;
#pragma mark -dispatch_semaphore_t 信号量相关
-(void)semaphoreSync;
#pragma mark - 非线程安全
-(void)initTicketStatusNotSave;
#pragma mark - 线程安全
-(void)initTicketStatusSave;
#pragma mark - 线程组
- (void)dispatch_group;
#pragma mark - 队列的挂起与恢复
-(void)suspendAndresume;
@end

NS_ASSUME_NONNULL_END
