//
//  main.m
//  算法
//
//  Created by qinmin on 2017/10/18.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <vector>

using namespace std;

/**
 *  在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。
 *
 *  12 14 18 20 22
 *  13 16 23 31 35
 *  17 22 25 32 39
 *  21 28 30 43 50
 *
 */

bool arrayContaintObject(vector<vector<int>>& v, int key)
{
    long i = 0, j = v[0].size() - 1;
    int value;
    
    while (i < v.size() && j >= 0) {
        value = v[i][j];
        if (value == key) {
            return true;
        }else if (value < key) {
            i++;
        }else {
            j--;
        }
    }
    return false;
}

int main(int argc, const char * argv[]) {
    
     vector<vector<int>> a = {
        {12, 14, 18, 20, 22},
        {13, 16, 23, 31, 35},
        {17, 22, 25, 32, 39},
        {21, 28, 30, 43, 50}
    };
    
    printf("%d\n", arrayContaintObject(a, 10));
    
    return 0;
}
