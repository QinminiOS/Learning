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
void merge(int *a, int first, int center, int last, int *tmp)
{
    // [f .. c] [c .. l]
    int j = first;
    int i = center + 1;
    int m = first;
    
    while (first <= center && i <= last) {
        if (a[first] <= a[i]) {
            tmp[m++] = a[first++];
        }else {
            tmp[m++] = a[i++];
        }
    }
    
    while (i <= last) {
        tmp[m++] = a[i++];
    }
    
    while (first <= center) {
        tmp[m++] = a[first++];
    }
    
    while (j <= last) {
        a[j] = tmp[j];
        j++;
    }
    
}

void divide(int *a, int first, int last, int *tmp)
{
    if (first < last) {
        int center = (first + last)/2;
        divide(a, first, center, tmp);
        divide(a, center+1, last, tmp);
        merge(a, first, center, last, tmp);
    }
    
}

void mergeSort(int *a, int* buffer, int length)
{
    divide(a, 0, length-1, buffer);
}

///////////////// 快速排序 ///////////////////////////////
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

void quickSort(int *a, int left, int right)
{
    int pivot;
    if (left < right) {
        pivot = partition(a, left, right);
        quickSort(a, left, pivot-1);
        quickSort(a, pivot+1, right);
    }
}

//////////////////main///////////////////////
//int main(int argc, const char * argv[])
//{
//    int a[] = {0, 1, 4, 3, 2, 5, 6, 10, 8, 7, 9};
//    
//    int buffer[11];
//    mergeSort(a, buffer, sizeof(a)/sizeof(*a));
//    printArr(a, sizeof(a)/sizeof(*a));
//    
//    //heapSort(a, sizeof(a)/sizeof(*a));
//    //printArr(a, sizeof(a)/sizeof(*a));
//    
//    return 0;
//}



