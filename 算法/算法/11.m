//
//  11.m
//  算法
//
//  Created by qinmin on 2017/10/20.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有奇数位于数组的前半部分，所有偶数位予数组的后半部分。
 
 */

void change(int *a, int len)
{
    int j = len - 1;
    for (int i = 0; i < len; i++) {
        if ((a[i] & 0x01) != 1) {
            while (j > i && (a[j] & 0x01) != 1) {
                j--;
            }
            if (j <= i) {
                return;
            }else {
                a[i] = a[i] ^ a[j];
                a[j] = a[i] ^ a[j];
                a[i] = a[i] ^ a[j];
            }
        }
    }
}

//int main(int argc, const char * argv[])
//{
//    int a[] = {1, 4, 7, 12, 17, 40, 101, 123, 142};
//    
//    change(a, sizeof(a)/sizeof(*a));
//    
//    for (int i = 0; i < sizeof(a)/sizeof(*a); i++) {
//        printf("%d ", a[i]);
//    }
//    
//    printf("\n");
//    
//    return 0;
//}

