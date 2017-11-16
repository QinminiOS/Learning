//
//  39.m
//  算法
//
//  Created by qinmin on 2017/11/16.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"


/**
 输入一个递增排序的数组和一个数字s，在数组中查找两个数，得它们的和正好是s。如果有多对数字的和等于s，输出任意一对即可。
 
 举例说明
 
 例如输入数组｛1 、2 、4、7 、11 、15 ｝和数字15. 由于4+ 11 = 15 ，因此输出4 和11 。
 */

vector<int> findNumbersWithSum(vector<int> data, int sum)
{
    vector<int> outv;
    
    for (int i = 0, j = data.size() - 1; i < data.size() - 1 && j > 0; ) {
        int tmp = data[i] + data[j];
        if (tmp == sum) {
            outv.push_back(i);
            outv.push_back(j);
            break;
        }else if (tmp > sum) {
            j--;
        }else {
            i++;
        }
    }
    
    return outv;
}

//int main(int argc, const char * argv[])
//{
//    vector<int> v = {1, 2, 4, 7, 11, 15};
//    vector<int> a = findNumbersWithSum(v, 15);
//    cout<<a[0]<<" " <<a[1]<<endl;
//    return 0;
//}

