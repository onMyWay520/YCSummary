//
//  YCArchieveModel.h
//  YCSummary
//
//  Created by wuyongchao on 2018/11/21.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCArchieveModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *age;
@property (nonatomic, copy) NSNumber *height;

@end

NS_ASSUME_NONNULL_END
