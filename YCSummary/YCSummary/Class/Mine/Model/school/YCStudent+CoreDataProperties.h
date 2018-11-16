//
//  YCStudent+CoreDataProperties.h
//  YCSummary
//
//  Created by wuyongchao on 2018/11/13.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//
//

#import "YCStudent+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface YCStudent (CoreDataProperties)

+ (NSFetchRequest<YCStudent *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) YCTeacher *teacher;

@end

NS_ASSUME_NONNULL_END
