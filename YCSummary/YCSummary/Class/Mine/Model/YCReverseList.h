//
//  YCReverseList.h
//  YCSummary
//
//  Created by wuyongchao on 2019/1/22.
//  Copyright © 2019年 YC科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 定义一个链表
struct Node {
    int data;
    struct Node *next;
};
@interface YCReverseList : NSObject
// 链表反转
struct Node* reverseList(struct Node *head);
// 构造一个链表
struct Node* constructList(void);
// 打印链表中的数据
void printList(struct Node *head);
@end

NS_ASSUME_NONNULL_END
