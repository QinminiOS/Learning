//
//  20.m
//  算法
//
//  Created by qinmin on 2017/10/23.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"

void createTree(Tree **root, int *arr, int* i, int size)
{
    if (arr[*i] == -1) {
        *i = *i + 1;
        return ;
    }else {
        *root = (Tree *)malloc(sizeof(Tree));
        (*root)->value = arr[*i];
        (*root)->left = NULL;
        (*root)->right = NULL;
        
        *i = *i + 1;
        createTree(&(*root)->left, arr, i, size);
        createTree(&(*root)->right, arr, i, size);
    }
}

/**
 从上往下打印出二叉树的每个结点，同一层的结点按照从左向右的顺序打印。
 */
void printTree(Tree *root)
{
    queue<Tree *> s;
    s.push(root);
    
    while (s.size() > 0) {
        Tree *tree = s.front();
        printf("%d ", tree->value);
        s.pop();
        
        if (tree->left) {
            s.push(tree->left);
        }
        
        if (tree->right) {
            s.push(tree->right);
        }
    }
}

//int main(int argc, const char * argv[])
//{
//    Tree *root;
//    int i = 0;
//    int a[] = {1,2,4,-1,-1,5,-1,-1,3,6,-1,-1,7,-1,-1};
//    createTree(&root, a, &i, sizeof(a)/sizeof(*a));
//    
//    printTree(root);
//    
//    return 0;
//}

