//
//  YCOperationModel.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/29.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCOperationModel.h"
#import "YCOperation.h"
@interface YCOperationModel()
@property(nonatomic,strong)NSOperationQueue *queue;
@property(nonatomic,assign)int ticketCount;
@property (readwrite, nonatomic, strong) NSLock *lock;

@end
@implementation YCOperationModel
-(NSOperationQueue *)queue{
    if (!_queue) {
        _queue=[[NSOperationQueue alloc]init];
    }
    return _queue;
}
#pragma mark - 在当前线程使用子类 NSInvocationOperation
- (void)useInvocationOperation{
    
    // 1.创建 NSInvocationOperation 对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    // 2.调用 start 方法开始执行操作
    [op start];
}
#pragma mark - 在其他线程使用子类 NSInvocationOperation
-(void)otherThreaduseInvocationOperation{
    
    [NSThread detachNewThreadSelector:@selector(useInvocationOperation) toTarget:self withObject:nil];

}
#pragma mark - 当前线程使用子类 NSBlockOperation
- (void)useBlockOperation{
    
    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [self task1];
    }];
    
    // 2.调用 start 方法开始执行操作
    [op start];
}
#pragma mark - 子类 NSBlockOperation调用方法 AddExecutionBlock
-(void)useBlockOperationaddExecutionBlock{
    
    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [self task1];
    }];
    
    // 2.添加额外的操作
    [op addExecutionBlock:^{
        [self task2];
    }];
    [op addExecutionBlock:^{
        [self task3];
    }];
    [op start];
}
#pragma mark - 使用自定义继承自 NSOperation 的子类
-(void)useCustomOperation{
    // 1.创建 YCOperation 对象
    YCOperation *op = [[YCOperation alloc] init];
    // 2.调用 start 方法开始执行操作
    [op start];
}
#pragma mark - 加入到操作队列中
- (void)addOperationToQueue{
    // 1.创建队列
    NSInvocationOperation *oper1=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task1) object:nil];
    NSBlockOperation *oper2 = [NSBlockOperation blockOperationWithBlock:^{
        [self task2];
    }];
    // 2.添加额外的操作
    [oper2 addExecutionBlock:^{
        [self task3];
    }];
    // 3.使用addOperation: 添加所有操作到队列中
    [self.queue addOperation:oper1];
    [self.queue addOperation:oper2];
    DebugLog(@"oper1是否取消%d,是否准备就绪%d,是否正在运行%d,是否结束%d",[oper1 isCancelled],[oper1 isReady],[oper1 isExecuting],[oper1 isFinished]);
    /*2018-11-29 18:19:38.163281+0800 YCSummary[22545:338911] 1---<NSThread: 0x600001ea5980>{number = 3, name = (null)}
     2018-11-29 18:19:38.163401+0800 YCSummary[22545:341095] 3---<NSThread: 0x600001ea57c0>{number = 5, name = (null)}
     2018-11-29 18:19:38.163414+0800 YCSummary[22545:341094] 2---<NSThread: 0x600001e824c0>{number = 4, name = (null)}
     2018-11-29 18:19:40.168853+0800 YCSummary[22545:341095] 3---<NSThread: 0x600001ea57c0>{number = 5, name = (null)}
     2018-11-29 18:19:40.168851+0800 YCSummary[22545:341094] 2---<NSThread: 0x600001e824c0>{number = 4, name = (null)}
     2018-11-29 18:19:40.168851+0800 YCSummary[22545:338911] 1---<NSThread: 0x600001ea5980>{number = 3, name = (null)}
*/
}
#pragma mark - addOperationWithBlock: 将操作加入到操作队列中
- (void)addOperationWithBlockToQueue{
    // 1.创建队列
    // 2.使用 addOperationWithBlock: 添加操作到队列中
    [self.queue addOperationWithBlock:^{
        [self task1];
    }];
    [self.queue addOperationWithBlock:^{
       [self task2];
    }];

    [self.queue addOperationWithBlock:^{
        [self task3];
    }];
    /*2018-11-29 18:25:40.698819+0800 YCSummary[22816:347469] 2---<NSThread: 0x600003a87640>{number = 4, name = (null)}
     2018-11-29 18:25:40.698819+0800 YCSummary[22816:347684] 3---<NSThread: 0x600003a87280>{number = 5, name = (null)}
     2018-11-29 18:25:40.698821+0800 YCSummary[22816:347451] 1---<NSThread: 0x600003a7f900>{number = 3, name = (null)}
     2018-11-29 18:25:42.702638+0800 YCSummary[22816:347684] 3---<NSThread: 0x600003a87280>{number = 5, name = (null)}
     2018-11-29 18:25:42.702638+0800 YCSummary[22816:347469] 2---<NSThread: 0x600003a87640>{number = 4, name = (null)}
     2018-11-29 18:25:42.702647+0800 YCSummary[22816:347451] 1---<NSThread: 0x600003a7f900>{number = 3, name = (null)}*/
}
#pragma mark - MaxConcurrentOperationCount最大并发操作数
- (void)setMaxConcurrentOperationCount{
    // 1.创建队列
    // 2.设置最大并发操作数
//    queue.maxConcurrentOperationCount = 1; // 串行队列
    self.queue.maxConcurrentOperationCount = 2; // 并发队列
    //    queue.maxConcurrentOperationCount = 8; // 并发队列
    // 3.添加操作
    [self.queue addOperationWithBlock:^{
        [self task1];
    }];
    [self.queue addOperationWithBlock:^{
        [self task2];
    }];
    [self.queue addOperationWithBlock:^{
        [self task3];
    }];

}

