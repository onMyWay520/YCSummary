//
//  YCDispatchModel.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/8.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCDispatchModel.h"
@interface YCDispatchModel()
{
    dispatch_semaphore_t semaphoreLock;
}
@property(nonatomic,assign)int ticketCount;
@end
@implementation YCDispatchModel
#pragma mark - 异步执行 + 并行队列
-(void)asyncConcurrent{
    dispatch_queue_t queue=dispatch_queue_create("123", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"--start---");
    dispatch_async(queue, ^{
        NSLog(@"任务1---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2---%@",[NSThread currentThread]);
    });
    NSLog(@"---end---");
    /*---start---
     ---end---
     任务2---{number = 4, name = (null)}
     任务1---{number = 3, name = (null)}*/
    //异步执行意味着可以开启新的线程,任务可以先绕过不执行，回头再来执行
}

#pragma mark - 异步执行+串行队列
-(void)asyncSerial{
    dispatch_queue_t queue=dispatch_queue_create("123", DISPATCH_QUEUE_SERIAL);
    NSLog(@"--start---");
    dispatch_async(queue, ^{
        NSLog(@"任务1---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3---%@",[NSThread currentThread]);
    });
    NSLog(@"---end---");
    /* ---start---
     ---end---
     任务1---{number = 3, name = (null)}
     任务2---{number = 3, name = (null)}
     */
    //开了一个新的子线程,函数在执行时，先打印了start和end，再回头执行这三个任务,这三个任务是按顺序执行的，所以打印结果是“任务1-->任务2”
}
#pragma mark - 同步执行 + 并行队列
//所有任务都只能在主线程中执行,函数在执行时，必须按照代码的书写顺序一行一行地执行完才能继续
- (void)syncConcurrent{
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("123", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"---start---");
    //使用同步函数封装三个任务
    dispatch_sync(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    NSLog(@"---end---");
    /*2018-08-24 17:51:59.823154+0800 GCDSummary[16884:638778] ---start---
     2018-08-24 17:51:59.823454+0800 GCDSummary[16884:638778] 任务1---<NSThread: 0x600000072100>{number = 1, name = main}
     2018-08-24 17:51:59.823608+0800 GCDSummary[16884:638778] 任务2---<NSThread: 0x600000072100>{number = 1, name = main}
     2018-08-24 17:51:59.823735+0800 GCDSummary[16884:638778] 任务3---<NSThread: 0x600000072100>{number = 1, name = main}
     2018-08-24 17:51:59.823952+0800 GCDSummary[16884:638778] ---end---*/
}
#pragma mark - 同步执行 + 串行队列
/*不会执行*/
- (void)syncSerial{
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("标识符", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"---start---");
    //使用异步函数封装三个任务
    dispatch_sync(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    NSLog(@"---end---");
    
}
#pragma mark - 异步执行+主队列
-(void)asyncMain{
    dispatch_queue_t queue=dispatch_get_main_queue();
    NSLog(@"---start---");
    //使用异步函数封装三个任务
    dispatch_async(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    NSLog(@"---end---");
    /*2018-08-24 17:59:52.376349+0800 GCDSummary[17129:652808] ---start---
     2018-08-24 17:59:52.376592+0800 GCDSummary[17129:652808] ---end---
     2018-08-24 17:59:52.381657+0800 GCDSummary[17129:652808] 任务1---<NSThread: 0x604000067e40>{number = 1, name = main}
     2018-08-24 17:59:52.381876+0800 GCDSummary[17129:652808] 任务2---<NSThread: 0x604000067e40>{number = 1, name = main}
     2018-08-24 17:59:52.382128+0800 GCDSummary[17129:652808] 任务3---<NSThread: 0x604000067e40>{number = 1, name = main}*/
}
#pragma mark - 线程间的通信
//我们一般在主线程进行UI刷新，例如：点击，滚动，拖拽等事件，通常需要把耗时的操作放在其他线程，比如说图片下载，文件上传等耗时操作，当其他线程完成了耗时操作，需要回到主线程，需要回到主线程
-(void)communication{
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQueue=dispatch_get_main_queue();
    dispatch_async(queue, ^{
        for (int i=0; i<2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1当前线程--%@",[NSThread currentThread]);
        }
        dispatch_async(mainQueue, ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2当前线程--%@",[NSThread currentThread]);
        });
        
    });
    /*2018-08-29 16:04:07.627779+0800 GCDSummary[13284:352609] 1当前线程--<NSThread: 0x60400026e800>{number = 3, name = (null)}
     2018-08-29 16:04:09.632350+0800 GCDSummary[13284:352609] 1当前线程--<NSThread: 0x60400026e800>{number = 3, name = (null)}
     2018-08-29 16:04:11.633017+0800 GCDSummary[13284:352506] 2当前线程--<NSThread: 0x604000071500>{number = 1, name = main}*/
}
#pragma mark - 栅栏方法
/*
 有时候我们需要异步执行两组操作，而且第一组操作执行完之后，才能开始执行第二组操作。可以用dispatch_barrier_async方法将两组异步执行的操作组给分割起来，当然这里的操作组可以包含一个或多个任务。dispatch_barrier_async函数会等待前边追加到并发队列中的任务全部执行完毕之后，再讲指定的任务追加到该异步队列中。然后在dispatch_barrier_async函数追加的任务执行完毕之后，异步队列才恢复为一般动作，接着追加任务到该异步队列并开始执行
 */
-(void)barrier{
    dispatch_queue_t queue=dispatch_queue_create("123", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i=0; i<2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1当前线程--%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2当前线程--%@",[NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        for (int i=0; i<2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"barrier--%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i=0; i<2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3当前线程--%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4当前线程--%@",[NSThread currentThread]);
    });
    /*2018-08-29 16:36:09.817685+0800 GCDSummary[13868:379816] 1当前线程--<NSThread: 0x600000464740>{number = 4, name = (null)}
     2018-08-29 16:36:09.817685+0800 GCDSummary[13868:379819] 2当前线程--<NSThread: 0x600000277f00>{number = 3, name = (null)}
     2018-08-29 16:36:11.820429+0800 GCDSummary[13868:379816] 1当前线程--<NSThread: 0x600000464740>{number = 4, name = (null)}
     2018-08-29 16:36:13.821404+0800 GCDSummary[13868:379816] barrier--<NSThread: 0x600000464740>{number = 4, name = (null)}
     2018-08-29 16:36:15.826153+0800 GCDSummary[13868:379816] barrier--<NSThread: 0x600000464740>{number = 4, name = (null)}
     2018-08-29 16:36:17.830601+0800 GCDSummary[13868:379819] 4当前线程--<NSThread: 0x600000277f00>{number = 3, name = (null)}
     2018-08-29 16:36:17.830651+0800 GCDSummary[13868:379816] 3当前线程--<NSThread: 0x600000464740>{number = 4, name = (null)}
     2018-08-29 16:36:19.837125+0800 GCDSummary[13868:379816] 3当前线程--<NSThread: 0x600000464740>{number = 4, name = (null)}
     */
}
#pragma mark - 快速迭代方法 dispatch_apply
/*
 dispatch_apply按照指定的次数将指定的任务追加到指定的队列中，并等待全部队列全部队列执行结束
 主要用于并发队列进行异步执行，dispatch_apply 可以再多个线程中同时异步遍历多个数字
 无论在串行队列，还是异步队列，dispatch_apply都会等待全部任务执行完毕，这点就像是同步操作，也像是队列中的dispatch_group_waitdispatch_group_wait方法
 */
- (void)apply {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"apply---begin");
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
    });
    NSLog(@"apply---end");
    /*2018-08-29 17:02:00.097612+0800 GCDSummary[14376:402016] apply---begin
     2018-08-29 17:02:00.097960+0800 GCDSummary[14376:402016] 0---<NSThread: 0x600000068900>{number = 1, name = main}
     2018-08-29 17:02:00.098046+0800 GCDSummary[14376:402097] 1---<NSThread: 0x60400026c600>{number = 3, name = (null)}
     2018-08-29 17:02:00.098103+0800 GCDSummary[14376:402096] 2---<NSThread: 0x60400026c780>{number = 4, name = (null)}
     2018-08-29 17:02:00.098156+0800 GCDSummary[14376:402098] 3---<NSThread: 0x60400026c840>{number = 5, name = (null)}
     2018-08-29 17:02:00.098409+0800 GCDSummary[14376:402097] 4---<NSThread: 0x60400026c600>{number = 3, name = (null)}
     2018-08-29 17:02:00.098464+0800 GCDSummary[14376:402016] 5---<NSThread: 0x600000068900>{number = 1, name = main}
     2018-08-29 17:02:00.098721+0800 GCDSummary[14376:402016] apply---end
     */
}
#pragma mark - dispatch_group_notify
/*监听group中任务的完成状态，当所有的任务都执行完成后，追加任务到group中，并执行任务*/
-(void)groupNotify{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    dispatch_group_t group =  dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1当前线程---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];    // 模拟耗时操作
            NSLog(@"2当前线程---%@",[NSThread currentThread]); // 打印当前线程
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3当前线程---%@",[NSThread currentThread]);   // 打印当前线程
        }
        NSLog(@"group---end");
    });
    /*2018-08-29 17:27:31.978028+0800 GCDSummary[14834:423217] currentThread---<NSThread: 0x600000075f00>{number = 1, name = main}
     2018-08-29 17:27:31.978733+0800 GCDSummary[14834:423217] group---begin
     2018-08-29 17:27:33.984144+0800 GCDSummary[14834:423319] 2当前线程---<NSThread: 0x60400027be00>{number = 4, name = (null)}
     2018-08-29 17:27:33.984178+0800 GCDSummary[14834:423318] 1当前线程---<NSThread: 0x60000027d880>{number = 3, name = (null)}
     2018-08-29 17:27:35.988247+0800 GCDSummary[14834:423318] 1当前线程---<NSThread: 0x60000027d880>{number = 3, name = (null)}
     2018-08-29 17:27:35.988247+0800 GCDSummary[14834:423319] 2当前线程---<NSThread: 0x60400027be00>{number = 4, name = (null)}
     2018-08-29 17:27:37.989737+0800 GCDSummary[14834:423217] 3当前线程---<NSThread: 0x600000075f00>{number = 1, name = main}
     2018-08-29 17:27:39.990208+0800 GCDSummary[14834:423217] 3当前线程---<NSThread: 0x600000075f00>{number = 1, name = main}
     2018-08-29 17:27:39.990394+0800 GCDSummary[14834:423217] group---end
     */
}
#pragma mark -dispatch_semaphore_t 信号量相关
/*
 dispatch_semaphore_create 创建一个Semaphore并初始化信号的总量
 dispatch_semaphore_signal 发送一个信号，让信号量+1
 dispatch_semaphore_wait可以使总信号量减1，当信号量为0时就会一直等待（阻塞所在线程），否则就可以正常执行
 注意：信号量的使用前提是：想清楚哪个线程等待（阻塞），哪个线程继续执行
 主要用于
 1.保持线程同步，将异步执行任务转换为同步执行任务
 2.保证线程安全，为线程加锁
 */
