//
//  YCOperation.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/29.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCOperation.h"

@implementation YCOperation
- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"---%@", [NSThread currentThread]);
        }
    }
}
@end
