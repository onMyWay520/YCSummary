//
//  FCBaseTableVC.m
//  YCSummary
//
//  Created by wuyongchao on 2018/10/30.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "FCBaseTableVC.h"

@interface FCBaseTableVC ()

@end

@implementation FCBaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainView];
}
-(UITableView *)mainView{
    if (!_mainView){
        
        _mainView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREENT_WIDTH ,SCREENT_HEIGHT-SafeAreaTopHeight) style:UITableViewStyleGrouped];
        _mainView.dataSource=self;
        _mainView.delegate=self;
        _mainView.estimatedRowHeight = 0;
        _mainView.estimatedSectionHeaderHeight = 0;
        _mainView.estimatedSectionFooterHeight = 0;
        _mainView.showsVerticalScrollIndicator=NO;
        _mainView.separatorStyle=UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _mainView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 刷新某一区
-(void)reloadTableWithSection:(NSInteger)index{
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:index];
    [self.mainView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}
-(void)reloadTableWithSection:(NSInteger)section  Androw:(NSInteger)row{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self.mainView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
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
