//
//  NSObject+hook.h
//  runtime
//
//  Created by wuyongchao on 2018/5/28.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (hook)
@property(nonatomic,copy)NSString *name;
/* 获取对象的所有属性 */
+ (NSArray *)yc_objcProperties;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
/* 获取对象的所有方法 */
+(NSArray *)getAllMethods;
/*获取协议列表*/
+(NSArray *)getProtocolList;
/*获取类名*/
+(NSString *)getClassName;
/*获取成员变量*/
+(NSArray *)getIvarList;
@end
