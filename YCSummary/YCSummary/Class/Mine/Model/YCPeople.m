//
//  YCPeople.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/21.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCPeople.h"
#import "YCArchieveModel.h"
#import <objc/runtime.h>
/*消息转发机制原理
 当你调用一个类的方法时，先在本类中的方法缓存列表中进行查询，如果在缓存列表中找到了该方法的实现，就执行，如果找不到就在本类中的方列表中进行查找。在本类方列表中查找到相应的方法实现后就进行调用，如果没找到，就去父类中进行查找。如果在父类中的方法列表中找到了相应方法的实现，那么就执行，否则就执行下方的几步
 */
@implementation YCPeople
//- (void)eat {
//    NSLog(@"吃鸡腿");
//}
//
//- (void)run:(NSUInteger)metre
//{
//    NSLog(@"跑了 %ld 米", metre);
//}
//当类调用一个没有实现的类方法就会到这里！！
/*这个函数与forwardingTargetForSelector类似，都会在对象不能接受某个selector时触发，执行起来略有差别。前者的目的主要在于给客户一个机会来向该对象添加所需的selector，后者的目的在于允许用户将selector转发给另一个对象。另外触发时机也不完全一样，该函数是个类函数，在程序刚启动，界面尚未显示出时，就会被调用。*/
+(BOOL)resolveClassMethod:(SEL)sel{
    NSLog(@"==%@",NSStringFromSelector(sel));
    return [super resolveClassMethod:sel];
}

//当类调用一个没有实现的对象方法就会到这里！！
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(eat)) {
        // 动态添加eat方法
        /*
         第一个参数：给哪个类添加方法
         第二个参数：添加方法的方法编号
         第三个参数：添加方法的函数实现（函数地址）
         第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
         */
        class_addMethod(self, @selector(eat), eat, "v@:");
    }
    return [super resolveInstanceMethod:sel];
}
//将无法处理的selector转发给其他对象，上面的两个方法没有实现时，会调用下面的方法，会进行消息转发，指向其他类，调其他类中有的这个方法
-(id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector==@selector(eat)) {
        return [YCArchieveModel new] ;
    }
    else{
        return [super forwardingTargetForSelector:aSelector];
    }
}
/**
 *  转发方法打包转发出去
 *
 *  @param anInvocation
 */
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    for (id item in self) {
        if ([item respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:item];
        }
    }
}
// 默认方法都有两个隐式参数，
void eat(id self,SEL sel)
{
    NSLog(@"++%@ %@",self,NSStringFromSelector(sel));
}
@end
