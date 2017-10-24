//
//  23.m
//  算法
//
//  Created by qinmin on 2017/10/24.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"

typedef struct ComplexListNode {
    int value;
    struct ComplexListNode *next;
    struct ComplexListNode *sibling;
} ComplexListNode;


/**
     请实现函数ComplexListNode clone(ComplexListNode head),复制一个复杂链表。在复杂链表中，每个结点除了有一个next 域指向下一个结点外，还有一个sibling 指向链表中的任意结点或者null。
 
 
     在不用辅助空间的情况下实现O(n)的时间效率。
     第一步：仍然是根据原始链表的每个结点N 创建对应的N’。把N’链接在N的后面。
     第二步：设置复制出来的结点的sibling。假设原始链表上的N的sibling指向结点S，那么其对应复制出来的N’是N的next指向的结点，同样S’也是S的next指向的结点。
     第三步：把这个长链表拆分成两个链表。把奇数位置的结点用next . 链接起来就是原始链表，把偶数位置的结点用next 链接起来就是复制 出来的链表。
 */

ComplexListNode* clone(ComplexListNode* head)
{
    if (head == NULL) {
        return NULL;
    }
    
    ComplexListNode *p = head;
    
    while (p) {
        ComplexListNode *tmp = (ComplexListNode *)malloc(sizeof(ComplexListNode));
        tmp->value = p->value;
        
        ComplexListNode *q = p->next;
        p->next = tmp;
        tmp->next = q;
        
        p = q;
    }
    
    p = head;
    while (p) {
        p->next->sibling = p->sibling->next;
        p = p->next->next;
    }
    
    p = head;
    
    while (p) {
        ComplexListNode *newNode = p->next;
        
        p->next = newNode->next;
        if (newNode->next) {
            newNode->next = newNode->next->next;
        }
        
        p = p->next;
    }
    
    ComplexListNode *pCopy = head->next;
    return pCopy;
}


//int main(int argc, const char * argv[])
//{
//    ComplexListNode *root = (ComplexListNode *)malloc(sizeof(ComplexListNode));
//    ComplexListNode *head = clone(root);
//    
//    ComplexListNode *p = head;
//    while (p) {
//        printf("%d ", p->value);
//        p = p->next;
//    }
//    
//    return 0;
//}

