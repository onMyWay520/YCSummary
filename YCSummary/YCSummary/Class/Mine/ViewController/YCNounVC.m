//
//  YCNounVC.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/8.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCNounVC.h"
#import "YCArraySort.h"
#import "YCStackForModel.h"
#import "YCCharReverse.h"
#import "YCBinarySortTreeModel.h"
@interface YCNounVC ()
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSMutableArray *orginArray;///< <#注释#>
@property (nonatomic,strong) YCBinarySortTreeModel *treeModel;///<
@property (nonatomic,strong) NSMutableArray *binaryTreeSortArray;///< <#注释#>


@end

@implementation YCNounVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"算法演练";
    self.mainView.rowHeight=HEIGHT(40);
    self.mainView.frame=CGRectMake(0,64, SCREENT_WIDTH, SCREENT_HEIGHT);
    [self showStack];
    // 二叉排序树
    NSArray *binaryTree = @[@7,@2,@1,@4,@6,@8,@9,@34,@21,@23,@12];
    self.treeModel = [YCBinarySortTreeModel binarySortTreeCreate:binaryTree];
    /*
      7
     / \
    2   8
   / \   \
  1   4   9
     /     \
    6      34
           /
          21
          / \
         12 23
     */

}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray=@[@{@"排序算法":@[@"冒泡排序",@"选择排序",@"插入排序",@"快速排序",@"归并排序",@"堆排序",@"希尔排序"]},@{@"二叉树":@[@"先序遍历",@"中序遍历",@"后序遍历"]},@{@"字符串":@[@"字符串反转"]}];
    }
    return _dataArray;
}
-(NSMutableArray *)orginArray{
    if (!_orginArray) {
        _orginArray=[[NSMutableArray alloc] initWithObjects:@7,@2,@1,@4,@6,@8,@9,@34,@21,@23,@12,nil];
    }
    return _orginArray;
}
-(NSMutableArray *)binaryTreeSortArray{
    if (!_binaryTreeSortArray) {
        _binaryTreeSortArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _binaryTreeSortArray;
}
-(void)showStack{
    YCStackForModel *stack=[[YCStackForModel alloc]init];
    NSString *str=@"hello";
    [stack push:str];
    DebugLog(@"=%@",[[stack popTopElement]class]);
    [stack push:str];
    NSString *str2=@"world";
    [stack push:str2];
    [stack traversalElementPopStack:^(id  _Nonnull objc) {
        DebugLog(@"遍历元素 %@",objc);
    }];
    DebugLog(@"长度是 %ld",(long)stack.stackLength);
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
    if (indexPath.section==1) {
        switch (indexPath.row) {
            case 0:
                [self preOrderTraverseTree];
                break;
            case 1:
                [self inOrderTraverseTree];

                break;
            case 2:
                [self postOrderTraverseTree];

                break;
            default:
                break;
        }
    }
    if (indexPath.section==2) {
        char ch[100];
        NSString *string = @"hello";
        NSInteger length = string.length;
        memcpy(ch, [string cStringUsingEncoding:NSASCIIStringEncoding], 2 * length);
        char_reverse(ch);
        NSLog(@"CharReverse result:%s",ch);
    }
    DebugLog(@"array=%@",array);
   DebugLog(@"self.binaryTreeSortArray=%@",self.binaryTreeSortArray);

}
#pragma mark - 先序遍历
-(void)preOrderTraverseTree{
    [self.binaryTreeSortArray removeAllObjects];
    [YCBinarySortTreeModel preOrderTraverseTree:self.treeModel handler:^(YCBinarySortTreeModel *node) {
        [self.binaryTreeSortArray addObject:@(node.value)];
    }];
    /*
     7,
     2,
     1,
     4,
     6,
     8,
     9,
     34,
     21,
     12,
     23*/
}
#pragma mark - 中序遍历
-(void)inOrderTraverseTree{
    [self.binaryTreeSortArray removeAllObjects];
    [YCBinarySortTreeModel inOrderTraverseTree:self.treeModel handler:^(YCBinarySortTreeModel *node) {
        [self.binaryTreeSortArray addObject:@(node.value)];
    }];
    /*
     1,
     2,
     4,
     6,
     7,
     8,
     9,
     12,
     21,
     23,
     34*/

}
#pragma mark - 后序遍历
-(void)postOrderTraverseTree{
    [self.binaryTreeSortArray removeAllObjects];
    [YCBinarySortTreeModel postOrderTraverseTree:self.treeModel handler:^(YCBinarySortTreeModel *node) {
        [self.binaryTreeSortArray addObject:@(node.value)];
    }];
    /*
     1,
     6,
     4,
     2,
     12,
     23,
     21,
     34,
     9,
     8,
     7
     */
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
