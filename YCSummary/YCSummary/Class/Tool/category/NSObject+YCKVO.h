//
//  NSObject+YCKVO.h
//  runtime
//
//  Created by wuyongchao on 2018/9/19.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSObject (YCKVO)
#pragma mark - 注册监听者KVO
-(void)yc_addObserverBlockForKeyPath:(NSString*)keyPath block:(void (^)(id obj, id oldVale, id newVale))block;
- (void)yc_addNotificationForName:(NSString *)name block:(void (^)(NSNotification *notification))block;
- (void)yc_postNotificationWithName:(NSString *)name userInfo:(NSDictionary *)userInfo;
NS_ASSUME_NONNULL_END
@end
