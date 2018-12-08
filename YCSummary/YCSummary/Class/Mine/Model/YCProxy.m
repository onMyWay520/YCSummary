//
//  YCProxy.m
//  YCSummary
//
//  Created by wuyongchao on 2018/12/8.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCProxy.h"
@interface YCProxy()
//@property(nonatomic,weak)id target;
@property(nonatomic,strong)NSObject *objc;
@end

@implementation YCProxy
+(instancetype)proxyWithObject:(id)object{
    YCProxy *proxy=[YCProxy alloc];
    //hold住要hook的对象
    proxy->_interObject=object;
    //注意返回的值是proxy对象
    return proxy;
}
- (void)transformObjc:(NSObject *)objc{
    //复制对象
    self.objc = objc;
}
#pragma mark - mark这个函数在运行时(runtime)，没有找到SEL的IML时就会执行。这个函数是给类利用class_addMethod添加函数的机会。如果实现了添加函数代码则返回YES，未实现返回NO。.查询该方法的方法签名
-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    //这里可以返回任何NSMethodSignature对象，你也可以完全自己构造一个
//    return [_interObject methodSignatureForSelector:sel];
    NSMethodSignature *signature = nil;
    if ([self.objc methodSignatureForSelector:sel]) {
        signature = [self.objc methodSignatureForSelector:sel];
    }
    else{
        signature = [super methodSignatureForSelector:sel];
    }
    return signature;
}
#pragma mark - 有了方法签名之后就会调用方法实现
- (void)forwardInvocation:(NSInvocation *)invocation{
//    if([_interObject respondsToSelector:invocation.selector]){
//        NSString *selectorName = NSStringFromSelector(invocation.selector);
//        NSLog(@"Before calling %@",selectorName);
//        [invocation retainArguments];
//        NSMethodSignature *sig = [invocation methodSignature];
//        //获取参数个数，注意再本例里这里的值是3，为什么呢？
//        //对，就是因为objc_msgSend的前两个参数是隐含的
//        NSUInteger cnt = [sig numberOfArguments];
//        //本例只是简单的将参数和返回值打印出来
//        for (int i = 0; i < cnt; i++) {
//            const char * type = [sig getArgumentTypeAtIndex:i];
//            if(strcmp(type, "@") == 0){
//                NSObject *obj;
//                [invocation getArgument:&obj atIndex:i];
//                //这里输出的是："parameter (0)'class is MyProxy"
//                //也证明了这是objc_msgSend的第一个参数
//                NSLog(@"parameter (%d)'class is %@",i,[obj class]);
//            }
//            else if(strcmp(type, ":") == 0){
//                SEL sel;
//                [invocation getArgument:&sel atIndex:i];
//                //这里输出的是:"parameter (1) is barking:"
//                //也就是objc_msgSend的第二个参数
//                NSLog(@"parameter (%d) is %@",i,NSStringFromSelector(sel));
//            }
//            else if(strcmp(type, "q") == 0){
//                int arg = 0;
//                [invocation getArgument:&arg atIndex:i];
//                //这里输出的是:"parameter (2) is int value is 4"
//                //稍后会看到我们再调用barking的时候传递的参数就是4
//                NSLog(@"parameter (%d) is int value is %d",i,arg);
//            }
//        }
//        //消息转发
//        [invocation invokeWithTarget:_interObject];
//        const char *retType = [sig methodReturnType];
//        if(strcmp(retType, "@") == 0){
//            NSObject *ret;
//            [invocation getReturnValue:&ret];
//            //这里输出的是:"return value is wang wang!"
//            NSLog(@"return value is %@",ret);
//        }
//        NSLog(@"After calling %@",selectorName);
//    }
    if (self.objc) {
        //拦截方法的执行者为复制的对象
        [invocation setTarget:self.objc];
        if ([self.objc isKindOfClass:[NSClassFromString(@"dog") class]]) {
            //拦截参数 Argument:表示的是方法的参数  index:表示的是方法参数的下标
            NSString *str = @"拦截消息";
            [invocation setArgument:&str atIndex:1];
        }
        //开始调用方法
        [invocation invoke];
    }
}
/*Before calling barking:
 2018-12-08 15:05:33.060593+0800 YCSummary[14380:274038] parameter (0)'class is YCProxy
 2018-12-08 15:05:33.060683+0800 YCSummary[14380:274038] parameter (1) is barking:
 2018-12-08 15:05:33.060765+0800 YCSummary[14380:274038] parameter (2) is int value is 4
 2018-12-08 15:05:33.060850+0800 YCSummary[14380:274038] return value is wangwang
 2018-12-08 15:05:33.060924+0800 YCSummary[14380:274038] After calling barking:
*/
@end
@implementation YCDog

-(NSString *)barking:(NSInteger)months{
    return months>3?@"wangwang":@"wangcai";
}
-(void)shut{
    DebugLog(@"狗叫");
}
@end
