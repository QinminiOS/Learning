//
//  33.m
//  算法
//
//  Created by qinmin on 2017/10/30.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 在数组中的两个数字如果前面一个数字大于后面的数字，则这两个数字组成一个逆序对。输入一个数组，求出这个数组中的逆序对的总数。
 
 举例分析
 
 例如在数组｛7, 5, 6, 4 中， 一共存在5 个逆序对，分别是（7, 6）、（7，5），(7, 4）、（6, 4）和（5, 4）。
 */

// tmp [l...,p,....r]
void merge(int *a, int l, int p, int r, int *tmp)
{
    int j = l, k = r;
    
    int m = r;
    int n = p;
    
    // 逆序对
    for (int s = p, t = r; s >= l && t > p;) {
        if (a[s] > a[t]) {
            int tt = t;
            while (tt > p) {
                printf("%d - %d\n", a[s], a[tt--]);
            }
            s--;
        }else {
            t--;
        }
    }
    
    while (n >= l && r > p) {
        if (a[n] >= a[r]) {
            tmp[m--] = a[n--];
        }else {
            tmp[m--] = a[r--];
        }
    }

    while (r > p && m >= l) {
        tmp[m--] = a[r--];
    }

    while (n >= l && m >= l) {
        tmp[m--] = a[n--];
    }

    while (j <= k) {
        a[j] = tmp[j];
        j++;
    }
}

void mergeFind(int *a, int l, int r, int *tmp)
{
    if (l < r) {
        int pivot = (l + r)/2;
        mergeFind(a, l, pivot, tmp);
        mergeFind(a, pivot+1, r, tmp);
        merge(a, l, pivot, r, tmp);
    }
}


void findDesPairs(int *a, int len)
{
    int tmp[len];
    mergeFind(a, 0, len-1, tmp);
    
//    for (int i = 0; i < len; i++) {
//        printf("%d ", a[i]);
//    }
    
    printf("\n");
}

//int main(int argc, const char * argv[])
//{
//    
//    int a[] = {7, 5, 6, 4, 1};
//    
//    findDesPairs(a, sizeof(a)/sizeof(*a));
//    
//    return 0;
//}

