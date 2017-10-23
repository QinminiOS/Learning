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
    if (root == NULL) {
        return;
    }
    
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
    if (root == NULL) {
        return;
    }
    
    stack<Tree *> s;
    Tree *p = root;
    
    while (p) {
        while (p) {
            s.push(p);
            p = p->left;
        }
        
        do {
            Tree *tmp = s.top();
            s.pop();
            printf("%d ", tmp->value);
            p = tmp->right;
        } while (!p && !s.empty());
    }
}


/**
     后序遍历
 */
void postVisit(Tree *root)
{
    if (root == NULL) {
        return;
    }
    
    stack<Tree *> s;
    Tree *p = root;
    Tree *lastVisit = NULL;

    while (p) {
        s.push(p);
        p = p->left;
    }
    
    while (!s.empty()) {
        p = s.top();
        s.pop();
        
        // 一个根节点被访问的前提是:无右子树或右子树已被访问过
        if (p->right == NULL || p->right == lastVisit) {
            printf("%d ", p->value);
            lastVisit = p;
            
        //若左子树刚被访问过，则需先进入右子树,根节点需再次入栈
        }else {
            s.push(p);
            p = p->right;
            while (p) {
                s.push(p);
                p = p->left;
            }
        }
    }
    
}

/**
      1
   2     3
 4   5  6   7

 */

int main(int argc, const char * argv[])
{
    Tree *root;
    int i = 0;
    int a[] = {1,2,4,-1,-1,5,-1,-1,3,6,-1,-1,7,-1,-1};
    createTree(&root, a, &i, sizeof(a)/sizeof(*a));
    
    postVisit(root);
    
    return 0;
}
