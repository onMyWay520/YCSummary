//
//  UIImage+Swizzling.m
//  runtime
//
//  Created by wuyongchao on 2018/5/28.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//

#import "UIImage+Swizzling.h"
#import <objc/message.h>
@implementation UIImage (Swizzling)
+ (void)load {
    // 获取到两个方法
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method yc_imageNamedMethod = class_getClassMethod(self, @selector(yc_imageNamed:));
    
    // 交换方法
    method_exchangeImplementations(imageNamedMethod, yc_imageNamedMethod);
}
+ (UIImage *)yc_imageNamed:(NSString *)name{
    // 因为来到这里的时候方法实际上已经被交换过了
    // 这里要调用 imageNamed: 就需要调换被交换过的 yc_imageNamed
    UIImage *image = [UIImage yc_imageNamed:name];
    
    // 判断是否存在图片
    if (image) {
        NSLog(@"图片加载出来了");
    } else {
        NSLog(@"图片加载不出来");
    }
    
    return image;
}
@end
