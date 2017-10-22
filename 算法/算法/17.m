//
//  17.m
//  算法
//
//  Created by qinmin on 2017/10/21.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
  输入一个矩阵，按照从外向里以顺时针的顺序依次扫印出每一个数字

 @param mat 矩阵
 @param row 矩阵行数
 @param col 矩阵列数
 @param deep 矩阵深度
 */
void printMat(int *mat, int row, int col, int deep)
{
    int currentRow = row-2*deep, currentCol = col-2*deep;
    if (currentRow <= 0 || currentCol <= 0) {
        return;
    }else {
        int i = 0, j = 0;
        while (i < currentCol-1) {
            printf("%d ", mat[deep+i+(j+deep)*col]);
            i++;
        }
        
        while (j < currentRow-1) {
            printf("%d ", mat[deep+i+(j+deep)*col]);
            j++;
        }
        
        while (i > 0) {
            printf("%d ", mat[deep+i+(j+deep)*col]);
            i--;
        }
        
        while (j > 0) {
            printf("%d ", mat[deep+i+(j+deep)*col]);
            j--;
        }
        
        printMat(mat, row, col, deep+1);
    }
}


int main(int argc, const char * argv[])
{
    
    int mat[] = {
         1,  2,  3,  4,
        12, 13, 14,  5,
        11, 16, 15,  6,
        10,  9,  8,  7,
        11, 19, 18, 17,
    };
    
    printMat(mat, 5, 4, 0);
    
    printf("\n");
    
    return 0;
}
