//
//  YCOperationModel.h
//  YCSummary
//
//  Created by wuyongchao on 2018/11/29.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCOperationModel : NSObject
#pragma mark - 使用子类 NSInvocationOperation
- (void)useInvocationOperation;
#pragma mark - 在其他线程使用子类 NSInvocationOperation
-(void)otherThreaduseInvocationOperation;
#pragma mark - 当前线程使用子类 NSBlockOperation
- (void)useBlockOperation;
#pragma mark - 子类 NSBlockOperation调用方法 AddExecutionBlock
-(void)useBlockOperationaddExecutionBlock;
#pragma mark - 使用自定义继承自 NSOperation 的子类
-(void)useCustomOperation;
#pragma mark - 加入到操作队列中
- (void)addOperationToQueue;
#pragma mark - addOperationWithBlock: 将操作加入到操作队列中
- (void)addOperationWithBlockToQueue;
#pragma mark - MaxConcurrentOperationCount最大并发操作数
- (void)setMaxConcurrentOperationCount;
#pragma mark - 设置优先级
- (void)setQueuePriority;
#pragma mark - 添加依赖
- (void)addDependency;
#pragma mark - 线程间通信
-(void)threadCommunication;
#pragma mark - 完成操作
-(void)completionBlock;
#pragma mark - 取消线程
-(void)cancelOperation;
#pragma mark - 暂停队列
-(void)suspendOperation;
#pragma mark - 模拟售票<非线程安全>
-(void)ticketStatusNotSafe;
#pragma mark - 模拟售票<线程安全>
-(void)ticketStatusSafe;
@end

NS_ASSUME_NONNULL_END
