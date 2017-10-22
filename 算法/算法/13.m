//
//  13.m
//  算法
//
//  Created by qinmin on 2017/10/20.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 定义一个函数，输入一个链表的头结点，反转该链表并输出反转后链表的头结点。
 
 */

typedef struct LinkNode {
    int value;
    struct LinkNode *next;
} LinkNode;


void revert(LinkNode *head)
{
    LinkNode *p, *q, *tmp;
    p = NULL;
    q = head->next;
    
    while (q != NULL) {
        tmp = q->next;
        q->next = p;
        p = q;
        q = tmp;
    }
    
    head->next = p;
}

//int main(int argc, const char * argv[])
//{
//    LinkNode *head = malloc(sizeof(LinkNode));
//    LinkNode *q = head;
//    
//    for (int i = 0; i < 100; i++) {
//        LinkNode *tmp = malloc(sizeof(LinkNode));
//        tmp->next = NULL;
//        tmp->value = i;
//        q->next = tmp;
//        q = q->next;
//    }
//    
//    revert(head);
//    
//    LinkNode *q1 = head->next;
//    while (q1 != NULL) {
//        printf("%d\n", q1->value);
//        q1 = q1->next;
//    }
//    
//    // free to do
//    
//    
//    return 0;
//}

