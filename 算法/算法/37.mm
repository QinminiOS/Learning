//
//  37.m
//  算法
//
//  Created by qinmin on 2017/11/16.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"

/**
 输入一棵二叉树的根结点，判断该树是不是平衡二叉树。如果某二叉树中任意结点的左右子树的深度相差不超过1 ，那么它就是一棵平衡二叉树。
 */

//////////////////////////// 解法一 ////////////////////////////////////////
//int deppTree(Tree *root, bool *isBalance)
//{
//    if (root == nullptr) {
//        return 0;
//    }
//
//    int left = deppTree(root->left, isBalance);
//    int right = deppTree(root->right, isBalance);
//
//    if (left - right > 1 || left - right < -1) {
//        *isBalance = false;
//    }
//
//    return (left > right ? left : right) + 1;
//}

//bool isBalanceTree(Tree *root)
//{
//    bool isBalance = true;
//    deppTree(root, &isBalance);
//    return isBalance;
//}

//////////////////////////// 解法二 ////////////////////////////////////////
bool balanceTreeVisit(Tree *root, int* deep)
{
    if (root == nullptr) {
        *deep = 0;
        return true;
    }

    int left, right;
    if (balanceTreeVisit(root->left, &left) && balanceTreeVisit(root->right, &right)) {
        if (left - right <= 1 && left - right >= -1) {
            *deep = (left > right ? left : right ) + 1;
            return true;
        }
    }
    
    return false;
}

bool isBalanceTree(Tree *root)
{
    int deep;
    return balanceTreeVisit(root, &deep);
}

//     1
//  2     3
//4  5  6  7
//
//int main(int argc, const char * argv[])
//{
//    Tree *root;
//    int i = 0;
//    int a[] = {1, 2, 4, -1, -1, 5, -1, -1, 3, 6, -1, -1, 7, -1, -1};
////    int a[] = {1, 2, 4, -1, -1, 5, -1, -1, -1};
//    createTree(&root, a, &i, sizeof(a)/sizeof(*a));
//
//     cout<< isBalanceTree(root) << endl;
//
//    return 0;
//}

