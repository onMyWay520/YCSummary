//
//  YCRunTimeModel.h
//  YCSummary
//
//  Created by wuyongchao on 2018/11/21.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCRunTimeModel : NSObject
#pragma mark - 归档和解档
-(void)encodeAndDecode;
#pragma mark - 字典转模型
-(void)modelWithDict;
#pragma mark - 获取所有的方法
-(void)getAllMethod;
#pragma mark - 消息转发机制
-(void)messageLearn;
#pragma mark - 数组异常处理
-(void)ArrayAbnormal:(NSArray *)array;
#pragma mark - 增加属性
-(void)addProperty;
-(void)showKVO;
-(void)showNotification;
@end

NS_ASSUME_NONNULL_END
