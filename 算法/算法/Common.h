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

using namespace std;

typedef struct Tree {
    int value;
    struct Tree *left, *right;
} Tree;

void createTree(Tree **root, int *arr, int* i, int size);

#endif /* Common_h */
