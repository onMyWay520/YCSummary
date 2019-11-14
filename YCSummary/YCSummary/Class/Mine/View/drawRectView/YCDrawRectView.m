//
//  YCDrawRectView.m
//  YCSummary
//https://www.jianshu.com/p/324c879de586
//  Created by wuyongchao on 2019/11/14.
//  Copyright © 2019 YC科技有限公司. All rights reserved.
//

#import "YCDrawRectView.h"

@implementation YCDrawRectView


- (void)drawRect:(CGRect)rect
{
    switch (self.type) {
      case kdrawParagraph: {
        [self drawParagraph:rect];
        break;
        }
        case kdrawText:{
           [self drawText:rect];
            break;
        }
            
        case kdrawLine: {
        [self drawLine:rect];
        break;
      }
      case kdrawDotLine: {
       [self drawDotLine:rect];
        break;
      }
     case kdrawImage: {
        [self drawImage:rect];
        break;
      }
      default: {
       
        break;
      }
    }
    

}
#pragma mark - 绘制段落
-(void)drawParagraph:(CGRect)rect{
    NSString *text = @"I am an iOS developer,you are an iOS developer,I am an iOS developer,you are an iOS developer";
      // 文本段落样式
      NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle alloc] init];
      textStyle.lineBreakMode = NSLineBreakByWordWrapping; // 结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
      textStyle.alignment = NSTextAlignmentLeft; //（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
      textStyle.lineSpacing = 5; // 字体的行间距
      textStyle.firstLineHeadIndent = 10.0; // 首行缩进
      textStyle.headIndent = 10.0; // 整体缩进(首行除外)
      textStyle.tailIndent = 0.0; //
      textStyle.minimumLineHeight = 20.0; // 最低行高
      textStyle.maximumLineHeight = 20.0; // 最大行高
      textStyle.paragraphSpacing = 15; // 段与段之间的间距
      textStyle.paragraphSpacingBefore = 22.0f; // 段首行空白空间/* Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph. */
      textStyle.baseWritingDirection = NSWritingDirectionLeftToRight; // 从左到右的书写方向（一共➡️三种）
      textStyle.lineHeightMultiple = 15; /* Natural line height is multiplied by this factor (if positive) before being constrained by minimum and maximum line height. */
      textStyle.hyphenationFactor = 1; //连字属性 在iOS，唯一支持的值分别为0和1
      // 文本属性
      NSMutableDictionary *textAttributes = [[NSMutableDictionary alloc] init];
      // NSParagraphStyleAttributeName 段落样式
      [textAttributes setValue:textStyle forKey:NSParagraphStyleAttributeName];
      // NSFontAttributeName 字体名称和大小
      [textAttributes setValue:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
      // NSForegroundColorAttributeNam 颜色
      [textAttributes setValue:[UIColor redColor] forKey:NSForegroundColorAttributeName];
      // 绘制文字
      [text drawInRect:rect withAttributes:textAttributes];
}
#pragma mark - 绘制文本
-(void)drawText:(CGRect)rect{
    UIFont* font = [UIFont fontWithName:@"Arial" size:24];
    UIColor* textColor = [UIColor redColor];
    NSDictionary* stringAttrs = @{ NSFontAttributeName : font,
           NSForegroundColorAttributeName : textColor };
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:@"Hello" attributes:stringAttrs];
    [attrStr drawAtPoint:CGPointMake(20.f, 20.f)];
//    [attrStr drawInRect:CGRectMake(10, 100, 200, 30)];
}
#pragma mark - 画直线
-(void)drawLine:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
       
       // 线条宽
       CGContextSetLineWidth(context,1);
       // 线条颜色
       CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        // 起点坐标
       CGContextMoveToPoint(context, 10.0, 40.0);
       // 终点坐标
       CGContextAddLineToPoint(context, (rect.size.width - 10.0), 40.0);
       // 绘制路径
       CGContextStrokePath(context);
}
#pragma mark - 画虚线
-(void)drawDotLine:(CGRect)rect{
      CGContextRef context = UIGraphicsGetCurrentContext();
       
       // 线条宽
       CGContextSetLineWidth(context,1);
       // 线条颜色
       CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
      // 虚线
        CGFloat dashArray[] = {1, 4}; // 表示先画1个点再画4个点（前者小后者大时，虚线点小且间隔大；前者大后者小时，虚线点大且间隔小）
        CGContextSetLineDash(context, 1, dashArray, 2); // 其中的2表示dashArray中的值的个数
        // 起点坐标
       CGContextMoveToPoint(context, 10.0, 40.0);
       // 终点坐标
       CGContextAddLineToPoint(context, (rect.size.width - 10.0), 40.0);
       // 绘制路径
       CGContextStrokePath(context);
}
-(void)drawImage:(CGRect)rect{
    // 图片裁剪
//    UIRectClip(CGRectMake(10, 10, 100, 100));
    [IMAGE_NAMED(@"phil") drawInRect:rect];

    
}
@end
