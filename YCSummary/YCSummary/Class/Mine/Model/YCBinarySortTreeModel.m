//
//  YCBinarySortTreeModel.m
//  YCSummary
//
//  Created by wuyongchao on 2018/12/22.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCBinarySortTreeModel.h"
static NSMutableArray *serialString;
static int serialCount;
/*二叉排序树或者是一棵空树，或者是具有下列性质的二叉树：
 （1）若左子树不空，则左子树上所有结点的值均小于它的根结点的值；
 （2）若右子树不空，则右子树上所有结点的值均大于它的根结点的值；
 （3）左、右子树也分别为二叉排序树；
 （4）没有键值相等的节点。*/
@interface YCBinarySortTreeModel ()

@property (nonatomic, assign) NSInteger nodeIndex;

@end
@implementation YCBinarySortTreeModel

// 二叉排序树的创建
+ (YCBinarySortTreeModel *)binarySortTreeCreate:(NSArray *)tree {
    if (!([tree isKindOfClass:[NSArray class]] && [tree count] > 0)) {
        return nil;
    }
    
    YCBinarySortTreeModel *root = nil;
    for (NSInteger i = 0; i < [tree count]; i++) {
        root = [self insertNodeToTree:root nodeValue:[[tree objectAtIndex:i] intValue]];
    }
    
    return root;
}

// 二叉排序树的创建
+ (YCBinarySortTreeModel *)insertNodeToTree:(YCBinarySortTreeModel *)root nodeValue:(NSInteger)value {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        root = [[YCBinarySortTreeModel alloc] init];
        root.value = value;
    }
    else if (root.value == value) {
        NSException *exception = [NSException
        exceptionWithName: @"不能构建二叉排序树"
        reason: @"由于有相同元素，从而不能构建二叉排序树"
        userInfo: nil];
        @throw exception;
    }
    else if (root.value > value) {
        root.leftNode = [self insertNodeToTree:root.leftNode nodeValue:value];
    }
    else if (root.value < value) {
        root.rightNode = [self insertNodeToTree:root.rightNode nodeValue:value];
    }
    
    return root;
}

// 先序遍历
+ (void)preOrderTraverseTree:(YCBinarySortTreeModel *)root handler:(void(^)(YCBinarySortTreeModel *node))handler {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return;
    }
    
    if (handler) {
        handler(root);
    }
    [self preOrderTraverseTree:root.leftNode handler:handler];
    [self preOrderTraverseTree:root.rightNode handler:handler];
}

// 中序遍历
+ (void)inOrderTraverseTree:(YCBinarySortTreeModel *)root handler:(void(^)(YCBinarySortTreeModel *node))handler {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return;
    }
    
    [self inOrderTraverseTree:root.leftNode handler:handler];
    if (handler) {
        handler(root);
    }
    [self inOrderTraverseTree:root.rightNode handler:handler];
}

// 后序遍历
+ (void)postOrderTraverseTree:(YCBinarySortTreeModel *)root handler:(void(^)(YCBinarySortTreeModel *node))handler {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return;
    }
    
    [self postOrderTraverseTree:root.leftNode handler:handler];
    [self postOrderTraverseTree:root.rightNode handler:handler];
    if (handler) {
        handler(root);
    }
}

// 层次遍历（广度优先）
+ (void)levelTraverseTree:(YCBinarySortTreeModel *)root handler:(void(^)(YCBinarySortTreeModel *node))handler {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return;
    }
    
    NSMutableArray *treeNode = [[NSMutableArray alloc] init];
    [treeNode addObject:root];
    
    while ([treeNode count] > 0) {
        YCBinarySortTreeModel *currentNode = [treeNode firstObject];
        if (handler) {
            handler(currentNode);
        }
        [treeNode removeObjectAtIndex:0];
        if (currentNode.leftNode) {
            [treeNode addObject:currentNode.leftNode];
        }
        if (currentNode.rightNode) {
            [treeNode addObject:currentNode.rightNode];
        }
    }
}

// 返回二叉树的深度
+ (NSInteger)depthOfTree:(YCBinarySortTreeModel *)root {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return 0;
    }
    
    if (nil == root.leftNode && nil == root.rightNode) {
        return 1;
    }
    
    NSInteger leftTreeDepth = [self depthOfTree:root.leftNode];
    NSInteger rightTreeDepth = [self depthOfTree:root.rightNode];
    return MAX(leftTreeDepth, rightTreeDepth) + 1;
}

