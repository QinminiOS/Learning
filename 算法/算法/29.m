//
//  29.m
//  算法
//
//  Created by qinmin on 2017/10/28.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 输入一个整数n，求从1 到n这n个整数的十进制表示中1 出现的次数。
 
 举例说明：
 
 例如输入12 ，从1 到12 这些整数中包含1 的数字有1、10、11 和12，1 一共出现了5 次。
 */

int countOneCount(int number)
{
    if (number <= 0) {
        return 0;
    }else {
        int count = 0;
        int tmp = number;
        while (tmp > 0) {
            if ((tmp % 10) == 1) {
                count++;
            }
            tmp = tmp/10;
        }
        return count + countOneCount(number-1);
    }
}

//int main(int argc, const char * argv[])
//{
//    
//    printf("%d\n", countOneCount(12));
//    
//    return 0;
//}

