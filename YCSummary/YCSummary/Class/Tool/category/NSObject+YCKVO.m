//
//  NSObject+YCKVO.m
//  runtime
//
//  Created by wuyongchao on 2018/9/19.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//

#import "NSObject+YCKVO.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface YCBlockTarget :NSObject

-(void)yc_addBlcok:(void(^)(__weak id obj, id oldValue,id newValue))block;
- (void)yc_addNotificationBlock:(void(^)(NSNotification *notification))block;

- (void)yc_doNotification:(NSNotification*)notification;
@end
@implementation YCBlockTarget
{
    //保存所有的block
    NSMutableSet *kvoBlockSet;
    NSMutableSet *notificationBlockSet;
}
-(instancetype)init{
    self=[super init];
    if (self) {
        kvoBlockSet=[NSMutableSet new];
        notificationBlockSet=[NSMutableSet new];
    }
    return self;
}
-(void)yc_addBlcok:(void(^)(__weak id obj, id oldValue,id newValue))block{
    [kvoBlockSet addObject:[block copy]];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (!kvoBlockSet.count) return;
    BOOL prior=[[change objectForKey:NSKeyValueChangeNotificationIsPriorKey]boolValue];
    //只接受值改变时的消息
    if (prior)  return;
    NSKeyValueChange changeKind=[[change objectForKey:NSKeyValueChangeKindKey]integerValue];
    if (changeKind!=NSKeyValueChangeSetting) return;
    id oldValue=[change objectForKey:NSKeyValueChangeOldKey];
    if (oldValue==[NSNull null]) {
        oldValue=nil;
    }
    id newValue=[change objectForKey:NSKeyValueChangeNewKey];
    if (newValue==[NSNull null]) {
        newValue=nil;
    }
    //执行该blcok下的所有blcok
    [kvoBlockSet enumerateObjectsUsingBlock:^(void(^block)(__weak id obj,id oldValue,id newValue), BOOL * _Nonnull stop) {
        block(object,oldValue,newValue);
    }];
}
- (void)yc_addNotificationBlock:(void(^)(NSNotification *notification))block{
    [notificationBlockSet addObject:[block copy]];
}
-(void)yc_doNotification:(NSNotification*)notification{
    if (!notificationBlockSet.count) return;
    [notificationBlockSet enumerateObjectsUsingBlock:^(void (^block)(NSNotification *notification), BOOL * _Nonnull stop) {
        block(notification);
    }];
}
@end
@implementation NSObject (YCKVO)
static void *const YCKVOBlockKey=@"YCKVOBlockKey";
static void *const YCKVOSemaphoreKey=@"YCKVOSemaphoreKey";
#pragma mark - 注册监听者KVO
-(void)yc_addObserverBlockForKeyPath:(NSString*)keyPath block:(void (^)(id obj, id oldVale, id newVale))block{
    if (!keyPath||!block) return;
    dispatch_semaphore_t kvoSemaphore=[self yc_getSemaphoreWithKey:YCKVOSemaphoreKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    //取出所有KVOTarget的字典
    NSMutableDictionary *allTargets=objc_getAssociatedObject(self, YCKVOBlockKey);
    if (!allTargets) {
        //没有则创建
        allTargets=[NSMutableDictionary dictionary];
        //绑定在对象里
        objc_setAssociatedObject(self, YCKVOBlockKey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    YCBlockTarget *targetForKey=allTargets[keyPath];
    if (!targetForKey) {
        targetForKey=[YCBlockTarget new];
        allTargets[keyPath]=targetForKey;
        //如果第一次，则注册对keyPath的KVO监听
        [self addObserver:targetForKey forKeyPath:keyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    }
    [targetForKey yc_addBlcok:block];
    ////对第一次注册KVO的类进行dealloc方法调剂
//    [self yc_swizzleDealloc];
    dispatch_semaphore_signal(kvoSemaphore);
}
#pragma mark - 移除掉指定的监听者
-(void)yc_removeObserverBlockForKeyPath:(NSString *)keyPath{
    if (!keyPath.length) {
        return;
    }
    dispatch_semaphore_t kvoSemaphore=[self yc_getSemaphoreWithKey:YCKVOSemaphoreKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    //取出所有KVOTarget的字典
    NSMutableDictionary *allTargets=objc_getAssociatedObject(self, YCKVOBlockKey);
    if (!allTargets) {
        //没有则创建
        allTargets=[NSMutableDictionary dictionary];
        //绑定在对象里
        objc_setAssociatedObject(self, YCKVOBlockKey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    YCBlockTarget *targetForKey=allTargets[keyPath];
    if (!targetForKey)return;
    [self removeObserver:targetForKey forKeyPath:keyPath];
    [allTargets removeObjectForKey:keyPath];
    dispatch_semaphore_signal(kvoSemaphore);
}
#pragma mark - 移除掉所有的监听者kvo
-(void)yc_removeAllObserverBlock{

    dispatch_semaphore_t kvoSemaphore=[self yc_getSemaphoreWithKey:YCKVOSemaphoreKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    //取出所有KVOTarget的字典
    NSMutableDictionary *allTargets=objc_getAssociatedObject(self, YCKVOBlockKey);
    if (!allTargets) return;
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, YCBlockTarget  * target, BOOL * _Nonnull stop) {
        [self removeObserver:target forKeyPath:key];
    }];
    [allTargets removeAllObjects];
    dispatch_semaphore_signal(kvoSemaphore);
}

static void *const YCNotificationBlockKey = "YCNotificationBlockKey";
static void *const YCNotificationSemaphoreKey = "YCNotificationSemaphoreKey";
#pragma mark - -------通知相关
- (void)yc_addNotificationForName:(NSString *)name block:(void (^)(NSNotification *notification))block {
    if (!name || !block) return;
    dispatch_semaphore_t notificationSemaphore = [self yc_getSemaphoreWithKey:YCNotificationSemaphoreKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);// 返回0：表示正常。返回非0：表示等待时间超时
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, YCNotificationBlockKey);
    if (!allTargets) {
        allTargets = @{}.mutableCopy;
        objc_setAssociatedObject(self, YCNotificationBlockKey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    YCBlockTarget *target = allTargets[name];
    if (!target) {
        target = [YCBlockTarget new];
        allTargets[name] = target;
        [[NSNotificationCenter defaultCenter] addObserver:target selector:@selector(yc_doNotification:) name:name object:nil];
    }
    [target yc_addNotificationBlock:block];
//    [self yc_swizzleDealloc];
    dispatch_semaphore_signal(notificationSemaphore);//信号通知
}
#pragma mark - 移除单个通知
- (void)yc_removeNotificationForName:(NSString *)name{
    if (!name) return;
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, YCNotificationBlockKey);
    if (!allTargets.count) return;
    YCBlockTarget *target = allTargets[name];
    if (!target) return;
    dispatch_semaphore_t notificationSemaphore = [self yc_getSemaphoreWithKey:YCNotificationSemaphoreKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    [[NSNotificationCenter defaultCenter] removeObserver:target];
    [allTargets removeObjectForKey:name];
   dispatch_semaphore_signal(notificationSemaphore);
    
}
#pragma mark - 移除所有通知
- (void)yc_removeAllNotification{
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, YCNotificationBlockKey);
    if (!allTargets.count) return;
    dispatch_semaphore_t notificationSemaphore = [self yc_getSemaphoreWithKey:YCNotificationSemaphoreKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, YCBlockTarget *target, BOOL * _Nonnull stop) {
        [[NSNotificationCenter defaultCenter] removeObserver:target];
    }];
    [allTargets removeAllObjects];
   dispatch_semaphore_signal(notificationSemaphore);
}

- (void)yc_postNotificationWithName:(NSString *)name userInfo:(NSDictionary *)userInfo{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
}
static void * deallocHasSwizzledKey = "deallocHasSwizzledKey";
/**
 *  调剂dealloc方法，由于无法直接使用运行时的swizzle方法对dealloc方法进行调剂，所以稍微麻烦一些
 */
- (void)yc_swizzleDealloc{
    //我们给每个类绑定上一个值来判断dealloc方法是否被调剂过，如果调剂过了就无需再次调剂了
    BOOL swizzled = [objc_getAssociatedObject(self.class, deallocHasSwizzledKey) boolValue];
    //如果调剂过则直接返回
    if (swizzled) return;
    //开始调剂
    Class swizzleClass = self.class;
    @synchronized(swizzleClass) {
        //获取原有的dealloc方法
        SEL deallocSelector = sel_registerName("dealloc");
        //初始化一个函数指针用于保存原有的dealloc方法
        __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
        //实现我们自己的dealloc方法，通过block的方式
        id newDealloc = ^(__unsafe_unretained id objSelf){
            //在这里我们移除所有的KVO
            [objSelf yc_removeAllObserverBlock];
            //移除所有通知
            [objSelf yc_removeAllNotification];
            //根据原有的dealloc方法是否存在进行判断
            if (originalDealloc == NULL) {//如果不存在，说明本类没有实现dealloc方法，则需要向父类发送dealloc消息(objc_msgSendSuper)
                //构造objc_msgSendSuper所需要的参数，.receiver为方法的实际调用者，即为类本身，.super_class指向其父类
                struct objc_super superInfo = {
                    .receiver = objSelf,
                    .super_class = class_getSuperclass(swizzleClass)
                };
                //构建objc_msgSendSuper函数
                void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                //向super发送dealloc消息
                msgSend(&superInfo, deallocSelector);
            }else{//如果存在，表明该类实现了dealloc方法，则直接调用即可
                //调用原有的dealloc方法
                originalDealloc(objSelf, deallocSelector);
            }
        };
        //根据block构建新的dealloc实现IMP
        IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
        //尝试添加新的dealloc方法，如果该类已经复写的dealloc方法则不能添加成功，反之则能够添加成功
        if (!class_addMethod(swizzleClass, deallocSelector, newDeallocIMP, "v@:")) {
            //如果没有添加成功则保存原有的dealloc方法，用于新的dealloc方法中
            Method deallocMethod = class_getInstanceMethod(swizzleClass, deallocSelector);
            originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);
            originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
        }
        //标记该类已经调剂过了
        objc_setAssociatedObject(self.class, deallocHasSwizzledKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
}
#pragma mark - 获取信号量
-(dispatch_semaphore_t)yc_getSemaphoreWithKey:(void *)key{
    dispatch_semaphore_t semaphore = objc_getAssociatedObject(self, key); //获取关联对象
    if (!semaphore){
        semaphore = dispatch_semaphore_create(1);
        objc_setAssociatedObject(self, key, semaphore, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//nonatomic, strong
    }
    return semaphore;
}
@end