#pragma mark - 设置优先级
/**
 * 设置优先级
 * 就绪状态下，优先级高的会优先执行，但是执行时间长短并不是一定的，所以优先级高的并不是一定会先执行完毕
 */
- (void)setQueuePriority{
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [self task1];
    }];
    [op1 setQueuePriority:(NSOperationQueuePriorityVeryLow)];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{

        [self task2];
    }];
    [op2 setQueuePriority:(NSOperationQueuePriorityVeryHigh)];
    [self.queue addOperation:op1];
    [self.queue addOperation:op2];
   /*2018-11-29 18:33:14.622424+0800 YCSummary[23089:356263] 2---  <NSThread: 0x600003372dc0>{number = 3, name = (null)}
     2018-11-29 18:33:14.622472+0800 YCSummary[23089:356257] 1---<NSThread: 0x600003373600>{number = 4, name = (null)}
     2018-11-29 18:33:16.623022+0800 YCSummary[23089:356263] 2---<NSThread: 0x600003372dc0>{number = 3, name = (null)}
     2018-11-29 18:33:16.623021+0800 YCSummary[23089:356257] 1---<NSThread: 0x600003373600>{number = 4, name = (null)}*/
}
#pragma mark - 添加依赖
- (void)addDependency{
    // 1.创建队列
    // 2.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [self task1];
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
         [self task2];
    }];
    // 3.添加依赖
    [op2 addDependency:op1]; // 让op2 依赖于 op1，则先执行op1，在执行op2
    // 4.添加操作到队列中
    [self.queue addOperation:op1];
    [self.queue addOperation:op2];
    /*2018-11-30 13:40:05.638381+0800 YCSummary[11063:194828] 1---<NSThread: 0x600002003a00>{number = 3, name = (null)}
     2018-11-30 13:40:07.638960+0800 YCSummary[11063:194828] 1---<NSThread: 0x600002003a00>{number = 3, name = (null)}
     2018-11-30 13:40:09.641759+0800 YCSummary[11063:194825] 2---<NSThread: 0x60000200ff40>{number = 4, name = (null)}
     2018-11-30 13:40:11.642255+0800 YCSummary[11063:194825] 2---<NSThread: 0x60000200ff40>{number = 4, name = (null)}*/
}
#pragma mark - 线程间通信
-(void)threadCommunication{
    
    [self.queue addOperationWithBlock:^{
        //异步进行耗时的操作
        [self task1];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            //刷新UI的操作
            [self task2];
        }];
    }];
    /*2018-11-30 13:47:09.612920+0800 YCSummary[11503:201121] 1---<NSThread: 0x6000016c3b80>{number = 3, name = (null)}
     2018-11-30 13:47:11.618442+0800 YCSummary[11503:201121] 1---<NSThread: 0x6000016c3b80>{number = 3, name = (null)}
     2018-11-30 13:47:13.619419+0800 YCSummary[11503:201029] 2---<NSThread: 0x600001645f80>{number = 1, name = main}
     2018-11-30 13:47:15.620608+0800 YCSummary[11503:201029] 2---<NSThread: 0x600001645f80>{number = 1, name = main}*/
    
}
#pragma mark - 完成操作
-(void)completionBlock{
    NSBlockOperation *oper1=[NSBlockOperation blockOperationWithBlock:^{
        [self task1];
    }];
    oper1.completionBlock = ^{
        [self task2];
    };
    [self.queue addOperation:oper1];
    /*2018-11-30 13:52:03.974761+0800 YCSummary[11687:205130] 1---<NSThread: 0x60000019ebc0>{number = 3, name = (null)}
     2018-11-30 13:52:05.976205+0800 YCSummary[11687:205130] 1---<NSThread: 0x60000019ebc0>{number = 3, name = (null)}
     2018-11-30 13:52:07.977855+0800 YCSummary[11687:205139] 2---<NSThread: 0x6000001993c0>{number = 4, name = (null)}
     2018-11-30 13:52:09.981689+0800 YCSummary[11687:205139] 2---<NSThread: 0x6000001993c0>{number = 4, name = (null)}
*/
}
#pragma mark - 取消线程
-(void)cancelOperation{
    //取消,不可以恢复
    //该方法内部调用了所有操作的cancel方法
    [self.queue cancelAllOperations];
}
#pragma mark - 暂停队列
-(void)suspendOperation{
    //暂停,是可以恢复
    /*
     队列中的任务也是有状态的:已经执行完毕的 | 正在执行 | 排队等待状态
     */
    //不能暂停当前正在处于执行状态的任务
    [self.queue setSuspended:YES];
}
#pragma mark - 模拟售票<非线程安全>
-(void)ticketStatusNotSafe{
    self.ticketCount=10;
    NSOperationQueue *queue1=[[NSOperationQueue alloc]init];
    queue1.maxConcurrentOperationCount=1;
    NSOperationQueue *queue2=[[NSOperationQueue alloc]init];
    queue2.maxConcurrentOperationCount=1;
//    __weak typeof(self) weakSelf=self;
    NSBlockOperation *oper1=[NSBlockOperation blockOperationWithBlock:^{
        [self saleTicketNotSafe];
    }];
    NSBlockOperation *oper2=[NSBlockOperation blockOperationWithBlock:^{
        [self saleTicketNotSafe];
    }];
    [queue1 addOperation:oper1];
    [queue2 addOperation:oper2];


}
//售卖火车票，非线程安全
//不考虑线程安全，不使用semaphore的情况下，得到的票数是乱序的
-(void)saleTicketNotSafe{
    while (1) {
        if (self.ticketCount>0) {
            self.ticketCount--;
            NSLog(@"剩余票数：%d 窗口：%@",self.ticketCount,[NSThread currentThread]);
        }
        else{
            NSLog(@"所有火车票均已售完");
            break;
        }
    }
    /*2018-11-30 14:27:36.046096+0800 YCSummary[12891:232650] 剩余票数：9 窗口：<NSThread: 0x6000028751c0>{number = 3, name = (null)}
     2018-11-30 14:27:36.046088+0800 YCSummary[12891:233790] 剩余票数：8 窗口：<NSThread: 0x600002870380>{number = 4, name = (null)}
     2018-11-30 14:27:53.808430+0800 YCSummary[12891:232650] 剩余票数：7 窗口：<NSThread: 0x6000028751c0>{number = 3, name = (null)}
     2018-11-30 14:27:53.808430+0800 YCSummary[12891:233790] 剩余票数：7 窗口：<NSThread: 0x600002870380>{number = 4, name = (null)}
     2018-11-30 14:28:03.039883+0800 YCSummary[12891:232650] 剩余票数：6 窗口：<NSThread: 0x6000028751c0>{number = 3, name = (null)}
     2018-11-30 14:28:04.622793+0800 YCSummary[12891:233790] 剩余票数：5 窗口：<NSThread: 0x600002870380>{number = 4, name = (null)}
     2018-11-30 14:28:09.137813+0800 YCSummary[12891:232650] 剩余票数：4 窗口：<NSThread: 0x6000028751c0>{number = 3, name = (null)}
     2018-11-30 14:28:09.981432+0800 YCSummary[12891:233790] 剩余票数：3 窗口：<NSThread: 0x600002870380>{number = 4, name = (null)}
     2018-11-30 14:28:10.873557+0800 YCSummary[12891:233790] 剩余票数：1 窗口：<NSThread: 0x600002870380>{number = 4, name = (null)}
     2018-11-30 14:28:10.873564+0800 YCSummary[12891:232650] 剩余票数：2 窗口：<NSThread: 0x6000028751c0>{number = 3, name = (null)}
     2018-11-30 14:28:11.705410+0800 YCSummary[12891:232650] 剩余票数：0 窗口：<NSThread: 0x6000028751c0>{number = 3, name = (null)}
     2018-11-30 14:28:11.705410+0800 YCSummary[12891:233790] 剩余票数：-1 窗口：<NSThread: 0x600002870380>{number = 4, name = (null)}
     2018-11-30 14:28:12.572108+0800 YCSummary[12891:233790] 所有火车票均已售完
     2018-11-30 14:28:12.572108+0800 YCSummary[12891:232650] 所有火车票均已售完*/
}
#pragma mark - 模拟售票<线程安全>
-(void)ticketStatusSafe{
    self.ticketCount=10;
    self.lock=[[NSLock alloc]init];
    NSOperationQueue *queue1=[[NSOperationQueue alloc]init];
    queue1.maxConcurrentOperationCount=1;
    NSOperationQueue *queue2=[[NSOperationQueue alloc]init];
    queue2.maxConcurrentOperationCount=1;
    NSBlockOperation *oper1=[NSBlockOperation blockOperationWithBlock:^{
        [self saleTicketSafe];
    }];
    NSBlockOperation *oper2=[NSBlockOperation blockOperationWithBlock:^{
        [self saleTicketSafe];
    }];
    [queue1 addOperation:oper1];
    [queue2 addOperation:oper2];
}

