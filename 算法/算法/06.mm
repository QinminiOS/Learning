//
//  06.m
//  算法
//
//  Created by qinmin on 2017/10/19.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"

/**
*把一个数组最开始的若干个元素搬到数组的末尾， 我们称之数组的旋转。输入一个递增排序的数组的一个旋转， 输出旋转数组的最小元素。例如数组{3,4,5,1,2 ｝为｛ 1,2,3,4,5}的一个旋转，该数组的最小值为1。
*/

int findElement(vector<int> & v)
{
    if (v.size() == 0) {
        return NAN;
    }
    
    long low = 0, high = v.size() - 1;
    long center;
    
    while (v[low] > v[high]) {
        center = (low + high)/2;
        
        if (high-low == 1 && v[low] > v[high]) {
            return v[high];
        }
        
        if (v[high] == v[low] && v[low] == v[center]) {
            long samll = low;
            for (long i = low+1; i <= high; i++) {
                if (v[samll] > v[i]) {
                    samll = i;
                    return v[samll];
                }
            }
        }
        
        if (v[center] > v[low]) {
            low = center;
        }else if (v[center] < v[high]) {
            high = center;
        }
    }
    
    return v[low];
}

//int main(int argc, const char * argv[])
//{
//    vector<int> v = {5,1,2,3,4};
//    printf("%d\n", findElement(v));
//    
//    return 0;
//}

