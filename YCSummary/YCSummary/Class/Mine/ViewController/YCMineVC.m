//
//  YCMineVC.m
//  YCSummary
//
//  Created by wuyongchao on 2018/10/29.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCMineVC.h"
#import "YCNounVC.h"
#import "YCDispatchVC.h"
#import "YCCoreDataVC.h"
#import "YCRunTimeVC.h"
#import "YCRunloopVC.h"
#import "YCWaterflowController.h"
#import "YCLikeOrUnlikeVC.h"
@interface YCMineVC ()
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation YCMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的";
    self.mainView.rowHeight=HEIGHT(40);
    self.mainView.frame=CGRectMake(0, 64, SCREENT_WIDTH, SCREENT_HEIGHT);
}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray=@[@"算法",@"Dispatch函数",@"coredata演练",@"runtime演练",@"runloop演练",@"瀑布流",@"仿探探布局"];
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
    if (indexPath.row==0) {
        [self.navigationController pushViewController:[YCNounVC new] animated:false];
    }
    else  if (indexPath.row==1) {
        [self.navigationController pushViewController:[YCNounVC new] animated:false];
    }
    else  if (indexPath.row==2) {
        [self.navigationController pushViewController:[YCCoreDataVC new] animated:false];
    }
    else  if (indexPath.row==2) {
        [self.navigationController pushViewController:[YCRunTimeVC new] animated:false];
    }
    else  if (indexPath.row==3) {
      [self.navigationController pushViewController:[YCRunloopVC new] animated:false];
        
    }
    else if (indexPath.row==4){
        [self.navigationController pushViewController:[YCWaterflowController new] animated:false];
    }
    else{
        [self.navigationController pushViewController:[YCLikeOrUnlikeVC new] animated:false];
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
