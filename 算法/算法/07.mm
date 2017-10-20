//
//  07.m
//  算法
//
//  Created by qinmin on 2017/10/19.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"

/**
     写一个函数，输入n，求斐波那契数列的第n项值。
 
     斐波那契数列的定义如下：
 
     F0 = 0;
     F1 = 1;
     Fn = Fn-1 + Fn-2;
 
 **/

int fibonacci(int n)
{
    if (n == 0) {
        return 0;
    }else if (n == 1) {
        return 1;
    }else {
        return fibonacci(n-1) + fibonacci(n-2);
    }
}

int fibonacci1(int n)
{
    if (n == 0) {
        return 0;
    }else if (n == 1) {
        return 1;
    }
    
    int m = 2;
    int s0 = 0, s1 = 1, s = 0;
    while (m <= n) {
        s = s0 + s1;
        s0 = s1;
        s1 = s;
        m++;
    }
    
    return s;
}

//int main(int argc, const char * argv[])
//{
//    printf("%d\n", fibonacci(40));
//    printf("%d\n", fibonacci1(40));
//
//    return 0;
//}

