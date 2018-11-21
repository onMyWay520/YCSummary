//
//  YCNewModel.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/21.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCNewModel.h"
#import <objc/message.h>
#import "NSObject+hook.h"
@implementation YCNewModel
+(void)crateClass{
    // 1、 添加一个集成NSObject的类  类名是MyClass
    Class MyClass=objc_allocateClassPair([NSObject class], "MyClass", 0);
    //2.增加实例变量
    BOOL isSuccess=class_addIvar(MyClass, "TEST", sizeof(NSString *), 0, "@");
    NSLog(@"isSuccess==%d",isSuccess);
    //3.增加方法
    class_addMethod(MyClass, @selector(addMethodForMyClass:), (IMP)addMethodForMyClass, "V@:");
    objc_registerClassPair(MyClass);
    /*报错在项目配置文件 -> Build Settings -> Enable Strict Checking of objc_msgSend Calls 这个字段设置为 NO, 默认为YES.*/
    id myClass=objc_msgSend(MyClass, @selector(alloc));
    myClass=objc_msgSend(myClass, @selector(init));
    NSString *string=@"我是测试";
    // 通过KVC的方式给myClass对象的TEST属性赋值,注意不能为setObject...forKey
    [myClass setValue:string forKey:@"TEST"];
    [myClass addMethodForMyClass:@"ceshi"];
    NSArray *arr=[MyClass getAllMethods];
    NSLog(@"arr%@",arr);
    
}
//self和_cmd是必须的，在之后可以随意添加其他参数
static void addMethodForMyClass(id self, SEL _cmd, NSString *test) {
    
    // 获取类中指定名称实例成员变量的信息
    Ivar ivar = class_getInstanceVariable([self class], "TEST");
    // 获取整个成员变量列表
    //   Ivar * class_copyIvarList ( Class cls, unsigned intint * outCount );
    // 获取类中指定名称实例成员变量的信息
    //   Ivar class_getInstanceVariable ( Class cls, const charchar *name );
    // 获取类成员变量的信息
    //   Ivar class_getClassVariable ( Class cls, const charchar *name );
    // 返回名为test的ivar变量的值
    id obj = object_getIvar(self, ivar);
    
    NSLog(@"obj%@",obj);
    NSLog(@"addMethodForMyClass:参数：%@",test);
    NSLog(@"ClassName：%@",NSStringFromClass([self class]));
    
}
//这个方法实际上没有被调用,但是必须实现否则不会调用下面的方法
- (void)addMethodForMyClass:(NSString *)string {
    
}
@end
