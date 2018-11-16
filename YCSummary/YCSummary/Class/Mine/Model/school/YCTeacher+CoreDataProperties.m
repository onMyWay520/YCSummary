//
//  YCTeacher+CoreDataProperties.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/13.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//
//

#import "YCTeacher+CoreDataProperties.h"

@implementation YCTeacher (CoreDataProperties)

+ (NSFetchRequest<YCTeacher *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"YCTeacher"];
}

@dynamic name;
@dynamic subject;
@dynamic students;

@end
