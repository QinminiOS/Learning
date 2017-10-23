//
//  tree.m
//  算法
//
//  Created by qinmin on 2017/10/23.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"


/**
 先序遍历
 */
void preVisit(Tree *root)
{
    stack<Tree *> s;
    s.push(root);
    
    while (s.size() > 0) {
        Tree *t = s.top();
        s.pop();
        
        printf("%d ", t->value);
        
        if (t->right) {
            s.push(t->right);
        }
        
        if (t->left) {
            s.push(t->left);
        }
    }
}

/**
 中序遍历
 */
void inVisit(Tree *root)
{
    stack<Tree *> s;
    s.push(root);
    
    while (s.size() > 0) {
        Tree *t = s.top();
        s.pop();
        
        printf("%d ", t->value);
        
        if (t->right) {
            s.push(t->right);
        }
        
        if (t->left) {
            s.push(t->left);
        }
    }
}


/**
 
 */
void postVisit(Tree *root)
{
    stack<Tree *> s;
    s.push(root);
    
    while (s.size() > 0) {
        Tree *t = s.top();
        s.pop();
        
        if (t->right) {
            s.push(t->right);
        }
        
        if (t->left) {
            s.push(t->left);
        }
        
        printf("%d ", t->value);
    }
}

int main(int argc, const char * argv[])
{
    Tree *root;
    int i = 0;
    int a[] = {1,2,4,-1,-1,5,-1,-1,3,6,-1,-1,7,-1,-1};
    createTree(&root, a, &i, sizeof(a)/sizeof(*a));
    
    postVisit(root);
    
    return 0;
}
