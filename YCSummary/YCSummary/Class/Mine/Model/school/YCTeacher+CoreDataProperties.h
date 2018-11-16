//
//  YCTeacher+CoreDataProperties.h
//  YCSummary
//
//  Created by wuyongchao on 2018/11/13.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//
//

#import "YCTeacher+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface YCTeacher (CoreDataProperties)

+ (NSFetchRequest<YCTeacher *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *subject;
@property (nullable, nonatomic, retain) YCStudent *students;

@end

NS_ASSUME_NONNULL_END
