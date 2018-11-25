//
//  YCWaterFlowLayout.h
//  YCSummary
//
//  Created by admin on 2018/11/25.
//  Copyright © 2018 YC科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YCWaterFlowLayout;

@protocol YCWaterFlowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(YCWaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(YCWaterFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(YCWaterFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(YCWaterFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(YCWaterFlowLayout *)waterflowLayout;
@end

@interface YCWaterFlowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<YCWaterFlowLayoutDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
