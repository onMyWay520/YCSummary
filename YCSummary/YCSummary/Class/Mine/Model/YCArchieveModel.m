//
//  YCArchieveModel.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/21.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCArchieveModel.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation YCArchieveModel
-(void)eat{
    NSLog(@"吃吃吃，我是消息转发过来的");
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int outCount=0;
    Ivar *vars=class_copyIvarList([self  class], &outCount);
    for (int i=0; i<outCount; i++) {
        Ivar var=vars[i];
        const char *name=ivar_getName(var);
        NSString *key=[NSString stringWithUTF8String:name];
        //注意kvc的特性是，如果能找到key这个属性的setter方法，则调用setter方法
        //如果找不到setter方法，则查找成员变量key或者成员变量_key，并且为其赋值
        id value=[self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(vars);
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        unsigned int outCount=0;
        Ivar *vars=class_copyIvarList([self class], &outCount);
        for (int i=0; i<outCount; i++) {
            Ivar var=vars[i];
            const char *name=ivar_getName(var);
            NSString *key=[NSString stringWithUTF8String:name];
            id value=[aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(vars);
        
    }
    return self;
}
@end
