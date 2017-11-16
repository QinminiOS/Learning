//
//  36.m
//  算法
//
//  Created by qinmin on 2017/11/16.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"

int treeDeep(Tree *root)
{
    if (root == nullptr) {
        return 0;
    }
    
    int left = treeDeep(root->left);
    int right = treeDeep(root->right);
    
    return (left > right ? left : right) + 1;
}

////     1
////  2     3
////4  5  6  7
//
//int main(int argc, const char * argv[])
//{
//    Tree *root;
//    int i = 0;
//    int a[] = {1, 2, 4, -1, -1, 5, -1, -1, 3, 6, -1, -1, 7, -1, -1};
//    createTree(&root, a, &i, sizeof(a)/sizeof(*a));
//    
//    cout<< treeDeep(root) << endl;
//    
//    return 0;
//}

