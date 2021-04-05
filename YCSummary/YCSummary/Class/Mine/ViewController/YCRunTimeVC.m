//
//  YCRunTimeVC.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/21.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCRunTimeVC.h"
#import "YCDispatchModel.h"
#import "YCRunTimeModel.h"
#import "YCPeople.h"
#import "NSObject+YCKVO.h"
@interface YCRunTimeVC ()
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) YCPeople *people;///< <#注释#>
@end

@implementation YCRunTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"runtime演练";
    self.mainView.rowHeight=HEIGHT(40);
    self.mainView.frame=CGRectMake(0, YCNavBarAndStatusHeight(), SCREENT_WIDTH, SCREENT_HEIGHT - YCNavBarAndStatusHeight());
    [self allocKVO];
    [self yc_addNotificationForName:@"YCNotification" block:^(NSNotification * _Nonnull notification) {
        NSLog(@"接收到通知===%@",notification.userInfo);
    }];
//    YCRunTimeModel *model=[[YCRunTimeModel alloc]init];
//    YCRunTimeModel *model2=[[YCRunTimeModel alloc]init];

}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray=@[
        @"消息转发机制",
        @"字典转模型",
        @"归档解档",
        @"数组异常处理",
        @"增加属性",
        @"交换方法演示KVO",
        @"交换方法演示通知",
        @"获取所有方法，类，属性，协议等"];
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
    YCRunTimeModel *model=[YCRunTimeModel new];
    NSArray * array = [[NSArray alloc] init];
    switch (indexPath.row) {
        case 0:
            [model messageLearn];
            break;
        case 1:
            [model modelWithDict];
            break;
        case 2:
            [model encodeAndDecode];
            break;
        case 3:
            [model ArrayAbnormal:array];
            break;
        case 4:
            [model addProperty];
            break;
        case 5:
            [self showKVO];
            break;
        case 6:
            [model showNotification];
            break;
        case 7:
            [model getAllMethod];
            break;
           
        default:
            break;
    }
}
-(void)allocKVO{
    self.people=[YCPeople new];
    self.people.name=@"xiaowang";
    [self.people yc_addObserverBlockForKeyPath:@"name" block:^(id obj, id oldVale, id newVale) {
        NSLog(@"kvo 修改name为%@",newVale);
    }];
}
-(void)showKVO{
    static BOOL flag=NO;
    if (!flag) {
        self.people.name=@"yongchao";
        flag=YES;
    }
    else{
        self.people=nil;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
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
