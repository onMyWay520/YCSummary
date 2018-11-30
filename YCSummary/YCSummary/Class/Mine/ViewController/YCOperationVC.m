//
//  YCOperationVC.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/29.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCOperationVC.h"
#import "YCOperationModel.h"
@interface YCOperationVC ()
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation YCOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"NSOperation函数演练";
    self.mainView.rowHeight=HEIGHT(40);
    self.mainView.frame=CGRectMake(0, SafeAreaTopHeight, SCREENT_WIDTH, SCREENT_HEIGHT-SafeAreaTopHeight);
}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray=@[
        @"在当前线程使用子类 NSInvocationOperation",
        @"在其他线程使用子类 NSInvocationOperation",
        @"当前线程使用子类 NSBlockOperation",
        @"子类 NSBlockOperation调用方法 AddExecutionBlock",
        @"使用自定义继承自 NSOperation 的子类",
        @"addOperation将操作加入到操作队列中",
        @"addOperationWithBlock: 将操作加入到操作队列中",
        @"MaxConcurrentOperationCount最大并发操作数",
        @"设置优先级",
        @"添加依赖",
        @"线程间通信",
        @"完成操作",
        @"取消线程",
        @"暂停线程",
        @"模拟售票<非线程安全>",
        @"模拟售票<线程安全>"];
    }
    return _dataArray;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%ld %@",(long)indexPath.row+1,self.dataArray[indexPath.row]];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArray.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YCOperationModel *model=[YCOperationModel new];
    switch (indexPath.row) {
        case 0:
            [model useInvocationOperation];
            break;
        case 1:
            [model otherThreaduseInvocationOperation];
            break;
        case 2:
            [model useBlockOperation];
            break;
        case 3:
            [model useBlockOperationaddExecutionBlock];
            break;
        case 4:
            [model useCustomOperation];
            break;
        case 5:
            [model addOperationToQueue];
            break;
        case 6:
            [model addOperationWithBlockToQueue];
            break;
        case 7:
            [model setMaxConcurrentOperationCount];
            break;
        case 8:
            [model setQueuePriority];
            break;
        case 9:
            [model addDependency];
            break;
        case 10:
            [model threadCommunication];
            break;
        case 11:
            [model completionBlock];
            break;
        case 12:
            [model cancelOperation];
            break;
        case 13:
            [model suspendOperation];
            break;
        case 14:
            [model ticketStatusNotSafe];
            break;
        case 15:
            [model ticketStatusSafe];
            break;
        default:
            break;
    }
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