// 返回二叉树的宽度
+ (NSInteger)widthOfTree:(YCBinarySortTreeModel *)root {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return 0;
    }
    
    NSInteger currentWidth = 0;
    NSInteger maxWidth = 1;
    NSMutableArray *treeNode = [[NSMutableArray alloc] init];
    [treeNode addObject:root];
    
    while ([treeNode count] > 0) {
        currentWidth = [treeNode count];
        for (NSInteger i = 0; i < currentWidth; i++) {
            YCBinarySortTreeModel *currentNode = [treeNode firstObject];
            if ([currentNode isKindOfClass:[YCBinarySortTreeModel class]]) {
                if (currentNode.leftNode) {
                    [treeNode addObject:currentNode.leftNode];
                }
                if (currentNode.rightNode) {
                    [treeNode addObject:currentNode.rightNode];
                }
            }
            [treeNode removeObjectAtIndex:0];
        }
        maxWidth = MAX(currentWidth, maxWidth);
    }
    return maxWidth;
}

// 返回二叉树的全部节点数
+ (NSInteger)numbersOfNodesInTree:(YCBinarySortTreeModel *)root {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return 0;
    }
    
    return [self numbersOfNodesInTree:root.leftNode] + [self numbersOfNodesInTree:root.rightNode] + 1;
}

// 返回二叉树的叶子节点
+ (NSInteger)numbersOfLeafsInTree:(YCBinarySortTreeModel *)root {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return 0;
    }
    
    if (nil == root.leftNode && nil == root.rightNode) {
        return 1;
    }
    
    return [self numbersOfLeafsInTree:root.leftNode] + [self numbersOfLeafsInTree:root.rightNode];
}

// 返回二叉树第i层节点数
+ (NSInteger)numbersOfLevelInTree:(YCBinarySortTreeModel *)root level:(NSInteger)level {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]]) || level < 1) {
        return 0;
    }
    
    if (level == 1) {
        return 1;
    }
    
    return [self numbersOfLevelInTree:root.leftNode level:(level - 1)] + [self numbersOfLevelInTree:root.rightNode level:(level - 1)];
}

// 返回二叉树中某个节点到跟节点的路径
+ (NSMutableArray *)pathOfNodeInTree:(YCBinarySortTreeModel *)root searchNode:(YCBinarySortTreeModel *)node {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return nil;
    }
    if (!(nil != node && [node isKindOfClass:[YCBinarySortTreeModel class]])) {
        return nil;
    }
    NSMutableArray *pathArray = [[NSMutableArray alloc] init];
    [self findNodeInTree:root searchNode:node pathArray:pathArray];
    
    return pathArray;
}

+ (BOOL)findNodeInTree:(YCBinarySortTreeModel *)root searchNode:(YCBinarySortTreeModel *)node pathArray:(NSMutableArray *)pathArray {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return NO;
    }
    if (!(nil != node && [node isKindOfClass:[YCBinarySortTreeModel class]])) {
        return NO;
    }
    if (root == node) {
        [pathArray addObject:root];
        return YES;
    }
    
    [pathArray addObject:root];
    
    BOOL hasFind = [self findNodeInTree:root.leftNode searchNode:node pathArray:pathArray];
    if (!hasFind) {
        hasFind = [self findNodeInTree:root.rightNode searchNode:node pathArray:pathArray];
    }
    if (!hasFind) {
        [pathArray removeLastObject];
    }
    
    return hasFind;
}

// 返回二叉树中某个节点到跟节点的路径的值
+ (NSMutableArray *)pathOfNodeValueInTree:(YCBinarySortTreeModel *)root searchNode:(YCBinarySortTreeModel *)node {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return nil;
    }
    if (!(nil != node && [node isKindOfClass:[YCBinarySortTreeModel class]])) {
        return nil;
    }
    NSMutableArray *pathArray = [[NSMutableArray alloc] init];
    [self findNodeValueInTree:root searchNode:node pathArray:pathArray];
    
    return pathArray;
}

+ (BOOL)findNodeValueInTree:(YCBinarySortTreeModel *)root searchNode:(YCBinarySortTreeModel *)node pathArray:(NSMutableArray *)pathArray {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return NO;
    }
    if (!(nil != node && [node isKindOfClass:[YCBinarySortTreeModel class]])) {
        return NO;
    }
    if (root == node) {
        [pathArray addObject:[NSNumber numberWithInteger:root.value]];
        return YES;
    }
    
    [pathArray addObject:[NSNumber numberWithInteger:root.value]];
    
    BOOL hasFind = [self findNodeValueInTree:root.leftNode searchNode:node pathArray:pathArray];
    if (!hasFind) {
        hasFind = [self findNodeValueInTree:root.rightNode searchNode:node pathArray:pathArray];
    }
    if (!hasFind) {
        [pathArray removeLastObject];
    }
    
    return hasFind;
}

