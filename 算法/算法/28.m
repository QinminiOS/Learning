//
//  28.m
//  算法
//
//  Created by qinmin on 2017/10/26.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 
 输入一个整型数组，数组里有正数也有负数。数组中一个或连续的多个整数组成一个子数组。求所有子数组的和的最大值。要求时间复杂度为O(n)。
 
 例子说明：

 例如输入的数组为{1, -2, 3, 10, -4, 7, 2, -5}，和最大的子数组为｛3, 10, -4, 7, 2}。因此输出为该子数组的和18 。
 
 */

int addSubArray(int *arr, int len)
{
    int sum = 0, max = 0;
    
    for (int i = 0; i < len; i++) {
        sum = sum + arr[i];
        if (arr[i] > sum) {
            sum = arr[i];
        }
        max = MAX(sum, max);
    }
    
    return max;
}

//int main(int argc, const char * argv[])
//{
//    int a[] = {1, -2, 3, 10, -4, 7, 2, -5};
//    printf("%d\n", addSubArray(a, 8));
//    return 0;
//}

