//
//  09.m
//  算法
//
//  Created by qinmin on 2017/10/19.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
     输入数字n，按顺序打印出从1到n位最大十进数的数值。比如输入3，则打印出1、2、3一直到最大三位数即999。
 */

void print(int *a, int len)
{
    for (int i = 0; i < len; i++) {
        printf("%d", a[i]);
    }
    printf("\n");
}

void add(int *a, int len, int i)
{
    if (i >= len) {
        print(a, len);
    }else {
        for (int j = 0; j <= 9; j++) {
            a[i] = j;
            add(a, len, i+1);
        }
    }
}

void pnumber(int bit)
{
    int a[bit];
    add(a, bit, 0);
}

//int main(int argc, const char * argv[])
//{
//    pnumber(3);
//    
//    return 0;
//}