// 二叉树中两个节点最近的公共父节点
+ (YCBinarySortTreeModel *)publicNodeOfTwoNodesIntree:(YCBinarySortTreeModel *)root nodeA:(YCBinarySortTreeModel *)nodeA nodeB:(YCBinarySortTreeModel *)nodeB {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]]) ||
        !(nil != nodeA && [nodeA isKindOfClass:[YCBinarySortTreeModel class]]) ||
        !(nil != nodeB && [nodeB isKindOfClass:[YCBinarySortTreeModel class]])) {
        return nil;
    }
    if (!(nil != nodeB && [nodeB isKindOfClass:[YCBinarySortTreeModel class]])) {
        return nil;
    }
    
    if (nodeA == nodeB) {
        return nodeA;
    }
    
    NSArray *pathA = [self pathOfNodeInTree:root searchNode:nodeA];
    NSArray *pathB = [self pathOfNodeInTree:root searchNode:nodeB];
    
    // 找公共节点，这里的比较可以优化
    for (NSInteger i = [pathA count] - 1; i >= 0; i--) {
        for (NSInteger j = [pathB count] - 1; j >= 0 ; j--) {
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                return (YCBinarySortTreeModel *)[pathA objectAtIndex:i];
            }
        }
    }
    
    return nil;
}

// 二叉树两个节点之间的距离
+ (NSInteger)distanceOfTwoNodesInTree:(YCBinarySortTreeModel *)root nodeA:(YCBinarySortTreeModel *)nodeA nodeB:(YCBinarySortTreeModel *)nodeB {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]]) ||
        !(nil != nodeA && [nodeA isKindOfClass:[YCBinarySortTreeModel class]]) ||
        !(nil != nodeB && [nodeB isKindOfClass:[YCBinarySortTreeModel class]])) {
        return -1;
    }
    if (!(nil != nodeB && [nodeB isKindOfClass:[YCBinarySortTreeModel class]])) {
        return -1;
    }
    
    NSMutableArray *pathArray = [[NSMutableArray alloc] init];
    if (nodeA == nodeB) {
        [pathArray addObject:nodeB];
        return 0;
    }
    
    NSArray *pathA = [self pathOfNodeValueInTree:root searchNode:nodeA];
    NSArray *pathB = [self pathOfNodeValueInTree:root searchNode:nodeB];
    // 这里的比较可以优化
    for (NSInteger i = [pathA count] - 1; i >= 0; i--) {
        for (NSInteger j = [pathB count] - 1; j >= 0 ; j--) {
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                return [pathA count] - i + [pathB count] - j - 2;
            }
        }
    }
    
    return -1;
}

// 翻转二叉树
+ (YCBinarySortTreeModel *)invertBinaryTree:(YCBinarySortTreeModel *)root {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return nil;
    }
    
    if (nil == root.leftNode && nil == root.rightNode) {
        return root;
    }
    
    [self invertBinaryTree:root.leftNode];
    [self invertBinaryTree:root.rightNode];
    
    YCBinarySortTreeModel *tempNode = root.leftNode;
    root.leftNode = root.rightNode;
    root.rightNode = tempNode;
    return root;
}

// 判断二叉树是否完全二叉树
+ (BOOL)isCompleteBinaryTree:(YCBinarySortTreeModel *)root {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return NO;
    }
    
    if (nil == root.leftNode && root.rightNode) {
        return NO;
    }
    
    if (nil == root.leftNode &&
        nil == root.rightNode) {
        return YES;
    }
    
    NSMutableArray *nodeArray = [[NSMutableArray alloc] init];
    [nodeArray addObject:root];
    
    BOOL isComplete = NO;
    while ([nodeArray count]) {
        YCBinarySortTreeModel *currentNode = [nodeArray firstObject];
        [nodeArray removeObjectAtIndex:0];
        if (!currentNode.leftNode && currentNode.rightNode) {
            return NO;
        }
        
        if (isComplete && (currentNode.leftNode || currentNode.rightNode)) {
            return NO;
        }
        
        if (nil == currentNode.rightNode) {
            isComplete = YES;
        }
        if (currentNode.leftNode) {
            [nodeArray addObject:currentNode.leftNode];
        }
        if (currentNode.rightNode) {
            [nodeArray addObject:currentNode.rightNode];
        }
    }
    return isComplete;
}


