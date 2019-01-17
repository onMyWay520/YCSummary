//
//  YCBlockVC.m
//  YCSummary
//
//  Created by admin on 2019/1/17.
//  Copyright © 2019 YC科技有限公司. All rights reserved.
//

#import "YCBlockVC.h"
typedef NSString * (^MyBlock)(NSString *);
@interface YCBlockVC ()
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic, copy) MyBlock myblock;
@end
@implementation YCBlockVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"block演练";
    self.mainView.rowHeight=HEIGHT(40);
    self.mainView.frame=CGRectMake(0,64, SCREENT_WIDTH, SCREENT_HEIGHT);
}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray=@[@"声明Block类型变量并赋值：",@"使用typedef简化Block",@"Block作为C函数参数",@"Block作为OC函数参数",@"Block内访问局部变量",@"Block内访问__block修饰的局部变量"];
    }
    return _dataArray;
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
    return HEIGHT(5);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            [self haveParameterAndreturnValue];
            break;
        case 1:
            [self typedefBlcok];
            break;
        case 2:
            //以Block作为函数参数,把Block像对象一样传递
            useBlockForC(addBlock);
            break;
        case 3:
            [self useBlockForOC:addBlock];
            break;
        case 4:
            [self visitlocalVariableblock];
            break;
        case 5:
            [self __blockvisitlocalVariableblock];
            break;
        default:
            break;
    }
}
//含有参数与返回值的block
-(void)haveParameterAndreturnValue{
    NSString *(^block)(NSString *) = ^ NSString * (NSString *str) {
        DebugLog(@"==%@",str);//==helo
        return str;
    };
    block(@"helo");//block调用
}
//typedef声明的block
-(void)typedefBlcok{
    self.myblock=^NSString *(NSString *str){
        DebugLog(@"==%@",str);// ==nihao
        return str;
    };
    self.myblock(@"nihao");
}
// 1.定义一个形参为Block的C函数
void useBlockForC(int(^aBlock)(int, int)){
    NSLog(@"result = %d", aBlock(300,200));//result = 500
}
// 2.声明并赋值定义一个Block变量
int(^addBlock)(int, int) = ^(int x, int y){
    return x+y;
};
// 定义一个形参为Block的OC函数
- (void)useBlockForOC:(int(^)(int, int))aBlock{
    NSLog(@"result = %d", aBlock(300,200));
}
#pragma mark -访问局部变量的block
-(void)visitlocalVariableblock{
    int global=100;
    void(^localBlcok)()=^{
      //  global ++; // 这句报错在Block中不可以直接修改局部变量
        DebugLog(@"==%d",global);//==100
    };
    global = 101;
    localBlcok();
    /*在声明Block之后、调用Block之前对局部变量进行修改,在调用Block时局部变量值是修改之前的旧值*/
}
#pragma mark -访问局部变量的block
-(void)__blockvisitlocalVariableblock{
   __block int global=100;
    void(^localBlcok)()=^{
        global ++; //
        DebugLog(@"==%d",global);//==102
    };
    global = 101;
    localBlcok();
    /*在局部变量前使用下划线下划线block修饰,在Block中可以直接修改局部变量*/
}
@end
