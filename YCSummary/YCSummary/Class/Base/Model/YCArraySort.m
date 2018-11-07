//
//  YCArraySort.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/7.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCArraySort.h"
#include <stdio.h>
@implementation YCArraySort
// 冒泡排序
// 最佳情况 o(n)
// 最差情况 o(n2)
// 平均情况 o(n2)
// 空间复杂度 o(1)
#pragma mark - 冒泡排序
+ (NSMutableArray *)bubbleSort:(NSArray *)array {
    if (!([array isKindOfClass:[NSArray class]] && [array count] > 0)) {
        return nil;
    }
    NSMutableArray *finalArray = [[NSMutableArray alloc] initWithArray:array];
//    for (NSInteger i = 0; i < [finalArray count]-1; i++) {
//        for (NSInteger j = 0; j < [finalArray count] - i - 1; j++) {
//
//           if ([finalArray[j+1] intValue] < [finalArray[j] intValue]) { //升序排列
                //方法1
//              // [finalArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
//               方法2.中间变量替换
//                id temp = finalArray[j];
//                finalArray[j] = finalArray[j+1];
//                finalArray[j+1] = temp;
//            }
//        }
//    }
    //优化后算法-从第一个开始排序，空间复杂度相对更大一点
//    for (int i = 0; i < finalArray.count; ++i) {
//        bool flag=false;
//        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
//        for (int j = 0; j < finalArray.count-1-i; ++j) {
//            //根据索引的`相邻两位`进行`比较`
//            if ([finalArray[j+1] intValue] < [finalArray[j] intValue]) {
//                flag = true;
//                [finalArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
//            }
//        }
//        if (!flag) {
//            break;//没发生交换直接退出，说明是有序数组
//        }
//    }
    //优化后算法-从最后一个开始排序
    for (int i = 0; i <finalArray.count; ++i) {
        bool flag=false;
        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
        for (int j = (int)finalArray.count-1; j >i; --j) {
            
            //根据索引的`相邻两位`进行`比较`
            if ([finalArray[j-1] intValue] > [finalArray[j] intValue]) {
                flag = true;
                [finalArray exchangeObjectAtIndex:j withObjectAtIndex:j-1];
            }
        }
        if (!flag) {
            break;//没发生交换直接退出，说明是有序数组
        }
    }
    return finalArray;
}
// 选择排序
// 最佳情况 o(n2)
// 最差情况 o(n2)
// 平均情况 o(n2)
// 空间复杂度 o(1)
#pragma mark - 选择排序
+ (NSMutableArray *)selectSort:(NSArray *)array {
    if (!([array isKindOfClass:[NSArray class]] && [array count] > 0)) {
        return nil;
    }
    NSMutableArray *finalArray = [[NSMutableArray alloc] initWithArray:array];
    NSInteger minIndex = 0;
    for (NSInteger i = 0; i < [finalArray count] - 1; i++) {
        minIndex = i;
        for (NSInteger j = i + 1; j < [finalArray count]; j++) {
            if ([finalArray[j] integerValue] < [finalArray[minIndex] integerValue]) {
                minIndex = j;
            }
        }
        [finalArray exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
//        id temp = finalArray[i];
//        finalArray[i] = finalArray[minIndex];
//        finalArray[minIndex] = temp;
    }
    return finalArray;
}
// 插入排序
// 最佳情况 o(n)
// 最差情况 o(n2)
// 平均情况 o(n2)
// 空间复杂度 o(1)
#pragma mark - 插入排序
+ (NSMutableArray *)insertSort:(NSArray *)array {
    if (!([array isKindOfClass:[NSArray class]] && [array count] > 0)) {
        return nil;
    }
    NSMutableArray *finalArray = [[NSMutableArray alloc] initWithArray:array];
    for (NSInteger i = 1; i < [finalArray count]; i++) {
        NSInteger j = i - 1;
        id guard = finalArray[i];
        while (j >= 0 && [finalArray[j] integerValue]> [guard integerValue]) {
            finalArray[j + 1] = finalArray[j];
            j--;
        }
        finalArray[j + 1] = guard;
    }
    
    return finalArray;
}
// 快速排序
// 最佳情况 o(nlogn)
// 最差情况 o(n2) n的平方
// 平均情况 o(nlogn)
// 空间复杂度 o(logn)
#pragma mark - 快速排序
+ (NSMutableArray *)quickSort:(NSMutableArray *)array {
    if (!([array isKindOfClass:[NSMutableArray class]] && [array count] > 0)) {
        return [[NSMutableArray alloc] init];
    }
    if ([array count] < 2) {
        return array;
    }
    NSMutableArray *left = [[NSMutableArray alloc] init];
    NSMutableArray *right = [[NSMutableArray alloc] init];
    NSInteger middle = ceilf([array count] / 2.0f);
    id middleVal = array[middle];
    [array removeObjectAtIndex:middle];
    for (NSInteger i = 0; i < [array count]; i++) {
        if ([middleVal integerValue] > [array[i] integerValue]) {
            [left addObject:array[i]];
        }
        else {
            [right addObject:array[i]];
        }
    }
    left = [self quickSort:left];
    right = [self quickSort:right];
    NSMutableArray *leftArr = [[NSMutableArray alloc] initWithArray:[left arrayByAddingObject:middleVal]];
    NSMutableArray *rightArr = [[NSMutableArray alloc] initWithArray:[leftArr arrayByAddingObjectsFromArray:right]];
    return rightArr;
}
// 归并排序，时间复杂度计算可抽象为二叉树，每层n个节点，每层计算量为o(n)，深度为logn
// 最佳情况 o(nlogn)
// 最差情况 o(nlogn)
// 平均情况 o(nlogn)
// 空间复杂度 o(n)
#pragma mark - 归并排序
+ (NSMutableArray *)mergeSort:(NSMutableArray *)array {
    if (!([array isKindOfClass:[NSMutableArray class]] && [array count] > 0)) {
        return nil;
    }
    if ([array count] < 2) {
        return array;
    }
    NSMutableArray *finalArray = array;
    NSInteger middle = ceilf([array count] / 2.0f);
    NSMutableArray *left = [[NSMutableArray alloc] initWithArray:[finalArray subarrayWithRange:NSMakeRange(0, middle)]];
    NSMutableArray *right = [[NSMutableArray alloc] initWithArray:[finalArray subarrayWithRange:NSMakeRange(middle, [array count] - middle)]];
    return [self merge:[self mergeSort:left] rightArray:[self mergeSort:right]];
}
+ (NSMutableArray *)merge:(NSMutableArray *)left rightArray:(NSMutableArray *)right {
    if (!([left isKindOfClass:[NSArray class]] && [right isKindOfClass:[NSArray class]] &&
          [left count] > 0 && [right count] > 0)) {
        return nil;
    }
    NSMutableArray *result = [[NSMutableArray alloc] init];
    while ([left count] > 0 && [right count] > 0) {
        if ([left[0] integerValue] > [right[0] integerValue]) {
            [result addObject:right[0]];
            [right removeObjectAtIndex:0];
        }
        else{
            [result addObject:left[0]];
            [left removeObjectAtIndex:0];
        }
    }
    while ([left count]) {
        [result addObject:left[0]];
        [left removeObjectAtIndex:0];
    }
    while ([right count]) {
        [result addObject:right[0]];
        [right removeObjectAtIndex:0];
    }
    return result;
}
#pragma mark - 堆排序
+(NSMutableArray *)heapSort:(NSMutableArray *)ascendingArr{
    NSInteger endIndex = ascendingArr.count - 1;
    ascendingArr = [self heapCreate:ascendingArr];
    while (endIndex >= 0) {
        NSNumber *temp = ascendingArr[0];
        ascendingArr[0] = ascendingArr[endIndex];
        ascendingArr[endIndex] = temp;
        endIndex -= 1;
        ascendingArr = [self heapAdjast:ascendingArr withStartIndex:0 withEndIndex:endIndex + 1];
    }
    return ascendingArr;
}
+(NSMutableArray *)heapCreate:(NSMutableArray *)array{
    NSInteger i = array.count;
    while (i > 0) {
        array = [self heapAdjast:array withStartIndex:i - 1 withEndIndex:array.count];
        i -= 1;
    }
    return array;
}
+(NSMutableArray *)heapAdjast:(NSMutableArray *)items withStartIndex:(NSInteger)startIndex withEndIndex:(NSInteger)endIndex{
    NSNumber *temp = items[startIndex];
    NSInteger fatherIndex = startIndex + 1;
    NSInteger maxChildIndex = 2 * fatherIndex;
    while (maxChildIndex <= endIndex) {
        if (maxChildIndex < endIndex && [items[maxChildIndex - 1] floatValue] < [items[maxChildIndex] floatValue]) {
            maxChildIndex++;
        }
        if ([temp floatValue] < [items[maxChildIndex - 1] floatValue]) {
            items[fatherIndex - 1] = items[maxChildIndex - 1];
        }
        else{
            break;
        }
        fatherIndex = maxChildIndex;
        maxChildIndex = fatherIndex * 2;
    }
    items[fatherIndex - 1] = temp;
    return items;
}
#pragma mark - 希尔排序
+(NSMutableArray *)shellArray:(NSMutableArray *)array{
    int dk = (int)(array.count-1)/2;
    while (dk>=1) {
        [self shellSortingWithArray:array startIndex:dk];
        dk = dk/2;
    }
    return array;
}
+(NSMutableArray *)shellSortingWithArray:(NSMutableArray *)array startIndex:(int)dk{
    for (int i = dk; i<=array.count-1; i+=dk) {
        if (array[i]<array[i-dk]) {
            int j = i-dk;
            id temp = array[i];
            array[i] = array[i - dk];
            while (j>=0&&temp<array[j]) {
                array[j+dk] = array[j];
                j-=dk;
            }
            array[j+dk] = temp;
        }
    }
   return array;
}
@end
