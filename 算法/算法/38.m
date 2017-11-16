//
//  38.m
//  算法
//
//  Created by qinmin on 2017/11/16.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  一个整型数组里除了两个数字之外，其他的数字都出现了两次，请写程序找出这两个只出现一次的数字。要求时间复杂度是O(n)，空间复杂度是O(1)。
 *
 *  举例说明
 *  例如输入数组｛2, 4, 3, 6, 5, 3, 2, 5 }，因为只有4 、6 这两个数字只出现一次，其他数字都出现了两次，所以输出4和6 。
 */

int findFirstBit1(int num) {
    int index = 0;
    while ((num & 0x01) == 0 && index < 32) {
        num >>= 1;
        index++;
    }
    
    return index;
}

bool isBit1(int num, int index)
{
    num >>= index;
    return (num & 0x01) == 1;
}

int findNumbersAppearanceOnce(int *arr, int len, int *a)
{
    if (arr == NULL || a == NULL) {
        return INT_MAX;
    }
    
    int sum = 0;
    for (int i = 0; i < len; i++) {
        sum ^= arr[i];
    }
    
    int bit1Index = findFirstBit1(sum);
    int sum1 = 0, sum2 = 0;
    for (int i = 0; i < len; i++) {
        if (isBit1(arr[i], bit1Index)) {
            sum1 ^= arr[i];
        }else {
            sum2 ^= arr[i];
        }
    }
    
    a[0] = sum1;
    a[1] = sum2;
    
    return sum1;
}


//int main(int argc, const char * argv[])
//{
//
//    int a[] = {2, 3, 6, 3, 2, 5, 4, 5};
//    int b[2];
//    findNumbersAppearanceOnce(a, sizeof(a)/sizeof(*a), b);
//    printf("%d %d\n", b[0], b[1]);
//    return 0;
//}

