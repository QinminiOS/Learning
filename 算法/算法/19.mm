//
//  19.m
//  算法
//
//  Created by qinmin on 2017/10/23.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"


/**
 输入两个整数序列，第一个序列表示栈的压入顺序，请判断二个序列是否为该栈的弹出顺序。假设压入栈的所有数字均不相等。
 */
bool isStackPop(vector<int> push, vector<int> pop)
{
    stack<int> s;
    int j = 0;
    
    for (int i = 0; i < push.size(); i++) {
        s.push(push[i]);
        while (s.size() > 0 && s.top() == pop[j] && j < pop.size()) {
            s.pop();
            j++;
        }
    }
    
    return s.size() == 0;
}

//int main(int argc, const char * argv[])
//{
//    
//    printf("%d\n", isStackPop({1,2,3,4,5,6}, {5,2,1,3,6,4}));
//    
//    return 0;
//}

