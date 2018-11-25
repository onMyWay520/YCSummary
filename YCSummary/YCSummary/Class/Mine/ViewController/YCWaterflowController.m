//
//  YCWaterflowController.m
//  YCSummary
//
//  Created by admin on 2018/11/25.
//  Copyright © 2018 YC科技有限公司. All rights reserved.
//

#import "YCWaterflowController.h"
#import "YCWaterFlowLayout.h"
#import "MJRefresh.h"

@interface YCWaterflowController ()<UICollectionViewDataSource,YCWaterFlowLayoutDelegate>

@property (nonatomic, weak) UICollectionView *collectionView; /**< <#注释#> */
@end
@implementation YCWaterflowController
static NSString * const YCShopId = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"瀑布流";
    
    YCWaterFlowLayout *layout = [[YCWaterFlowLayout alloc]init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:    CGRectMake(0, 0, SCREENT_WIDTH, SCREENT_HEIGHT) collectionViewLayout:layout];
    collectionView.backgroundColor = RGB(237, 237, 237);
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    // 注册
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:YCShopId];
    
    [self setupRefresh];
    
    //
    [self.collectionView setAccessibilityIdentifier:@"collectionView"];
    [self.collectionView setIsAccessibilityElement:YES];
}

- (void)setupRefresh{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendRequest)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.collectionView.mj_footer.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 发送网络请求
- (void)sendRequest{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.collectionView.mj_header endRefreshing];
    });
    
}
- (void)loadMore{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.collectionView.mj_footer endRefreshing];
    });
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YCShopId forIndexPath:indexPath];
    
    cell.backgroundColor = RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));

    NSInteger tag = 10;
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        [cell.contentView addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"%zd", indexPath.item];
    [label sizeToFit];
    
    return cell;
}

#pragma mark - <YCWaterFlowLayoutDelegate>
- (CGFloat)waterflowLayout:(YCWaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    return 100 + arc4random_uniform(150);
}

- (CGFloat)rowMarginInWaterflowLayout:(YCWaterFlowLayout *)waterflowLayout{
    return 10;
}

- (CGFloat)columnCountInWaterflowLayout:(YCWaterFlowLayout *)waterflowLayout{
    return 3;
}

-(UIEdgeInsets)edgeInsetsInWaterflowLayout:(YCWaterFlowLayout *)waterflowLayout{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
