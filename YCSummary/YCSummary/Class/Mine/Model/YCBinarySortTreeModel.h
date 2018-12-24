//
//  YCYCBinarySortTreeModel.h
//  YCSummary
//
//  Created by wuyongchao on 2018/12/22.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCBinarySortTreeModel : NSObject
/*
 * 左孩子
 */
@property (nonatomic, strong) YCBinarySortTreeModel *leftNode;
/*
 * 右孩子
 */
@property (nonatomic, strong) YCBinarySortTreeModel *rightNode;
/*
 * 节点值
 */
@property (nonatomic, assign) NSInteger value;

/**
 * desc: 二叉排序树的创建，每次都要从顶部元素开始遍历，小于其的放在左边，大于的放在右边
 *
 * params：根结点，node的值
 *
 */
+ (YCBinarySortTreeModel *)binarySortTreeCreate:(NSArray *)tree;

/**
 * desc: 先序遍历
 *
 * params: 根结点，压栈操作的block
 *
 */
+ (void)preOrderTraverseTree:(YCBinarySortTreeModel *)root handler:(void(^)(YCBinarySortTreeModel *node))handler;

/**
 * desc: 中序遍历
 *
 * params: 根结点，压栈操作的block
 *
 */
+ (void)inOrderTraverseTree:(YCBinarySortTreeModel *)root handler:(void(^)(YCBinarySortTreeModel *node))handler;

/**
 * desc: 后序遍历
 *
 * params: 根结点，压栈操作的block
 *
 */
+ (void)postOrderTraverseTree:(YCBinarySortTreeModel *)root handler:(void(^)(YCBinarySortTreeModel *node))handler;

/**
 * desc: 层次遍历（广度优先）
 *
 * params: 根结点，压栈操作的block
 *
 */
+ (void)levelTraverseTree:(YCBinarySortTreeModel *)root handler:(void(^)(YCBinarySortTreeModel *node))handler;

/**
 * desc: 返回二叉树的深度
 *
 * params: root 跟节点
 *
 */
+ (NSInteger)depthOfTree:(YCBinarySortTreeModel *)root;

/**
 * desc: 返回二叉树的宽度
 *
 * params: root 跟节点
 *
 */
+ (NSInteger)widthOfTree:(YCBinarySortTreeModel *)root;

/**
 * desc: 返回二叉树的全部节点数
 *
 * params: root 跟节点
 *
 */
+ (NSInteger)numbersOfNodesInTree:(YCBinarySortTreeModel *)root;

/**
 * desc: 返回二叉树的叶子节点
 *
 * params: root 跟节点
 *
 */
+ (NSInteger)numbersOfLeafsInTree:(YCBinarySortTreeModel *)root;

/**
 * desc: 返回二叉树中某个节点到跟节点的路径
 *
 * params: root 跟节点，node 指定节点
 *
 */
+ (NSMutableArray *)pathOfNodeInTree:(YCBinarySortTreeModel *)root searchNode:(YCBinarySortTreeModel *)node;

/**
 * desc: 二叉树中两个节点最近的公共父节点
 *
 * params: root 跟节点，nodeA/nodeB 两节点
 *
 */
+ (YCBinarySortTreeModel *)publicNodeOfTwoNodesIntree:(YCBinarySortTreeModel *)root nodeA:(YCBinarySortTreeModel *)nodeA nodeB:(YCBinarySortTreeModel *)nodeB;

/**
 * desc: 二叉树两个节点之间的距离
 *
 * params: root 跟节点，nodeA/nodeB 两节点
 *
 */
+ (NSInteger)distanceOfTwoNodesInTree:(YCBinarySortTreeModel *)root nodeA:(YCBinarySortTreeModel *)nodeA nodeB:(YCBinarySortTreeModel *)nodeB;

/**
 * desc: 翻转二叉树
 *
 * params: root 跟节点
 *
 */
+ (YCBinarySortTreeModel *)invertBinaryTree:(YCBinarySortTreeModel *)root;

/**
 * desc: 判断二叉树是否完全二叉树
 *
 * params: root 跟节点
 *
 */
+ (BOOL)isCompleteBinaryTree:(YCBinarySortTreeModel *)root;

/**
 * desc: 判断二叉树是否满二叉树
 *
 * params: root 跟节点
 *
 */
+ (BOOL)isFullBinaryTree:(YCBinarySortTreeModel *)root;

/**
 * desc: 判断二叉树是否平衡二叉树
 *
 * params: root 跟节点
 *
 */
+ (BOOL)isAVLBinaryTree:(YCBinarySortTreeModel *)root;

/**
 * desc: 返回二叉树第i层节点数
 *
 * params: root 跟节点，level 层级
 *
 */
+ (NSInteger)numbersOfLevelInTree:(YCBinarySortTreeModel *)root level:(NSInteger)level;

/**
 * desc: 二叉排序树插入节点
 *
 * params：根结点，插入的值
 *
 */
+ (YCBinarySortTreeModel *)insertNodeToTree:(YCBinarySortTreeModel *)root nodeValue:(NSInteger)value;

/**
 * desc: 删除排序二叉树中的节点，三种情况：1.删除节点是叶子结点，2.删除节点只有左/右子树，3.删除节点左右子树都有
 *
 * params：根结点，插入的值
 *
 */
+ (void)deleteNodeInTree:(YCBinarySortTreeModel *)root deleteNode:(NSInteger)value;

/**
 * desc: 判断一棵树是否是二叉搜索树，二叉搜索树特点：父节点的值大于所有左子树的值，小于所有右子树的值，前提是假设所有值没有相同的
 *
 * params：根结点，插入的值
 *
 */
+ (BOOL)isBinarySearchTree:(YCBinarySortTreeModel *)root;

/**
 * desc: 判断一棵树是否是另一棵树的子树
 *
 * params：root 父树根节点，childNode 子树根节点
 *
 */
+ (BOOL)isContainTree:(YCBinarySortTreeModel *)root childNode:(YCBinarySortTreeModel *)childNode;

/**
 * desc: 找出一棵二叉树中所有路径，并且其路径之和等于一个给定的值
 *
 * params: root 根节点，path 暂时存储路径的数组，vector 返回最终符合要求的数组，sum 给定值
 */
+ (void)findAllPathInTree:(YCBinarySortTreeModel *)root pathArray:(NSMutableArray *)path vectore:(NSMutableArray *)vectore sum:(NSInteger)sum;

/**
 * desc: 找出二叉树中一个节点的后继
 *
 * params: root 根节点，node 目标节点
 */
+ (YCBinarySortTreeModel *)findSuccessor:(YCBinarySortTreeModel *)root searchNode:(YCBinarySortTreeModel *)node;

/**
 * desc: 找出二叉树中一个节点的前驱
 *
 * params: root 根节点，node 目标节点
 */
+ (YCBinarySortTreeModel *)findPrecursor:(YCBinarySortTreeModel *)root searchNode:(YCBinarySortTreeModel *)node;

/**
 * desc: 序列化二叉树
 *
 * params: root 根节点
 */
+ (NSString *)serializeBinaryTree:(YCBinarySortTreeModel *)root;

/**
 * desc: 反序列化二叉树
 *
 * params: root 根节点
 */
+ (YCBinarySortTreeModel *)deserializeBinaryTree:(NSString *)serialString;
@end

NS_ASSUME_NONNULL_END
