//
//  main.m
//  Test
//
//  Created by mac on 18/2/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <vector>
#import <stack>

using namespace std;

typedef struct _Tree {
    struct _Tree *left;
    struct _Tree *right;
    int value;
} Tree;


void createTree(Tree **root, int *arr, int *i)
{
    if (arr[*i] != -1) {
        *root = (Tree *)malloc(sizeof(Tree));
        (*root)->value = arr[*i];
        
        (*root)->left = NULL;
        (*root)->right = NULL;
        
        *i = *i + 1;
        createTree(&(*root)->left, arr, i);
        createTree(&(*root)->right, arr, i);
    }else {
        *i = *i + 1;
    }
}

void preOrder(Tree *root)
{
    if (root) {
        printf("%d ", root->value);
        preOrder(root->left);
        preOrder(root->right);
    }
}

void inOrder(Tree *root)
{
    if (root) {
        inOrder(root->left);
        printf("%d ", root->value);
        inOrder(root->right);
    }
}

void findPath(Tree *root, vector<Tree *>& v, int value)
{
    stack<Tree *> s;
    
    Tree *pTree = root;
    
    while (pTree || !s.empty()) {
        
        while (pTree) {
            printf("%d ", pTree->value);
            v.push_back(pTree);
            
            if (pTree->value == value) {
                return;
            }
            
            s.push(pTree);
            pTree = pTree->left;
        }
        
        pTree = s.top();
        s.pop();
        
        if (pTree->right == NULL) {
            v.erase(v.end()-1);
        }
        
        if (pTree == v[v.size()-1]->right) {
            v.erase(v.end()-1);
        }
        
        pTree = pTree->right;
    }
        
}

void inOrderStack(Tree *root)
{
    stack<Tree *> s;
    
    Tree *curTree = root;
    
    while (curTree || !s.empty()) {
        while (curTree) {
            s.push(curTree);
            curTree = curTree->left;
        }
        
        curTree = s.top();
        s.pop();
        
        printf("%d ", curTree->value);
        
        curTree = curTree->right;
    }
    
}

void postOrder(Tree *root)
{
    stack<Tree *> s;
    
    Tree *curTree = root;
    Tree *curPopTree = NULL;
    
    while (curTree || !s.empty()) {
        while (curTree) {
            s.push(curTree);
            curTree = curTree->left;
        }
        
        curTree = s.top();
        
        if (curTree->right == NULL) {
            s.pop();
            curPopTree = curTree;
            printf("%d ", curPopTree->value);
        }
        
        while (!s.empty() && s.top()->right == curPopTree) {
            curPopTree = s.top();
            s.pop();
            printf("%d ", curPopTree->value);
            
            if (s.empty()) {
                curTree = NULL;
            }else {
                curTree = s.top();
            }
        }
        
        if (curTree == NULL) {
            break;
        }
        
        curPopTree = NULL;
        curTree = curTree->right;
    }
    
}

int main(int argc, const char * argv[])
{
    
    int i = 0;
    int arr[] = {1,2,4,8,-1,-1,9,-1,-1,5,-1,-1,3,6,10,-1,-1,11,-1,-1,7,-1,-1};
    
    Tree *root = NULL;
    
    createTree(&root, arr, &i);

    postOrder(root);
    
//    preOrder(root);
//    inOrder(root);
    
//    vector<Tree *> v;
//    findPath(root, v, 11);
//    
//    printf("\n");
//    
//    for (int i = 0; i < v.size(); i++) {
//        printf("%d ", v[i]->value);
//    }
    
    
    printf("\n");
    
    return 0;
}