// 判断二叉树是否满二叉树
+ (BOOL)isFullBinaryTree:(YCBinarySortTreeModel *)root {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return NO;
    }
    
    NSInteger leafs = [self numbersOfLeafsInTree:root];
    NSInteger depth = [self depthOfTree:root];
    return leafs == pow(2, depth - 1);
}

// 判断二叉树是否平衡二叉树
+ (BOOL)isAVLBinaryTree:(YCBinarySortTreeModel *)root {
    static NSInteger height;
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        height = 0;
        return YES;
    }
    
    if (nil == root.leftNode && nil == root.rightNode) {
        height = 1;
        return YES;
    }
    
    [self isAVLBinaryTree:root.leftNode];
    NSInteger heightOfLeft = height;
    [self isAVLBinaryTree:root.rightNode];
    NSInteger heightOfRight = height;
    height = MAX(heightOfLeft, heightOfRight) + 1;
    
    if (heightOfLeft && heightOfRight && ABS(heightOfRight - heightOfLeft) <= 1) {
        return YES;
    }
    
    return NO;
}

// 删除排序二叉树中的节点
+ (void)deleteNodeInTree:(YCBinarySortTreeModel *)root deleteNode:(NSInteger)value {
    if (!(nil != root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        return;
    }
    
    YCBinarySortTreeModel *currentNode = root;
    YCBinarySortTreeModel *parentNode = root;
    BOOL isLeft = YES;
    while (currentNode.value != value) {
        parentNode = currentNode;
        
        if (currentNode.value > value) {
            isLeft = YES;
            currentNode = currentNode.leftNode;
        }
        else {
            isLeft = NO;
            currentNode = currentNode.rightNode;
        }
        
        if (nil == currentNode) {
            return;
        }
    }
    
    if (nil == currentNode.leftNode && nil == currentNode.rightNode) {
        if (currentNode == root) {
            root = nil;
        }
        else if (isLeft) {
            parentNode.leftNode = nil;
        }
        else {
            parentNode.rightNode = nil;
        }
    }
    else if (nil == currentNode.leftNode) {
        if (currentNode == root) {
            root = currentNode.rightNode;
        }
        else if (isLeft) {
            parentNode.leftNode = currentNode.rightNode;
        }
        else {
            parentNode.rightNode = currentNode.rightNode;
        }
    }
    else if (nil == currentNode.rightNode) {
        if (currentNode == root) {
            root = currentNode.leftNode;
        }
        else if (isLeft) {
            parentNode.leftNode = currentNode.leftNode;
        }
        else {
            parentNode.rightNode = currentNode.leftNode;
        }
    }
    else {
        YCBinarySortTreeModel *middle = [self getMiddleSortNode:currentNode];
        if (currentNode == root) {
            root = middle;
        }
        else if (isLeft) {
            parentNode.leftNode = middle;
        }
        else {
            parentNode.rightNode = middle;
        }
        middle.leftNode = currentNode.leftNode;
        NSLog(@"123");
    }
}

+ (YCBinarySortTreeModel *)getMiddleSortNode:(YCBinarySortTreeModel *)node {
    if (!(nil != node && [node isKindOfClass:[YCBinarySortTreeModel class]])) {
        return nil;
    }
    
    YCBinarySortTreeModel *middleNode = node;
    YCBinarySortTreeModel *parentNode = node;
    YCBinarySortTreeModel *currentNode = node.rightNode;
    
    while (nil != currentNode) {
        parentNode = middleNode;
        middleNode = currentNode;
        currentNode = currentNode.leftNode;
    }
    
    if (middleNode != node.rightNode) {
        parentNode.leftNode = middleNode.rightNode;
        middleNode.rightNode = node.rightNode;
    }
    
    return middleNode;
}

// 判断二叉树是否是二叉搜索树
+ (BOOL)isBinarySearchTree:(YCBinarySortTreeModel *)root {
    
    if (nil == root) {
        return YES;
    }
    
    if ((root.leftNode && root.value < root.leftNode.value) || (root.rightNode && root.value > root.rightNode.value)) {
        return NO;
    }
    [self isBinarySearchTree:root.leftNode];
    [self isBinarySearchTree:root.rightNode];
    
    return YES;
}

// 判断一棵树是否是另一棵树的子树
+ (BOOL)isContainTree:(YCBinarySortTreeModel *)root childNode:(YCBinarySortTreeModel *)childNode {
    if (nil == childNode) {
        return YES;
    }
    
    if (nil == root) {
        return NO;
    }
    
    if (root.value == childNode.value) {
        if ([self isMatch:root childNode:childNode]) {
            return YES;
        }
    }
    
    return [self isContainTree:root.leftNode childNode:childNode] || [self isContainTree:root.rightNode childNode:childNode];
}

+ (BOOL)isMatch:(YCBinarySortTreeModel *)root childNode:(YCBinarySortTreeModel *)childNode {
    if (nil == root && nil == childNode) {
        return YES;
    }
    if (nil == root || nil == childNode) {
        return NO;
    }
    if (root.value != childNode.value) {
        return NO;
    }
    return [self isMatch:root.leftNode childNode:childNode.leftNode] && [self isMatch:root.rightNode childNode:childNode.rightNode];
}

// 找出一棵二叉树中所有路径，并且其路径之和等于一个给定的值
+ (void)findAllPathInTree:(YCBinarySortTreeModel *)root pathArray:(NSMutableArray *)path vectore:(NSMutableArray *)vectore sum:(NSInteger)sum {
    if (nil == root) {
        return;
    }
    if (nil != root && nil == root.leftNode && nil == root.rightNode && sum - root.value > 0) {
        [path removeLastObject];
    }
    
    [path addObject:[NSNumber numberWithInteger:root.value]];
    if (sum == root.value) {
        [vectore addObject:[[NSMutableArray alloc] initWithArray:path]];
    }
    
    [self findAllPathInTree:root.leftNode pathArray:path vectore:vectore sum:(sum - root.value)];
    [self findAllPathInTree:root.rightNode pathArray:path vectore:vectore sum:(sum - root.value)];
}

// 中序遍历不带父链接的二叉树，找到给定节点的下一个节点，后继为比当前节点大的所有节点中值最小的那个
+ (YCBinarySortTreeModel *)findSuccessor:(YCBinarySortTreeModel *)root searchNode:(YCBinarySortTreeModel *)node {
    if (nil == root) {
        return nil;
    }
    
    if (nil != node.rightNode) {
        YCBinarySortTreeModel *left = node.rightNode;
        while (left.leftNode) {
            left = left.leftNode;
        }
        return left;
    }
    
    YCBinarySortTreeModel *parentNode = nil;
    while (root) {
        if (root.value > node.value) {
            parentNode = root;
            root = root.leftNode;
        }
        else {
            root = root.rightNode;
        }
    }
    
    return parentNode;
}

// 中序遍历不带父链接的二叉树，找到给定节点的上一个节点，后继为比当前节点小的所有节点中值最大的那个
+ (YCBinarySortTreeModel *)findPrecursor:(YCBinarySortTreeModel *)root searchNode:(YCBinarySortTreeModel *)node {
    if (nil == root) {
        return nil;
    }
    
    if (node.leftNode) {
        YCBinarySortTreeModel *right = node.leftNode;
        while (right.rightNode) {
            right = right.rightNode;
        }
        return right;
    }
    
    YCBinarySortTreeModel *parentNode = nil;
    while (root) {
        if (root.value >= node.value) {
            root = root.leftNode;
        }
        else {
            parentNode = root;
            root = root.rightNode;
        }
    }
    return parentNode;
}

+ (NSString *)serializeBinaryTree:(YCBinarySortTreeModel *)root {
    if (nil == serialString) {
        serialString = [[NSMutableArray alloc] init];
    }
    
    if (!(root && [root isKindOfClass:[YCBinarySortTreeModel class]])) {
        [serialString addObject:@"#"];
        return nil;
    }
    
    [serialString addObject:[NSString stringWithFormat:@"%d", (int)root.value]];
    [self serializeBinaryTree:root.leftNode];
    [self serializeBinaryTree:root.rightNode];
    
    return [serialString componentsJoinedByString:@","];
}

+ (YCBinarySortTreeModel *)deserializeBinaryTree:(NSString *)serialString {
    if (nil == serialString) {
        return nil;
    }
    
    YCBinarySortTreeModel *node;
    NSArray *array = [serialString componentsSeparatedByString:@","];
    if (![array[serialCount] isEqualToString:@"#"]) {
        node = [[YCBinarySortTreeModel alloc] init];
        node.value = [array[serialCount] intValue];
        serialCount++;
        node.leftNode = [self deserializeBinaryTree:serialString];
        node.rightNode = [self deserializeBinaryTree:serialString];
    }
    return node;
}

@end