-(void)semaphoreSync{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore=dispatch_semaphore_create(0);
    __block int number=0;
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1当前线程---%@",[NSThread currentThread]);
        number=100;
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %d",number);
    /*2018-08-30 10:28:10.515834+0800 GCDSummary[4874:69911] currentThread---<NSThread: 0x60000007a200>{number = 1, name = main}
     2018-08-30 10:28:10.516002+0800 GCDSummary[4874:69911] semaphore---begin
     2018-08-30 10:28:12.516908+0800 GCDSummary[4874:70171] 1当前线程---<NSThread: 0x60400046ba80>{number = 3, name = (null)}
     2018-08-30 10:28:12.517134+0800 GCDSummary[4874:69911] semaphore---end,number = 100*/
    
    
    
}
#pragma mark - 非线程安全
-(void)initTicketStatusNotSafe{
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"semaphore---begin");
    self.ticketCount=10;
    dispatch_queue_t queue1=dispatch_queue_create("北京", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2=dispatch_queue_create("上海", DISPATCH_QUEUE_SERIAL);
    __weak typeof(self) weakSelf=self;
    dispatch_async(queue1, ^{
        [weakSelf saleTicketNotSafe];
    });
    dispatch_async(queue2, ^{
        [weakSelf saleTicketNotSafe];
    });
    
    
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
    /*
     2018-08-30 11:05:08.598917+0800 GCDSummary[5344:98200] currentThread---<NSThread: 0x600000066600>{number = 1, name = main}
     2018-08-30 11:05:08.599098+0800 GCDSummary[5344:98200] semaphore---begin
     2018-08-30 11:05:08.599435+0800 GCDSummary[5344:98297] 剩余票数：9 窗口：<NSThread: 0x600000266840>{number = 3, name = (null)}
     2018-08-30 11:05:08.599483+0800 GCDSummary[5344:98306] 剩余票数：8 窗口：<NSThread: 0x6040002730c0>{number = 4, name = (null)}
     2018-08-30 11:05:08.599811+0800 GCDSummary[5344:98306] 剩余票数：6 窗口：<NSThread: 0x6040002730c0>{number = 4, name = (null)}
     2018-08-30 11:05:08.599811+0800 GCDSummary[5344:98297] 剩余票数：7 窗口：<NSThread: 0x600000266840>{number = 3, name = (null)}
     2018-08-30 11:05:08.599926+0800 GCDSummary[5344:98306] 剩余票数：5 窗口：<NSThread: 0x6040002730c0>{number = 4, name = (null)}
     2018-08-30 11:05:08.600045+0800 GCDSummary[5344:98297] 剩余票数：4 窗口：<NSThread: 0x600000266840>{number = 3, name = (null)}
     2018-08-30 11:05:08.600079+0800 GCDSummary[5344:98306] 剩余票数：3 窗口：<NSThread: 0x6040002730c0>{number = 4, name = (null)}
     2018-08-30 11:05:08.600176+0800 GCDSummary[5344:98297] 剩余票数：2 窗口：<NSThread: 0x600000266840>{number = 3, name = (null)}
     2018-08-30 11:05:08.600789+0800 GCDSummary[5344:98306] 剩余票数：1 窗口：<NSThread: 0x6040002730c0>{number = 4, name = (null)}
     2018-08-30 11:05:08.601420+0800 GCDSummary[5344:98306] 剩余票数：0 窗口：<NSThread: 0x6040002730c0>{number = 4, name = (null)}
     2018-08-30 11:05:08.601663+0800 GCDSummary[5344:98297] 所有火车票均已售完
     2018-08-30 11:05:08.602520+0800 GCDSummary[5344:98306] 所有火车票均已售完
     */
    
}
#pragma mark - 线程安全
-(void)initTicketStatusSave{
    NSLog(@"currentThread---%@",[NSThread currentThread]);
    NSLog(@"semaphore---begin");
    semaphoreLock=dispatch_semaphore_create(1);
    self.ticketCount=10;
    dispatch_queue_t queue1=dispatch_queue_create("北京", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2=dispatch_queue_create("上海", DISPATCH_QUEUE_SERIAL);
    __weak typeof(self) weakSelf=self;
    dispatch_async(queue1, ^{
        [weakSelf saleTicketSafe];
    });
    dispatch_async(queue2, ^{
        [weakSelf saleTicketSafe];
    });
    
    
}
//售卖火车票，非线程安全
//不考虑线程安全，不使用semaphore的情况下，得到的票数是乱序的
-(void)saleTicketSafe{
    while (1) {
        // 相当于加锁
        dispatch_semaphore_wait(semaphoreLock, DISPATCH_TIME_FOREVER);
        
        if (self.ticketCount>0) {
            self.ticketCount--;
            NSLog(@"剩余票数：%d 窗口：%@",self.ticketCount,[NSThread currentThread]);
        }
        else{
            NSLog(@"所有火车票均已售完");
            // 相当于解锁
            dispatch_semaphore_signal(semaphoreLock);
            break;
        }
        // 相当于解锁
        dispatch_semaphore_signal(semaphoreLock);
        
    }
    /*2018-08-30 11:14:42.164240+0800 GCDSummary[5638:107905] currentThread---<NSThread: 0x600000067700>{number = 1, name = main}
     2018-08-30 11:14:42.164443+0800 GCDSummary[5638:107905] semaphore---begin
     2018-08-30 11:14:42.164823+0800 GCDSummary[5638:107970] 剩余票数：9 窗口：<NSThread: 0x6000002789c0>{number = 3, name = (null)}
     2018-08-30 11:14:42.165450+0800 GCDSummary[5638:107969] 剩余票数：8 窗口：<NSThread: 0x600000279240>{number = 4, name = (null)}
     2018-08-30 11:14:42.166491+0800 GCDSummary[5638:107970] 剩余票数：7 窗口：<NSThread: 0x6000002789c0>{number = 3, name = (null)}
     2018-08-30 11:14:42.166708+0800 GCDSummary[5638:107969] 剩余票数：6 窗口：<NSThread: 0x600000279240>{number = 4, name = (null)}
     2018-08-30 11:14:42.167002+0800 GCDSummary[5638:107970] 剩余票数：5 窗口：<NSThread: 0x6000002789c0>{number = 3, name = (null)}
     2018-08-30 11:14:42.167184+0800 GCDSummary[5638:107969] 剩余票数：4 窗口：<NSThread: 0x600000279240>{number = 4, name = (null)}
     2018-08-30 11:14:42.168370+0800 GCDSummary[5638:107970] 剩余票数：3 窗口：<NSThread: 0x6000002789c0>{number = 3, name = (null)}
     2018-08-30 11:14:42.168908+0800 GCDSummary[5638:107969] 剩余票数：2 窗口：<NSThread: 0x600000279240>{number = 4, name = (null)}
     2018-08-30 11:14:42.171331+0800 GCDSummary[5638:107970] 剩余票数：1 窗口：<NSThread: 0x6000002789c0>{number = 3, name = (null)}
     2018-08-30 11:14:42.172748+0800 GCDSummary[5638:107969] 剩余票数：0 窗口：<NSThread: 0x600000279240>{number = 4, name = (null)}
     2018-08-30 11:14:42.172916+0800 GCDSummary[5638:107970] 所有火车票均已售完
     2018-08-30 11:14:42.173038+0800 GCDSummary[5638:107969] 所有火车票均已售完
     */
    
}
#pragma mark - 线程组
/*
 dispatch_group_enter 和 dispatch_group_leave 一般是成对出现的, 进入一次，就得离开一次。也就是说，当离开和进入的次数相同时，就代表任务组完成了。如果enter比leave多，那就是没完成，如果leave调用的次数错了， 会崩溃的；
 dispatch_group_wait ：在任务组完成时调用，或者任务组超时是调用（完成指的是enter和leave次数一样多）
 dispatch_group_notify：不管超不超时，只要任务组完成，会调用，不完成不会调用
 */
- (void)dispatch_group{
    
    dispatch_group_t group =dispatch_group_create();
    dispatch_queue_t globalQueue=dispatch_get_global_queue(0, 0);
    dispatch_group_enter(group);
    //    dispatch_group_enter(group);
    //模拟多线程耗时操作
    dispatch_group_async(group, globalQueue, ^{
        sleep(3);
        NSLog(@"%@---block1结束。。。",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    NSLog(@"%@---1结束。。。",[NSThread currentThread]);
    dispatch_group_enter(group);
    //模拟多线程耗时操作
    dispatch_group_async(group, globalQueue, ^{
        sleep(3);
        NSLog(@"%@---block2结束。。。",[NSThread currentThread]);
        dispatch_group_leave(group);
    });
    NSLog(@"%@---2结束。。。",[NSThread currentThread]);
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@---全部结束。。。",[NSThread currentThread]);
    });
    /*2018-08-30 13:44:30.137732+0800 GCDSummary[7135:183907] <NSThread: 0x600000074c80>{number = 1, name = main}---1结束。。。
     2018-08-30 13:44:30.137939+0800 GCDSummary[7135:183907] <NSThread: 0x600000074c80>{number = 1, name = main}---2结束。。。
     2018-08-30 13:44:33.141912+0800 GCDSummary[7135:183983] <NSThread: 0x60400026a340>{number = 4, name = (null)}---block2结束。。。
     2018-08-30 13:44:33.141916+0800 GCDSummary[7135:183976] <NSThread: 0x60000046dbc0>{number = 3, name = (null)}---block1结束。。。
     2018-08-30 13:44:33.142370+0800 GCDSummary[7135:183983] <NSThread: 0x60400026a340>{number = 4, name = (null)}---全部结束。。。*/
    
}
#pragma mark - 队列的挂起与恢复
/*dispatch_suspend并不会立即暂停正在运行的block，而是在当前block执行完成后，暂停后续的block执行。*/
-(void)suspendAndresume{
    dispatch_queue_t queue = dispatch_queue_create("123", DISPATCH_QUEUE_SERIAL);
    //提交第一个block，延时5秒打印。
    dispatch_async(queue, ^{
        sleep(5);
        NSLog(@"block1After 5 seconds...");
    });
    //提交第二个block，也是延时5秒打印
    dispatch_async(queue, ^{
        sleep(5);
        NSLog(@"block2After 5 seconds again...");
    });
    //延时一秒
    NSLog(@"sleep 1 second...");
    sleep(1);
    //挂起队列
    NSLog(@"suspend...");
    dispatch_suspend(queue);
    //延时10秒
    NSLog(@"sleep 10 second...");
    sleep(10);
    //恢复队列
    NSLog(@"resume...");
    dispatch_resume(queue);
    /*2018-08-31 16:01:04.719099+0800 GCDSummary[6553:240722] sleep 1 second...
     2018-08-31 16:01:05.719543+0800 GCDSummary[6553:240722] suspend...
     2018-08-31 16:01:05.719831+0800 GCDSummary[6553:240722] sleep 10 second...
     2018-08-31 16:01:09.724062+0800 GCDSummary[6553:240822] block1After 5 seconds...
     2018-08-31 16:01:15.720839+0800 GCDSummary[6553:240722] resume...
     2018-08-31 16:01:20.725547+0800 GCDSummary[6553:240820] block2After 5 seconds again...
     */
    
}
#pragma mark - dispatch_source实例
/*
 创建一个source，source的type为ADD的方式，然后将事件触发后要执行的句柄添加到main队列中，在souce创建后默认是挂起的，需要用dispatch——resume函数来恢复监听
 */
-(void)dispatch_source{
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_global_queue(0, 0));
       NSLog(@"0-----");
    dispatch_source_set_event_handler(source, ^{

        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"1-----");
            //更新UI
        });
    });
    dispatch_resume(source);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //网络请求
        dispatch_source_merge_data(source, 1); //通知队列
        NSLog(@"2-----");

    });
    //创建source，以DISPATCH_SOURCE_TYPE_DATA_ADD的方式进行累加，而DISPATCH_SOURCE_TYPE_DATA_OR是对结果进行二进制或运算
