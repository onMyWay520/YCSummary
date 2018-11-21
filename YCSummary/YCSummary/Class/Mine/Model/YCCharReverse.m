//
//  YCCharReverse.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/21.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCCharReverse.h"

@implementation YCCharReverse
void char_reverse(char* cha)
{
    // 指向第一个字符
    char* begin = cha;
    // 指向最后一个字符
    char* end = cha + strlen(cha) - 1;
    
    while (begin < end) {
        // 交换前后两个字符,同时移动指针
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
}
@end
