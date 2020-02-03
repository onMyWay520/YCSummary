//
//  YCCoreDataVC.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/13.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCCoreDataVC.h"
#import "YCCoreDataModel.h"
@interface YCCoreDataVC ()
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation YCCoreDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"coredata演练";
    self.mainView.rowHeight=HEIGHT(40);
    self.mainView.sectionFooterHeight=0.001;
    self.mainView.sectionHeaderHeight=HEIGHT(30);
    self.mainView.frame=CGRectMake(0,SafeAreaTopHeight, SCREENT_WIDTH, SCREENT_HEIGHT);
}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray=@[@"增",@"删",@"改",@"查"];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YCCoreDataModel *model=[[YCCoreDataModel alloc]init];
        switch (indexPath.section) {
            case 0:
                [model addschool];
                break;
            case 1:
                [model deleteSchool];
                break;
            case 2:
                [model updateSchool];
                break;
            case 3:
                 [model searchSchool];
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
