//
//  NSObject+hook.m
//  runtime
//
//  Created by wuyongchao on 2018/5/28.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//

#import "NSObject+hook.h"
#import <objc/runtime.h>
@implementation NSObject (hook)
const char *kPropertyListKey = "YCPropertyListKey";
// 定义关联的key
static const char *key = "name";
//获取所有的关联对象
+ (NSArray *)yc_objcProperties
{
    /* 获取关联对象 */
    NSArray *ptyList = objc_getAssociatedObject(self, kPropertyListKey);
    /* 如果 ptyList 有值,直接返回 */
    if (ptyList) {
        return ptyList;
    }
    /* 调用运行时方法, 取得类的属性列表 */
    /* 成员变量:
     * class_copyIvarList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 方法:
     * class_copyMethodList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 属性:
     * class_copyPropertyList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 协议:
     * class_copyProtocolList(__unsafe_unretained Class cls, unsigned int *outCount)
     */
    unsigned int outCount = 0;
    /**
     * 参数1: 要获取得类
     * 参数2: 类属性的个数指针
     * 返回值: 所有属性的数组, C 语言中,数组的名字,就是指向第一个元素的地址
     */
    /* retain, creat, copy 需要release */
    objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
    NSMutableArray *mtArray = [NSMutableArray array];
    /* 遍历所有属性 */
    for (unsigned int i = 0; i < outCount; i++) {
        /* 从数组中取得属性 */
        objc_property_t property = propertyList[i];
        /* 从 property 中获得属性名称 */
        const char *propertyName_C = property_getName(property);
        /* 将 C 字符串转化成 OC 字符串 */
        NSString *propertyName_OC = [NSString stringWithCString:propertyName_C encoding:NSUTF8StringEncoding];
        [mtArray addObject:propertyName_OC];
    }
    /* 设置关联对象 */
    /**
     *  参数1 : 对象self
     *  参数2 : 动态添加属性的 key
     *  参数3 : 动态添加属性值
     *  参数4 : 对象的引用关系
     */
    objc_setAssociatedObject(self, kPropertyListKey, mtArray.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    /* 释放 */
    free(propertyList);
    return mtArray.copy;
}
/* 获取对象的所有方法 */
+(NSArray *)getAllMethods{
    unsigned int methodCount =0;
    Method* methodList = class_copyMethodList([self class],&methodCount);
    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:methodCount];
    
    for(int i=0;i<methodCount;i++){
        Method temp = methodList[i];
        IMP imp = method_getImplementation(temp);
        SEL name_f = method_getName(temp);
        const char* name_s =sel_getName(method_getName(temp));
        int arguments = method_getNumberOfArguments(temp);
        const char* encoding =method_getTypeEncoding(temp);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,
              [NSString stringWithUTF8String:encoding]);
        [methodsArray addObject:[NSString stringWithUTF8String:name_s]];
    }
    free(methodList);
    return methodsArray;
}
/*获取协议列表*/
+(NSArray *)getProtocolList{
    unsigned int count=0;
    __unsafe_unretained Protocol **protocolList=class_copyProtocolList([self class], &count);
    NSMutableArray *mutableList=[NSMutableArray arrayWithCapacity:count];
    for (unsigned int i=0; i<count; i++) {
        Protocol *protocol=protocolList[i];
        const char *protocolName=protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String:protocolName]];
    }
    return [NSArray arrayWithArray:mutableList];
}
/*获取类名*/
+(NSString *)getClassName{
    const char *className=class_getName([self class]);
    return [NSString stringWithUTF8String:className];
}
/*获取成员变量*/
+(NSArray *)getIvarList{
    unsigned int count=0;
    Ivar *ivarList=class_copyIvarList([self class], &count);
    NSMutableArray *mutableArray=[NSMutableArray arrayWithCapacity:count];
    for (unsigned int i=0; i<count; i++) {
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        const char *ivarName=ivar_getName(ivarList[i]);
        const char *ivarType=ivar_getTypeEncoding(ivarList[i]);
        dic[@"ivarName"]=[NSString stringWithUTF8String:ivarName];
        dic[@"type"]=[NSString stringWithUTF8String:ivarType];
        [mutableArray addObject:dic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableArray];
}
/*字典转模型*/
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    /* 实例化对象 */
    id objc = [[self alloc]init];
    /* 使用字典,设置对象信息 */
    /* 1. 获得 self 的属性列表 */
    NSArray *propertyList = [self  yc_objcProperties];
    /* 2. 遍历字典 */
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        /* 3. 判断 key 是否字 propertyList 中 */
        if ([propertyList containsObject:key]) {
            /* 说明属性存在,可以使用 KVC 设置数值 */
            [objc setValue:obj forKey:key];
        }
    }];
    /* 返回对象 */
    return objc;
}
-(NSString *)name{
    // 根据关联的key，获取关联的值。
    return objc_getAssociatedObject(self, key);
}
-(void)setName:(NSString *)name{
    // 第一个参数：给哪个对象添加关联
    // 第二个参数：关联的key，通过这个key获取
    // 第三个参数：关联的value
    // 第四个参数:关联的策略
    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