-(void)saleTicketSafe{
    while (1) {
        [self.lock lock];
        if (self.ticketCount>0) {
            self.ticketCount--;
            NSLog(@"剩余票数：%d 窗口：%@",self.ticketCount,[NSThread currentThread]);
            
        }
        [self.lock unlock];
        if (self.ticketCount<=0) {
            NSLog(@"所有火车票均已售完");
            break;
        }
      
    }
    /*
     2018-11-30 14:44:56.476701+0800 YCSummary[13580:247970] 剩余票数：9 窗口：<NSThread: 0x600003072040>{number = 3, name = (null)}
     2018-11-30 14:44:56.477211+0800 YCSummary[13580:247981] 剩余票数：8 窗口：<NSThread: 0x600003074400>{number = 4, name = (null)}
     2018-11-30 14:44:56.477465+0800 YCSummary[13580:247970] 剩余票数：7 窗口：<NSThread: 0x600003072040>{number = 3, name = (null)}
     2018-11-30 14:44:56.477697+0800 YCSummary[13580:247981] 剩余票数：6 窗口：<NSThread: 0x600003074400>{number = 4, name = (null)}
     2018-11-30 14:44:56.477909+0800 YCSummary[13580:247970] 剩余票数：5 窗口：<NSThread: 0x600003072040>{number = 3, name = (null)}
     2018-11-30 14:44:56.478089+0800 YCSummary[13580:247981] 剩余票数：4 窗口：<NSThread: 0x600003074400>{number = 4, name = (null)}
     2018-11-30 14:44:56.478278+0800 YCSummary[13580:247970] 剩余票数：3 窗口：<NSThread: 0x600003072040>{number = 3, name = (null)}
     2018-11-30 14:44:56.478475+0800 YCSummary[13580:247981] 剩余票数：2 窗口：<NSThread: 0x600003074400>{number = 4, name = (null)}
     2018-11-30 14:44:56.478617+0800 YCSummary[13580:247970] 剩余票数：1 窗口：<NSThread: 0x600003072040>{number = 3, name = (null)}
     2018-11-30 14:44:56.478768+0800 YCSummary[13580:247981] 剩余票数：0 窗口：<NSThread: 0x600003074400>{number = 4, name = (null)}
     2018-11-30 14:44:56.478940+0800 YCSummary[13580:247981] 所有火车票均已售完
     2018-11-30 14:44:56.478940+0800 YCSummary[13580:247970] 所有火车票均已售完
*/
    
}
/**
 * 任务1
 */
- (void)task1 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);     // 打印当前线程
    }
}
/**
 * 任务2
 */
- (void)task2 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]);     // 打印当前线程
    }
}
/**
 * 任务3
 */
- (void)task3 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@", [NSThread currentThread]);     // 打印当前线程
    }
}
@end
