//
//  27.m
//  算法
//
//  Created by qinmin on 2017/10/25.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 输入n个整数，找出其中最小的k个数。
 
 例子说明：
 
 例如输入 4 、5 、1、6、2、7、3 、8 这8 个数字，则最小的4 个数字是1 、2、3 、4
 */

void headAjust(int *a, int s, int len)
{
    int tmp = a[s];
    
    for (int j = 2*s; j < len; j++) {
        if (j+1 < len && a[j] > a[j+1]) {
            j++;
        }
        
        if (a[j] > tmp) {
            break;
        }
        
        a[s] = a[j];
        s = j;
    }
    
    a[s] = tmp;
}

void heapSort(int *a, int len, int k)
{
    for (int i = len/2; i > 0; i--) {
        headAjust(a, i, len);
    }
    
    for (int i = len-1; i > len-k-1; i--) {
        a[i] = a[i] ^ a[1];
        a[1] = a[i] ^ a[1];
        a[i] = a[i] ^ a[1];
        headAjust(a, 1, i-1);
    }
}
/////////////////// 1 ///////////////////////////////////

void findTheKNumber(int *a, int len, int k)
{
    heapSort(a, len, k);
    
    for (int i = 0; i < len; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}

//////////////////// 2 ////////////////////////////////////
int partition(int *a, int left, int right)
{
    int tmp = a[left];
    
    while (left < right) {
        while (tmp <= a[right] && left < right) {
            right--;
        }
        
        a[left] = a[right];
        
        while (tmp >= a[left] && left < right) {
            left++;
        }
        
        a[right] = a[left];
    }
    
    a[left] = tmp;
    
    return left;
}

void quickSort(int *a, int left, int right, int k)
{
    int pivot;
    if (left < right && left < k) {
        pivot = partition(a, left, right);
        quickSort(a, left, pivot-1, k);
        quickSort(a, pivot+1, right, k);
    }
}

void findTheKNumber2(int *a, int len, int k)
{
    quickSort(a, 1, len-1, k);
    
    for (int i = 0; i < len; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}

//int main(int argc, const char * argv[])
//{
//    int a[] = {0, 4, 5, 1, 6, 2, 7, 3, 8};
//    findTheKNumber(a, 9, 4);
//    
//    int b[] = {0, 4, 5, 1, 6, 2, 7, 3, 8};
//    findTheKNumber2(b, 9, 4);
//    
//    return 0;
//}

