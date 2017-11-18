//
//  Common.h
//  算法
//
//  Created by qinmin on 2017/10/18.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#ifndef Common_h
#define Common_h

#import <Foundation/Foundation.h>
#import <iostream>
#import <vector>
#import <string>
#import <map>
#import <unordered_map>
#import <list>
#import <stack>
#import <queue>
#import <deque>

using namespace std;


/**
 二叉树的定义
 */
typedef struct Tree {
    int value;
    struct Tree *left, *right;
} Tree;


/**
 以先序遍历的方式构造二叉树

 @param root 二叉树根节点
 @param arr 二叉树节点数组，空节点的值为-1
 @param i 节点数组当前的索引
 @param size 节点数组的大小
 */
void createTree(Tree **root, int *arr, int* i, int size);

#endif /* Common_h */
