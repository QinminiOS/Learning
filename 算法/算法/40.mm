//
//  40.m
//  算法
//
//  Created by qinmin on 2017/11/16.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"

/**
 输入一个正数s，打印出所有和为s 的连续正数序列（至少两个数）。
 
 举例说明
 
 例如输入15，由于1+2+3+4+5=4＋5+6＝7+8=15，所以结果打出3 个连续序列1～5、4～6 和7～8。
 */
vector<vector<int>> findContinuousSequence(int sum)
{
    vector<vector<int>> v;
    
    int middle = (sum+1)/2;
    int i = 1, j = 2;
    int curSum = i + j;
    
    while (j < middle) {
        j++;
        curSum += j;
        
        if (curSum == sum) {
            vector<int> tmp;
            for (int m = i; m <= j; m++) {
                tmp.push_back(m);
            }
            v.push_back(tmp);
        }
        
        while (curSum > sum && i < j) {
            curSum -= i;
            i++;
            
            if (curSum == sum) {
                vector<int> tmp;
                for (int m = i; m <= j; m++) {
                    tmp.push_back(m);
                }
                v.push_back(tmp);
            }
        }
    }
    
    return v;
}

//int main(int argc, const char * argv[])
//{
//    vector<vector<int>> v = findContinuousSequence(100);
//    
//    for (auto s : v) {
//        for (int i : s) {
//            cout<< i << " ";
//        }
//        cout<<endl;
//    }
//    
//    return 0;
//}

