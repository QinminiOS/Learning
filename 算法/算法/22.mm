//
//  22.m
//  算法
//
//  Created by qinmin on 2017/10/23.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"

/**
 输入一棵二叉树和一个整数， 打印出二叉树中结点值的和为输入整数的所有路径。从树的根结点开始往下一直到叶结点所经过的结点形成一条路径。递归调用的本质就是一个压栈和出栈的过程。
 */

void preOder(Tree *root, int sum, int value, list<Tree *>list)
{
    if (!root) {
        return;
    }else {
        sum = sum + root->value;
        list.push_back(root);
        
        if (sum < value) {
            preOder(root->left, sum, value, list);
            preOder(root->right, sum, value, list);
        }else if (sum == value) {
            if (root->left == NULL && root->right == NULL) {
                for (const auto &t : list) {
                    printf("%d ", t->value);
                }
                printf("\n");
            }
        }
        
        list.pop_back();
    }
}

void findPath(Tree *root, int value)
{
    list<Tree *> list;
    preOder(root, 0, 8, list);
}

//int main(int argc, const char * argv[])
//{
//    Tree *root;
//    int i = 0;
//    int a[] = {1,2,4,-1,-1,5,-1,-1,3,4,-1,-1,7,-1,-1};
//    createTree(&root, a, &i, sizeof(a)/sizeof(*a));
//    
//    findPath(root, 8);
//    
//    return 0;
//}

