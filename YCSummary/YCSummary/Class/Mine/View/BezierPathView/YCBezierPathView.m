//
//  YCBezierPathView.m
//  YCSummary
//
//  Created by wuyongchao on 2019/11/14.
//  Copyright © 2019 YC科技有限公司. All rights reserved.
//

#import "YCBezierPathView.h"

@implementation YCBezierPathView


-(void)drawRect:(CGRect)rect{
   
    switch (self.type) {
      case kDefaultPath: {
        [self drawTrianglePath];
        break;
      }
      case kRectPath: {
        [self drawrectanglePach];
        break;
      }
      case kCirclePath: {
        [self drawCiclePath];
        break;
      }
      case kOvalPath: {
        [self drawOvalPath];
        break;
      }
      case kRoundedRectPath: {
        [self drawRoundedRectPath];
        break;
      }
      case kArcPath: {
        [self drawARCPath];
        break;
      }
      case kSecondBezierPath: {
        [self drawSecondBezierPath];
        break;
      }
      case kThirdBezierPath: {
        [self drawThirdBezierPath];
        break;
      }
      default: {
        break;
      }
    }
}
#pragma mark - 画三角形
-(void)drawTrianglePath{
     UIBezierPath *path=[UIBezierPath bezierPath];
       [path moveToPoint:CGPointMake(50, 20)];
       [path addLineToPoint:CGPointMake(self.frame.size.width-50, 20)];
       [path addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height-50)];
       [path closePath];
       path.lineWidth=1;
       //设置填充颜色
       UIColor *fillColor=[UIColor redColor];
       [fillColor set];
       [path fill];
       //设置画笔颜色
       UIColor *strokeColor=[UIColor blueColor];
       [strokeColor set];
       //根据设置的各个点连线
       [path stroke];
}
#pragma mark - 画矩形
- (void)drawrectanglePach{
    UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(20, 20, self.frame.size.width-40, self.frame.size.height-40)];
    path.lineWidth=1;
    path.lineCapStyle=kCGLineCapRound;
    path.lineJoinStyle=kCGLineJoinBevel;
    
    //设置填充颜色
    UIColor *fillColor=[UIColor redColor];
    [fillColor set];
    [path fill];
    //设置画笔颜色
    UIColor *strokeColor=[UIColor blueColor];
    [strokeColor set];
    [path stroke];
    
}
#pragma mark - 画圆
- (void)drawCiclePath {
  // 传的是正方形，因此就可以绘制出圆了
  UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.width - 40)];
  
  // 设置填充颜色
  UIColor *fillColor = [UIColor redColor];
  [fillColor set];
  [path fill];
  
  // 设置画笔颜色
  UIColor *strokeColor = [UIColor blueColor];
  [strokeColor set];
  
  // 根据我们设置的各个点连线
  [path stroke];
}

#pragma mark -画椭圆
- (void)drawOvalPath {
  // 传的是不是正方形，因此就可以绘制出椭圆了
  UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.height - 40)];
  
  // 设置填充颜色
  UIColor *fillColor = [UIColor redColor];
  [fillColor set];
  [path fill];
  
  // 设置画笔颜色
  UIColor *strokeColor = [UIColor blueColor];
  [strokeColor set];
  
  // 根据我们设置的各个点连线
  [path stroke];
}
#pragma mark - 带圆形的矩形
- (void)drawRoundedRectPath {
//  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.height - 40) cornerRadius:10];
  
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.height - 40) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
  // 设置填充颜色
  UIColor *fillColor = [UIColor greenColor];
  [fillColor set];
  [path fill];
  
  // 设置画笔颜色
  UIColor *strokeColor = [UIColor blueColor];
  [strokeColor set];
  
  // 根据我们设置的各个点连线
  [path stroke];
}
#pragma mark - 弧
#define   kDegreesToRadians(degrees)  ((pi * degrees)/ 180)
- (void)drawARCPath {
  const CGFloat pi = 3.14159265359;

  CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
  UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                      radius:100
                                                  startAngle:0
                                                    endAngle:kDegreesToRadians(135)
                                                   clockwise:YES];
  
  path.lineCapStyle = kCGLineCapRound;
  path.lineJoinStyle = kCGLineJoinRound;
  path.lineWidth = 1.0;
  
  UIColor *strokeColor = [UIColor redColor];
  [strokeColor set];
  
  [path stroke];
}
#pragma mark -  二次贝塞尔曲线
- (void)drawSecondBezierPath {
  UIBezierPath *path = [UIBezierPath bezierPath];
  
  // 首先设置一个起始点
  [path moveToPoint:CGPointMake(20, self.frame.size.height - 100)];

  // 添加二次曲线
  [path addQuadCurveToPoint:CGPointMake(self.frame.size.width - 20, self.frame.size.height - 100)
               controlPoint:CGPointMake(self.frame.size.width / 2, 0)];
  
  path.lineCapStyle = kCGLineCapRound;
  path.lineJoinStyle = kCGLineJoinRound;
  path.lineWidth = 5.0;
  
  UIColor *strokeColor = [UIColor redColor];
  [strokeColor set];
  
  [path stroke];
}
#pragma mark -  三次贝塞尔曲线
- (void)drawThirdBezierPath {
  UIBezierPath *path = [UIBezierPath bezierPath];
  
  // 设置起始端点
  [path moveToPoint:CGPointMake(20, 150)];
  
  [path addCurveToPoint:CGPointMake(300, 150)
          controlPoint1:CGPointMake(160, 0)
          controlPoint2:CGPointMake(160, 250)];
  
  path.lineCapStyle = kCGLineCapRound;
  path.lineJoinStyle = kCGLineJoinRound;
  path.lineWidth = 5.0;
  
  UIColor *strokeColor = [UIColor redColor];
  [strokeColor set];
  
  [path stroke];
}
@end
