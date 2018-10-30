//
//  YCHomeVC.m
//  YCSummary
//
//  Created by wuyongchao on 2018/10/29.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCHomeVC.h"
#import "VVeboTableView.h"
@interface YCHomeVC ()
{
    VVeboTableView *tableView;
}
@end

@implementation YCHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"首页";
    tableView = [[VVeboTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    [self.view addSubview:tableView];
    
    UIToolbar *statusBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    [self.view addSubview:statusBar];
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
