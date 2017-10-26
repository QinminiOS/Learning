//
//  26.m
//  算法
//
//  Created by qinmin on 2017/10/25.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"


/**
 数组中有一个数字出现的次数超过数组长度的一半，请找出这个数字。
 
 数组中有一个数字出现的次数超过数组长度的一半，也就是说它出现的次数比其他所有数字出现次数的和还要多。因此我们可以考虑在遍历数组的时候保存两个值： 一个是数组中的一个数字， 一个是次数。当我们遍历到下一个数字的时候，如果下一个数字和我们之前保存的数字相同，则次数加1，如果下一个数字和我们之前保存的数字不同，则次数减1 。如果次数为零，我们需要保存下一个数字，并把次数设为1 。由于我们要找的数字出现的次数比其他所有数字出现的次数之和还要多，那么要找的数字肯定是最后一次把次数设为1 时对应的数字。
 */

int findNumber(const vector<int>& v)
{
    if (v.size() == 0) {
        return INT_MAX;
    }
    
    int current = 0;
    int count = 0;
    for (int i = 0; i < v.size(); i++) {
        if (current == v[i]) {
            count++;
        }else if(count > 0) {
            count--;
        }else {
            count = 0;
            current = v[i];
        }
    }
    
    if (count >= 1) {
        return current;
    }else {
        return INT_MAX;
    }
}
//
//int main(int argc, const char * argv[])
//{
//    vector<int> v = {3,3,3,3,5,5,5,6,3,5,5,5,5,5};
//    printf("%d\n", findNumber(v));
//    
//    return 0;
//}

