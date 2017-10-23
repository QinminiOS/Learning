//
//  04.m
//  算法
//
//  Created by qinmin on 2017/10/18.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <stdio.h>
#import <stdlib.h>

/**
*   输入某二叉树的前序遍历和中序遍历的结果，请重建出该二叉树。假设输入的前序遍历和中序遍历的结果中都不含重复的数字。例如：前序遍历序列｛ 1, 2, 4, 7, 3, 5, 6, 8｝和中序遍历序列｛4, 7, 2, 1, 5, 3, 8，6}，重建二叉树并输出它的头结点。
*/


typedef struct TreeNode {
    struct TreeNode *left;
    int value;
    struct TreeNode *right;
}TreeNode;


void preTree(TreeNode *root)
{
    if (!root) {
        return;
    }
    
    printf("%d ", root->value);
    preTree(root->left);
    preTree(root->right);
}

void inTree(TreeNode *root)
{
    if (!root) {
        return;
    }
    
    inTree(root->left);
    printf("%d ", root->value);
    inTree(root->right);
}

void postTree(TreeNode *root)
{
    if (!root) {
        return;
    }

    postTree(root->left);
    postTree(root->right);
    printf("%d ", root->value);
}

void recreateTree(TreeNode **root, int preOrder[], int pLen, int inOrder[], int inLen)
{
    *root = (TreeNode *)malloc(sizeof(TreeNode));
    (*root)->value = preOrder[0];
    (*root)->left = NULL;
    (*root)->right = NULL;
    
    if (pLen <= 1) {
        return;
    }else {
        int rootIndex = 0;
        for (int i = 0 ; i < inLen; i++) {
            if (inOrder[i] == (*root)->value) {
                rootIndex = i;
                break;
            }
        }
        
        int leftLen = rootIndex;
        int rightLen = inLen - leftLen - 1;
        
        if (leftLen > 0) {
            recreateTree(&(*root)->left, preOrder+1, leftLen, inOrder, leftLen);
        }
        
        if (rightLen > 0) {
            recreateTree(&(*root)->right, preOrder+1+leftLen, rightLen, inOrder+leftLen+1, rightLen);
        }
    }
}

//int main(int argc, const char * argv[])
//{
//    int preOrder[] = {1, 2, 4, 7, 3, 5, 6, 8};
//    int inOrder[] = {4, 7, 2, 1, 5, 3, 8, 6};
//    
////            1
////        2       3
////     4       5     6
////       7         8
//    
//    TreeNode *root;
//    recreateTree(&root, preOrder, sizeof(preOrder)/sizeof(preOrder[0]), inOrder, sizeof(inOrder)/sizeof(inOrder[0]));
//    inTree(root);
//    printf("\n");
//    
//    return 0;
//}
 
