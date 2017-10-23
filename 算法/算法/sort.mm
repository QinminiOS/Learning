//
//  sort.m
//  算法
//
//  Created by qinmin on 2017/10/23.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"

void swap(int *a, int i , int j)
{
    a[j] = a[j] ^ a[i];
    a[i] = a[j] ^ a[i];
    a[j] = a[j] ^ a[i];
}

void printArr(int *a, int len)
{
    printf("[ ");
    for (int i = 0; i < len; i++) {
        printf("%d ", a[i]);
    }
    printf("]\n");
}

////////////////////////////堆排序//////////////////////////////////////
void heapAdjust(int *a, int i, int length)
{
    int tmp = a[i];
    for (int j = 2*i; j < length; j *= 2) {
        if (j+1 < length && a[j] < a[j+1]) {
            j++;
        }

        if (a[j] <= tmp) {
            break;
        }

        a[i] = a[j];
        i = j;
    }
    
    a[i] = tmp;
}

void heapSort(int *a, int length)
{
    for (int i = length/2; i > 0 ; i--) {
        heapAdjust(a, i, length);
    }
    
    for (int i = length-1; i > 1; i--) {
        swap(a, 1, i);
        heapAdjust(a, 1, i);
    }
    
}

////////////////////////////归并排序//////////////////////////////////////
void merge(int *a, int *tmp, int s, int c, int e)
{
    // [s .. c] [c .. e]
    int m, i, j;
    for (i = s, j = c, m = s; i <= c && j <= e; ) {
        if (a[i] <= a[j]) {
            tmp[m++] = a[i++];
        }else {
            tmp[m++] = a[j++];
        }
    }
    
    if (i <= c) {
        for (int k = 0; k <= m-i; k++) {
            tmp[m++] = a[k];
        }
    }
    
    if (j <= e) {
        for (int k = j; k <= e; k++) {
            tmp[m++] = a[k];
        }
    }
}

void divide(int *a, int *tmp, int s, int e)
{
    
    if (s == e) {
        tmp[s] = a[s];
    }else {
        int tmp1[e+1];
        int m = (s+e)/2;
        divide(a, tmp1, s, m);
        divide(a, tmp1, m+1, e);
        merge(tmp1, tmp, s, m, e);
    }
    
}

void mergeSort(int *a, int* outa, int length)
{
    divide(a, outa, 0, length-1);
}

//////////////////main///////////////////////
//int main(int argc, const char * argv[])
//{
//    int a[] = {0, 1, 4, 3, 2, 5, 6, 10, 8, 7, 9};
//    
//    int b[11];
//    mergeSort(a, b, sizeof(a)/sizeof(*a));
//    printArr(b, 11);
//    
//    //heapSort(a, sizeof(a)/sizeof(*a));
//    //printArr(a, sizeof(a)/sizeof(*a));
//    
//    return 0;
//}



