//
//  NSDictionary+NilSafe.m
//  runtime
//
//  Created by wuyongchao on 2018/6/21.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//

#import <objc/runtime.h>
#import "NSDictionary+NilSafe.h"

@implementation NSObject (Swizzling)
#ifdef DEBUG
#else
+ (BOOL)gl_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),
                                   class_getInstanceMethod(self, altSel));
    return YES;
}

+ (BOOL)gl_swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel {
    return [object_getClass((id)self) gl_swizzleMethod:origSel withMethod:altSel];
}
#endif
@end


@implementation NSArray (SafeIndex)
#ifdef DEBUG
#else

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // NSArray 是一个类簇,具体有三个子类__NSArray0,__NSSingleObjectArrayI,__NSArrayI,
        // 还有一个__NSPlaceholderArray是占位的,不实际使用
        
        // 对__NSArray0,__NSSingleObjectArrayI来说,下面三种调用的同一个方法objectAtIndex
        
        /** 对__NSArrayI,__NSArrayM来说,objectAtIndex 和 objectAtIndexedSubscript 有不同的实现,
         array[22]调用了objectAtIndexedSubscript */
        //        [array objectAtIndex:22];
        //        [array objectAtIndexedSubscript:22];
        //        array[22];
        
        [objc_getClass("__NSArray0") gl_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(emptyObjectIndex:)];
        [objc_getClass("__NSSingleObjectArrayI") gl_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(singleObjectIndex:)];
        
        [objc_getClass("__NSArrayI") gl_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safe_arrObjectIndex:)];
        [objc_getClass("__NSArrayI") gl_swizzleMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(safe_objectAtIndexedSubscript:)];
        
        
        
        [objc_getClass("__NSArrayM") gl_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectIndex:)];
        [objc_getClass("__NSArrayM") gl_swizzleMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(mutableArray_safe_objectAtIndexedSubscript:)];
        
        [objc_getClass("__NSArrayM") gl_swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(safeInsertObject:atIndex:)];
        [objc_getClass("__NSArrayM") gl_swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];
        
        
    });
    
}


- (id)emptyObjectIndex:(NSInteger)index {
    NSLog(@"__NSArray0 取一个空数组 objectAtIndex , 崩溃") ;
    return nil;
}
- (id)singleObjectIndex:(NSInteger)index {
    if (index >= self.count || index < 0) {
        NSLog(@"__NSSingleObjectArrayI 取一个不可变单元素数组时越界 objectAtIndex , 崩溃") ;
        return nil;
    }
    return [self singleObjectIndex:index];
}

- (id)safe_arrObjectIndex:(NSInteger)index{
    
    if (index >= self.count || index < 0) {
        NSLog(@"__NSArrayI 取不可变数组时越界 objectAtIndex , 崩溃") ;
        return nil;
    }
    return [self safe_arrObjectIndex:index];
    
}
- (id)safe_objectAtIndexedSubscript:(NSInteger)index{
    
    if (index >= self.count || index < 0) {
        NSLog(@"__NSArrayI 取不可变数组时越界 objectAtIndexedSubscript , 崩溃") ;
        return nil;
    }
    return [self safe_objectAtIndexedSubscript:index];
    
}
- (id)mutableArray_safe_objectAtIndexedSubscript:(NSInteger)index{
    
    if (index >= self.count || index < 0) {
        NSLog(@"__NSArrayM 取可变数组时越界 objectAtIndexedSubscript , 崩溃") ;
        return nil;
    }
    return [self mutableArray_safe_objectAtIndexedSubscript:index];
    
}


- (id)safeObjectIndex:(NSInteger)index{
    
    if (index >= self.count || index < 0) {
        NSLog(@"__NSArrayM 取可变数组时越界 objectAtIndex , 崩溃") ;
        return nil;
    }
    return [self safeObjectIndex:index];
    
}



- (void)safeInsertObject:(id)object atIndex:(NSUInteger)index{
    
    if (index>self.count) {
        NSLog(@"__NSArrayM 添加元素越界 insertObject:atIndex: , 崩溃") ;
        return ;
    }
    if (object == nil) {
        NSLog(@"__NSArrayM 添加空元素 insertObject:atIndex: , 崩溃") ;
        return ;
    }
    
    [self safeInsertObject:object atIndex:index];
    
}
- (void)safeAddObject:(id)object {
    
    if (object == nil) {
        NSLog(@"__NSArrayM 添加空元素 addObject , 崩溃") ;
        return ;
    }
    
    [self safeAddObject:object];
    
}
#endif
@end



@implementation NSDictionary (NilSafe)
#ifdef DEBUG
#else

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // NSDictionary 是一个类簇,具体有三个子类__NSDictionary0,__NSSingleEntryDictionaryI,__NSDictionaryI
        
        // @{@"3":@"3"} 这种是调用了类方法创建的 dictionaryWithObjects .
        [self gl_swizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(gl_initWithObjects:forKeys:count:)];
        [self gl_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) withMethod:@selector(gl_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)gl_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    // 一个c语言的数组,里面的元素是id指针
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)gl_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_initWithObjects:safeObjects forKeys:safeKeys count:j];
}
#endif

@end

@implementation NSMutableDictionary (NilSafe)
#ifdef DEBUG
#else

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class gl_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(gl_setObject:forKey:)];
        [class gl_swizzleMethod:@selector(setObject:forKeyedSubscript:) withMethod:@selector(gl_setObject:forKeyedSubscript:)];
    });
}

- (void)gl_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self gl_setObject:anObject forKey:aKey];
}

- (void)gl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key) {
        return;
    }
    if (!obj) {
        return;
    }
    [self gl_setObject:obj forKeyedSubscript:key];
}
#endif

@end
