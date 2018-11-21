//
//  YCRunloopVC.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/21.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCRunloopVC.h"
#import "YCThread.h"
@interface YCRunloopVC ()
@property (nonatomic,strong) NSArray *dataArray;
@property (strong, nonatomic)YCThread*subThread;  /**< 子线程 */

@end

@implementation YCRunloopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"runloop演练";
    self.mainView.rowHeight=HEIGHT(40);
    self.mainView.frame=CGRectMake(0,64, SCREENT_WIDTH, SCREENT_HEIGHT);
    [self showRunloop];
}
-(void)showRunloop{
    //打印与主线程关联的RunLoop，可以查看MainRunLoop中的modes，还可以看到commonItems和各个mode中的items
    CFRunLoopRef runLoopRef = CFRunLoopGetMain();
    CFArrayRef modes = CFRunLoopCopyAllModes(runLoopRef);
    NSLog(@"MainRunLoop中的modes:%@",modes);
    NSLog(@"MainRunLoop对象：%@",runLoopRef);
    // 1.测试线程的销毁
    [self threadTest];
    /*2018-11-21 16:15:50.538733+0800 YCSummary[23598:303023] MainRunLoop中的modes:(
     UITrackingRunLoopMode,
     GSEventReceiveRunLoopMode,
     kCFRunLoopDefaultMode,
     kCFRunLoopCommonModes
     )
     2018-11-21 16:15:50.549466+0800 YCSummary[23598:303023] MainRunLoop对象：<CFRunLoop 0x6000007bc900 [0x10dcf7b48]>{wakeup port = 0x8f07, stopped = false, ignoreWakeUps = false,
     current mode = kCFRunLoopDefaultMode,
     common modes = <CFBasicHash 0x6000035f0270 [0x10dcf7b48]>{type = mutable set, count = 2,
     entries =>
     0 : <CFString 0x113eb8b58 [0x10dcf7b48]>{contents = "UITrackingRunLoopMode"}
     2 : <CFString 0x10dd0d208 [0x10dcf7b48]>{contents = "kCFRunLoopDefaultMode"}
     }
     ,
     common mode items = <CFBasicHash 0x6000035f0660 [0x10dcf7b48]>{type = mutable set, count = 15,
     entries =>
     0 : <CFRunLoopSource 0x600000eb8180 [0x10dcf7b48]>{signalled = No, valid = Yes, order = -1, context = <CFRunLoopSource context>{version = 0, info = 0x0, callout = PurpleEventSignalCallback (0x1164f3188)}}
     1 : <CFRunLoopObserver 0x600000ab8be0 [0x10dcf7b48]>{valid = Yes, activities = 0x1, repeats = Yes, order = -2147483647, callout = _wrapRunLoopWithAutoreleasePoolHandler (0x112fc8aa9), context = <CFArray 0x6000035f12c0 [0x10dcf7b48]>{type = mutable-small, count = 1, values = (
     0 : <0x7fe
     2018-11-21 16:15:50.551632+0800 YCSummary[23598:303104] 启动RunLoop前--(null)
     2018-11-21 16:15:50.552862+0800 YCSummary[23598:303104] currentRunLoop:<CFRunLoop 0x6000007a8b00 [0x10dcf7b48]>{wakeup port = 0x1da03, stopped = false, ignoreWakeUps = true,
     current mode = (none),
     common modes = <CFBasicHash 0x600003531a70 [0x10dcf7b48]>{type = mutable set, count = 1,
     entries =>
     2 : <CFString 0x10dd0d208 [0x10dcf7b48]>{contents = "kCFRunLoopDefaultMode"}
     }
     ,
     common mode items = (null),
     modes = <CFBasicHash 0x600003530fc0 [0x10dcf7b48]>{type = mutable set, count = 1,
     entries =>
     2 : <CFRunLoopMode 0x600000092a40 [0x10dcf7b48]>{name = kCFRunLoopDefaultMode, port set = 0x1d903, queue = 0x600001592500, source = 0x600001590100 (not fired), timer port = 0x1d803,
     sources0 = <CFBasicHash 0x60000353f480 [0x10dcf7b48]>{type = mutable set, count = 0,
     entries =>
     }
     ,
     sources1 = <CFBasicHash 0x60000353f750 [0x10dcf7b48]>{type = mutable set, count = 1,
     entries =>
     0 : <CFRunLoopSource 0x600000ebba80 [0x10dcf7b48]>{signalled = No, valid = Yes, order = 200, context = <CFMachPort 0x600000cbdfa0 [0x10dcf7b48]>{valid = Yes, port = 1d703, source = 0x600000ebba80, callout = __NSFireMachPort (0x10c07c57f), context = <CFMachPort context 0x600003530630>}}
     }
     ,
     observers = (null),
     timers = (null),
     currently 564480951 (22016215945453) / soft deadline in: 1.84467221e+10 sec (@ -1) / hard deadline in: 1.84467221e+10 sec (@ -1)
     },
     
     }
     }*/
}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray=@[@"runloop用法"];
    }
    return _dataArray;
}

- (void)threadTest{
    YCThread *subThread = [[YCThread alloc] initWithTarget:self selector:@selector(subThreadEntryPoint) object:nil];
    [subThread setName:@"YCThread"];
    [subThread start];
    self.subThread = subThread;
}
- (void)subThreadEntryPoint{
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        //如果注释了下面这一行，子线程中的任务并不能正常执行
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        NSLog(@"启动RunLoop前--%@",runLoop.currentMode);
        NSLog(@"currentRunLoop:%@",[NSRunLoop currentRunLoop]);

        [runLoop run];
    }
}
/**
 子线程任务
 */
- (void)subThreadOpetion{
    NSLog(@"启动RunLoop后--%@",[NSRunLoop currentRunLoop].currentMode);//启动RunLoop后--kCFRunLoopDefaultMode
    NSLog(@"%@----子线程任务开始",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:3.0];
    NSLog(@"%@----子线程任务结束",[NSThread currentThread]);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    cell.textLabel.text=self.dataArray[indexPath.section];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEIGHT(30);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSelector:@selector(subThreadOpetion) onThread:self.subThread withObject:nil waitUntilDone:NO];

//    YCCoreDataModel *model=[[YCCoreDataModel alloc]init];
//    switch (indexPath.section) {
//        case 0:
//            [model addschool];
//            break;
//        case 1:
//            [model deleteSchool];
//            break;
//        case 2:
//            [model updateSchool];
//            break;
//        case 3:
//            [model searchSchool];
//            break;
//        default:
//            break;
//    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
