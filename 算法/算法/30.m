//
//  30.m
//  算法
//
//  Created by qinmin on 2017/10/28.
//  Copyright © 2017年 qinmin. All rights reserved.


#import <Foundation/Foundation.h>
#import <string.h>


/**
 输入一个正整数数组，把数组里所有数字拼接起来排成一个数，打印能拼接出的所有数字中最小的一个。
 
 例子说明：
 
 例如输入数组{3， 32, 321}，则扫描输出这3 个数字能排成的最小数字321323。
 
 */

int compare1(int a, int b)
{
    int len = 2 * sizeof(int) * 8 + 1;
    char buffer1[len];
    sprintf(buffer1, "%d%d\\0", a, b);
    
    char buffer2[len];
    sprintf(buffer2, "%d%d\\0", b, a);
    
    return strcmp(buffer1, buffer2);
}

int partition1(int *a, int start, int end)
{
    int pivot = a[start];
    
    while (start < end) {
        while (start < end && compare1(pivot, a[end]) < 0) {
            end--;
        }
        a[start] = a[end];
        
        while (start < end && compare1(pivot, a[start]) > 0) {
            start++;
        }
        a[end] = a[start];
    }
    
    a[start] = pivot;
    
    return start;
}

void quickSort1(int *a, int start, int end)
{
    if (start < end) {
        int pivot = partition1(a, start, end);
        quickSort1(a, start, pivot-1);
        quickSort1(a, pivot+1, end);
    }
}

int bitCount1(int a)
{
    int i = 0;
    while (a > 0) {
        i++;
        a = a/10;
    }
    return i;
}

void minNumber(int *a, int len)
{
    quickSort1(a, 0, len-1);
    
    for (int i = 0; i < len; i++) {
        printf("%d", a[i]);
    }
    
    printf("\n");
}

///////////// test ////////////
char* testMalloc()
{
    char *a = malloc(100);
    a += 10;
    return a - 10;
}

int main(int argc, const char * argv[])
{
    
    int a[] = {3, 32, 321};
    minNumber(a, 3);
    
    char *b = testMalloc();
//    free(b);
    
    int64_t c = (int64_t)b;
    free((int *)c);
    
    return 0;
}