//    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
//
//    //事件触发后执行的句柄
//    dispatch_source_set_event_handler(source,^{
//
//        NSLog(@"监听函数：%lu",dispatch_source_get_data(source));
//
//    });
//    //开启source
//    dispatch_resume(source);
//    dispatch_queue_t myqueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    dispatch_async(myqueue, ^ {
//
//        for(int i = 1; i <= 4; i ++){
//            NSLog(@"~~~~~~~~~~~~~~%d", i);
//            //触发事件，向source发送事件，这里i不能为0，否则触发不了事件
//            dispatch_source_merge_data(source,i);
//            //当Interval的事件越长，则每次的句柄都会触发
//            //[NSThread sleepForTimeInterval:0.0001];
//        }
//    });
    /*
     2018-11-09 09:18:09.399743+0800 YCSummary[1757:23905] ~~~~~~~~~~~~~~1
     2018-11-09 09:18:09.399938+0800 YCSummary[1757:23905] ~~~~~~~~~~~~~~2
     2018-11-09 09:18:09.400077+0800 YCSummary[1757:23905] ~~~~~~~~~~~~~~3
     2018-11-09 09:18:09.400191+0800 YCSummary[1757:23905] ~~~~~~~~~~~~~~4
     2018-11-09 09:18:09.400930+0800 YCSummary[1757:23852] 监听函数：10
*/

}
#pragma mark - 倒计时
/*
 source 分派源
 start 数控制计时器第一次触发的时刻。参数类型是 dispatch_time_t，这是一个opaque类型，我们不能直接操作它。我们得需要 dispatch_time 和 dispatch_walltime 函数来创建它们。另外，常量 DISPATCH_TIME_NOW 和 DISPATCH_TIME_FOREVER 通常很有用。
 interval 间隔时间
 leeway 计时器触发的精准程度
 https://www.jianshu.com/p/880c2f9301b6
*/
-(void)dispatch_source_set_timer{
    //倒计时时间
    __block int timeout = 3;
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建timer
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置1s触发一次，0s的误差
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    //触发的事件
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            //取消dispatch源
            dispatch_source_cancel(_timer);
            NSLog(@"计时器销毁了");
        }
        else{
            timeout--;
            dispatch_async(dispatch_get_main_queue(), ^{
                //更新主界面的操作
                NSLog(@"倒计时~~~~~~~~~~~~~~~~%d", timeout);
            });
        }
    });
    //开始执行dispatch源
    dispatch_resume(_timer);
}
@end
