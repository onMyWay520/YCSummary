//
//  YCBezierPathView.h
//  YCSummary
//
//  Created by wuyongchao on 2019/11/14.
//  Copyright © 2019 YC科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, YCBezierPathType) {
  kDefaultPath = 1, // 三角形
  kRectPath = 2, // 矩形
  kCirclePath = 3,//圆
  kOvalPath = 4, // 椭圆
  kRoundedRectPath = 5, // 带圆角的矩形
  kArcPath = 6, // 弧
  kSecondBezierPath = 7, // 二次贝塞尔曲线
  kThirdBezierPath = 8 // 三次贝塞尔曲线
};
@interface YCBezierPathView : UIView
@property (nonatomic, assign) YCBezierPathType type;
@end

NS_ASSUME_NONNULL_END
