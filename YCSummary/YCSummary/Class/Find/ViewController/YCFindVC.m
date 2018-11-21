//
//  YCFindVC.m
//  YCSummary
//
//  Created by wuyongchao on 2018/10/29.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCFindVC.h"
#import "YCHomeVC.h"
@interface YCFindVC ()

@end

@implementation YCFindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发现";
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self networkRequest];

}
- (void)networkRequest{
    //模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
     //请求成功
    NSDictionary *responseDict = @{@"title_info":@"新游戏上架啦",
          @"title_icon":@"game_1",
           @"game_info":@"一起来玩斗地主呀！",
            @"game_icon":@"doudizhu"};
        //将要刷新cell的indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:3];
        
        //获取cell对应的viewModel
        SJStaticTableviewCellViewModel *viewModel = [self.dataSource tableView:self.tableView cellViewModelAtIndexPath:indexPath];
        
        if (viewModel) {
            //更新viewModel
            viewModel.leftTitle = responseDict[@"title_info"];
            viewModel.leftImage = [UIImage imageNamed:responseDict[@"title_icon"]];
            viewModel.indicatorLeftImage = [UIImage imageNamed:responseDict[@"game_icon"]];
            viewModel.indicatorLeftTitle = responseDict[@"game_info"];
            
            //刷新tableview
            [self.tableView reloadData];
        }
    });
}

- (void)createDataSource{
    self.dataSource = [[SJStaticTableViewDataSource alloc] initWithViewModelsArray:[Factory momentsPageData] configureBlock:^(SJStaticTableViewCell *cell, SJStaticTableviewCellViewModel *viewModel) {
        
        switch (viewModel.staticCellType){
        case SJStaticCellTypeSystemAccessoryDisclosureIndicator:{
        [cell configureAccessoryDisclosureIndicatorCellWithViewModel:viewModel];
            }
            break;
            default:
                break;
        }
    }];

}
- (void)didSelectViewModel:(SJStaticTableviewCellViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath{
    
    switch (viewModel.identifier){
            
        case 0:
        {
//            MHMomentViewController *vc=[[MHMomentViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 8:
        {
            NSLog(@"清理缓存");
        }
            break;
            
        case 9:
        {
            NSLog(@"跳转到定制性cell展示页面 - 分组");
//            SJCustomCellsViewController *vc = [[SJCustomCellsViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 10:
        {
            NSLog(@"跳转到定制性cell展示页面 - 同组");
//            SJCustomCellsOneSectionViewController *vc = [[SJCustomCellsOneSectionViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
        }
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
