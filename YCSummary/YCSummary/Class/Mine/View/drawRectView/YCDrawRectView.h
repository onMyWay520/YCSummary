//
//  YCDrawRectView.h
//  YCSummary
//
//  Created by wuyongchao on 2019/11/14.
//  Copyright © 2019 YC科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, YCDrawRectType) {
  kdrawParagraph = 1, // 绘制段落
  kdrawText=2,//绘制文本
  kdrawLine = 3, // 绘制直线
  kdrawDotLine = 4,//绘制虚线
  kdrawImage=5,//绘制图片
};
@interface YCDrawRectView : UIView
@property (nonatomic, assign) YCDrawRectType type;

@end

NS_ASSUME_NONNULL_END
