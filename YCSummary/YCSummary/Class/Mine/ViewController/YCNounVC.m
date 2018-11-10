//
//  YCNounVC.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/8.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCNounVC.h"
#import "YCArraySort.h"
@interface YCNounVC ()
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSMutableArray *orginArray;///< <#注释#>
@end

@implementation YCNounVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"算法演练";
    self.mainView.rowHeight=HEIGHT(40);
    self.mainView.frame=CGRectMake(0,64, SCREENT_WIDTH, SCREENT_HEIGHT);
}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray=@[@{@"排序算法":@[@"冒泡排序",@"选择排序",@"插入排序",@"快速排序",@"归并排序",@"堆排序",@"希尔排序"]},@{@"二叉树":@[@"先序遍历",@"中序遍历",@"后序遍历"]}];
    }
    return _dataArray;
}
-(NSMutableArray *)orginArray{
    if (!_orginArray) {
        _orginArray=[[NSMutableArray alloc] initWithObjects:@7,@2,@1,@4,@6,@8,@9,@34,@21,@23,@12,nil];
    }
    return _orginArray;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    NSDictionary *dataDic=self.dataArray[indexPath.section];
    [dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSArray*   obj, BOOL * _Nonnull stop) {
        cell.textLabel.text=dataDic[key][indexPath.row];
    }];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dataDic=self.dataArray[section];
    NSArray *values=dataDic.allValues;
    return [values[0]count];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headVi=[[UIView alloc]init];
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH(10), HEIGHT(5), WIDTH(100), HEIGHT(20))];
    NSDictionary *dataDic=self.dataArray[section];
    [dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        titleLabel.text=key;
    }];
    [headVi addSubview:titleLabel];
    return headVi;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEIGHT(30);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *array;
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                array = [YCArraySort bubbleSort:self.orginArray];
                break;
            case 1:
                array = [YCArraySort selectSort:self.orginArray];
                break;
            case 2:
                array = [YCArraySort insertSort:self.orginArray];
                break;
            case 3:
                array = [YCArraySort quickSort:self.orginArray];
            case 4:
                array = [YCArraySort mergeSort:self.orginArray];
                break;
            case 5:
                array = [YCArraySort heapSort:self.orginArray];
                break;
            case 6:
                array = [YCArraySort shellArray:self.orginArray];
                break;
            default:
                break;
        }
    }
    DebugLog(@"array=%@",array);
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