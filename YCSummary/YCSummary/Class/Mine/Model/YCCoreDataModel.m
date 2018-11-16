//
//  YCCoreDataModel.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/16.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCCoreDataModel.h"
#import <CoreData/CoreData.h>
#import "YCStudent+CoreDataClass.h"
#import "YCTeacher+CoreDataClass.h"
@implementation YCCoreDataModel
/**
 创建上下文对象
 */
-(NSManagedObjectContext *)contextWithModelName:(NSString *)modelName{
    //创建上下文对象，并发队列设置为主队列
    NSManagedObjectContext *context=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    NSURL *modelPath=[[NSBundle mainBundle]URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model=[[NSManagedObjectModel alloc]initWithContentsOfURL:modelPath];
    //创建持久化存储协调器
    NSPersistentStoreCoordinator *coordinate=[[NSPersistentStoreCoordinator alloc ]initWithManagedObjectModel:model];
    NSString *dataPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", modelName];
    [coordinate addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    // 上下文对象设置属性为持久化存储器
    context.persistentStoreCoordinator=coordinate;
    return context;
}
-(NSManagedObjectContext *)schoolMOC{
    if (!_schoolMOC) {
        _schoolMOC=[self contextWithModelName:@"YCSchool"];
    }
    return _schoolMOC;
}
#pragma mark - 增加数据库操作
-(void)addschool{
    YCStudent *student=[NSEntityDescription insertNewObjectForEntityForName:@"YCStudent" inManagedObjectContext:self.schoolMOC];
    student.name=@"xiaowang";
    student.age=16;
    NSError *error=nil;
    if (self.schoolMOC.hasChanges) {
        [self.schoolMOC save:&error];
    }
    if (error) {
        DebugLog(@"error==%@",error);
    }
}
#pragma mark - 查询数据库操作
-(void)searchSchool{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"YCStudent"];
    NSError *error=nil;
    NSArray<YCStudent *>*students=[self.schoolMOC executeFetchRequest:request error:&error];
    [students enumerateObjectsUsingBlock:^(YCStudent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DebugLog(@"student name==%@ age==%d",obj.name,obj.age);
    }];
}
#pragma mark - 更新数据库操作
-(void)updateSchool{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"YCStudent"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"name=%@",@"xiaowang"];
    request.predicate=predicate;
    NSError *error=nil;
    NSArray<YCStudent *>*students=[self.schoolMOC executeFetchRequest:request error:&error];
    [students enumerateObjectsUsingBlock:^(YCStudent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.age=18;
    }];
    //存储修改的内容
    if (self.schoolMOC.hasChanges) {
        [self.schoolMOC save:nil];
    }
    if (error) {
        DebugLog(@"uodate error===%@",error);
    }
}
#pragma mark - 删除数据库操作
-(void)deleteSchool{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"YCStudent"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"name=%@",@"xiaowang"];
    request.predicate=predicate;
    NSError *error=nil;
    NSArray<YCStudent *>*students=[self.schoolMOC executeFetchRequest:request error:&error];
    [students enumerateObjectsUsingBlock:^(YCStudent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.schoolMOC deleteObject:obj];
    }];
    //存储修改的内容
    if (self.schoolMOC.hasChanges) {
        [self.schoolMOC save:nil];
    }
    if (error) {
        DebugLog(@"detele error===%@",error);
    }
}
@end
