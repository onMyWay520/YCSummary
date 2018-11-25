//
//  YCLikeOrUnlikeVC.m
//  YCSummary
//
//  Created by admin on 2018/11/25.
//  Copyright © 2018 YC科技有限公司. All rights reserved.
//

#import "YCLikeOrUnlikeVC.h"
#import "CCDraggableContainer.h"
#import "YCCustomCardView.h"
@interface YCLikeOrUnlikeVC ()<
CCDraggableContainerDataSource,
CCDraggableContainerDelegate
>

@property (nonatomic, strong) CCDraggableContainer *container;
@property (nonatomic, strong) NSMutableArray *dataSources;

@end
@implementation YCLikeOrUnlikeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self loadUI];
}
- (void)loadUI {
    // 防止视图变黑
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化Container
    self.container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, 64, CCWidth, CCWidth) style:CCDraggableStyleUpOverlay];
    self.container.delegate = self;
    self.container.dataSource = self;
    self.container.backgroundColor = [UIColor colorWithRed:0.792 green:0.918 blue:0.808 alpha:1.00];
    [self.view addSubview:self.container];
    // 重启加载
    [self.container reloadData];
}

- (void)loadData {
    
    _dataSources = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++) {
        NSDictionary *dict = @{@"image" : [NSString stringWithFormat:@"image_%d.jpg",i + 1],
                               @"title" : [NSString stringWithFormat:@"Page %d",i + 1]};
        [_dataSources addObject:dict];
    }
}

#pragma mark - CCDraggableContainer DataSource

- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    
    YCCustomCardView *cardView = [[YCCustomCardView alloc] initWithFrame:draggableContainer.bounds];
    [cardView installData:[_dataSources objectAtIndex:index]];
    return cardView;
}

- (NSInteger)numberOfIndexs {
    return _dataSources.count;
}

#pragma mark - CCDraggableContainer Delegate

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    
    CGFloat scale = 1 + ((kBoundaryRatio > fabs(widthRatio) ? fabs(widthRatio) : kBoundaryRatio)) / 4;
    if (draggableDirection == CCDraggableDirectionLeft) {
        // self.disLikeButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
    if (draggableDirection == CCDraggableDirectionRight) {
        // self.likeButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    
    NSLog(@"点击了Tag为%ld的Card", (long)didSelectIndex);
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    
    [draggableContainer reloadData];
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
