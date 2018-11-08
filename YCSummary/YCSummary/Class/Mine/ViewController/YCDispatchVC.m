//
//  YCDispatchVC.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/8.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCDispatchVC.h"
#import "YCDispatchModel.h"
@interface YCDispatchVC ()

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation YCDispatchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Dispatch函数演练";
    self.mainView.rowHeight=HEIGHT(40);
    self.mainView.frame=CGRectMake(0, 64, SCREENT_WIDTH, SCREENT_HEIGHT);
}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray=@[@"异步执行 + 并行队列",@"异步执行+串行队列",@"同步执行 + 并行队列",@"同步执行 + 串行队列",@"异步执行+主队列",@"线程间的通信",@"栅栏方法",@"快速迭代方法 dispatch_apply",@"dispatch_group_notify",@"dispatch_semaphore_t 信号量相关",@"非线程安全",@"线程安全",@"线程组",@"队列的挂起与恢复"];
    }
    return _dataArray;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    cell.textLabel.text=self.dataArray[indexPath.row];
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
    YCDispatchModel *model=[YCDispatchModel new];
    switch (indexPath.row) {
        case 0:
            [model asyncConcurrent];
            break;
        case 1:
            [model asyncSerial];
            break;
        case 2:
            [model syncConcurrent];
            break;
        case 3:
            [model syncSerial];
            break;
        case 4:
            [model asyncMain];
            break;
        case 5:
            [model communication];
            break;
        case 6:
            [model barrier];
            break;
        case 7:
            [model apply];
            break;
        case 8:
            [model groupNotify];
            break;
        case 9:
            [model semaphoreSync];
            break;
        case 10:
            [model initTicketStatusNotSave];
            break;
        case 11:
            [model initTicketStatusSave];
            break;
        case 12:
            [model dispatch_group];
            break;
        case 13:
            [model suspendAndresume];
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
