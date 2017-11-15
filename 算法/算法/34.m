//
//  34.m
//  算法
//
//  Created by qinmin on 2017/11/16.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 输入两个链表，找出它们的第一个公共结点。
 */


typedef struct LinkNode {
    int value;
    struct LinkNode *next;
} LinkNode;

int countLinkNode(LinkNode *head)
{
    if (head == NULL) {
        return 0;
    }
    
    LinkNode *p = head->next;
    int count = 0;
    
    while (p) {
        count++;
        p = p->next;
    }
    
    return count;
}

LinkNode* findTheSimilarNode(LinkNode *first, LinkNode* second)
{
    if (first == NULL || second == NULL) {
        return NULL;
    }
    
    int firstCount = countLinkNode(first);
    if (firstCount == 0) {
        return NULL;
    }
    
    int secondCount = countLinkNode(second);
    if (secondCount == 0) {
        return NULL;
    }
    
   //h 1 2 3 4   4
   //h     3 4   2
   //            2
    
    LinkNode *p1 = first->next, *p2 = second->next;
    int offset = firstCount - secondCount;
    if (offset > 0) {
        p1 = first->next;
        while (offset > 0) {
            p1 = p1->next;
            offset--;
        }
    }else if (offset < 0) {
        p2 = second->next;
        while (offset < 0) {
            p2 = p2->next;
            offset++;
        }
    }
    
    while (p1 && p2) {
        if (p1 == p2) {
            break;
        }
        
        p1 = p1->next;
        p2 = p2->next;
    }
    
    return p1;
}

int main(int argc, const char * argv[])
{
    
    return 0;
}
