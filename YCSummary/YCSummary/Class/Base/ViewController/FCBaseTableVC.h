//
//  FCBaseTableVC.h
//  YCSummary
//
//  Created by wuyongchao on 2018/10/30.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface FCBaseTableVC : YCBaseVC<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mainView;
#pragma mark - 刷新某一区
-(void)reloadTableWithSection:(NSInteger)index;
/*刷新某一行*/
-(void)reloadTableWithSection:(NSInteger)section  Androw:(NSInteger)row;

@end

NS_ASSUME_NONNULL_END
