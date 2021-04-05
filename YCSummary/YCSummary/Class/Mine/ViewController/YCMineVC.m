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
#import "YCOperationVC.h"
#import "YCProxy.h"
#import "YCKVOVC.h"
#import "YCBlockVC.h"
#import "YCReverseList.h"
#import "YCBezierPathVC.h"
#import "YCDrawRectVC.h"
@interface YCMineVC ()
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation YCMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的";
    self.mainView.rowHeight=HEIGHT(40);
    self.mainView.frame=CGRectMake(0,YCNavBarAndStatusHeight(), SCREENT_WIDTH, SCREENT_HEIGHT);
//    YCDog *dog=[YCProxy proxyWithObject:[YCDog alloc]];
//    [dog barking:4];
    YCDog *dog=[[YCDog alloc]init];
    YCProxy *proxy=[YCProxy alloc];
    [proxy transformObjc:dog];
    [proxy performSelector:@selector(shut)];
    NSString *ipString=@"1.234.3.230";
    bool isValid=[NSString isValidIP:ipString];
    DebugLog(@"isValid==%d",isValid);

}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray=@[@"算法",@"Dispatch函数",@"NSOperation演练",@"coredata演练",@"runtime演练",@"runloop演练",@"瀑布流",@"仿探探布局",@"KVO演练",@"block演练",@"BezierPath",@"drawRect"];
    }
    return _dataArray;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld - %@",indexPath.row + 1 , self.dataArray[indexPath.row]];
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
    
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:
            vc = [YCNounVC new];
            break;
        case 1:
            vc = [YCDispatchVC new];
            break;
        case 2:
            vc = [YCOperationVC new];
            break;
        case 3:
            vc = [YCNounVC new];
            break;
        case 4:
            vc = [YCRunTimeVC new];
            break;
        case 5:
            vc = [YCRunloopVC new];
            break;
        case 6:
            vc = [YCWaterflowController new];
            break;
        case 7:
            vc = [YCLikeOrUnlikeVC new];
            break;
        case 8:
            vc = [YCKVOVC new];
            break;
        case 9:
        {
            YCBlockVC *vc = [YCBlockVC new];
            vc.myblock2 = ^(NSString * str) {
                
                DebugLog(@"str==%@",str);
            };
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 10:
            vc = [YCBezierPathVC new];
            break;
        case 11:
            vc = [YCDrawRectVC new];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:NO];
    
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
