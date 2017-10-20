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

int addOne(int arr[], int len)
{
    // 保存进位值，因为每次最低位加1  
    int carry = 1;
    // 最低位的位置的后一位
    int index = len;
    
    do {
        // 指向上一个处理位置
        index--;
        // 处理位置的值加上进位的值
        arr[index] += carry;
        // 求处理位置的进位
        carry = arr[index] / 10;
        // 求处理位置的值
        arr[index] %= 10;
    } while (carry != 0 && index > 0);
    
    // 如果index=0说明已经处理了最高位，carry>0说明最高位有进位，返回1
    if (carry > 0 && index == 0) {
        return 1;
    }
    
    // 无进位返回0
    return 0;
}

void pnumber(int bit)
{
    int a[bit];
    memset(a, 0x00, bit);
    while (addOne(a, bit) == 0) {
        for (int i = 0; i < bit; i++) {
            printf("%d",a[i]);
        }
        printf("\n");
    }
}

int main(int argc, const char * argv[])
{
    pnumber(3);
    
    return 0;
}
