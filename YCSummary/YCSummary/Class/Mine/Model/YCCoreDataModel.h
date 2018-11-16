//
//  YCCoreDataModel.h
//  YCSummary
//
//  Created by wuyongchao on 2018/11/16.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCCoreDataModel : NSObject
@property (nonatomic, strong) NSManagedObjectContext *schoolMOC;
#pragma mark - 增加数据库操作
-(void)addschool;
#pragma mark - 查询数据库操作
-(void)searchSchool;
#pragma mark - 更新数据库操作
-(void)updateSchool;
#pragma mark - 删除数据库操作
-(void)deleteSchool;
@end

NS_ASSUME_NONNULL_END
