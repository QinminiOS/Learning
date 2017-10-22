
//
//  10.m
//  算法
//
//  Created by qinmin on 2017/10/20.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

void test(int count)
{
    if (count >= 2) {
        return;
    }else {
        for (int i = 1; i < 10; i++) {
            printf("%d\n", i);
            test(count + 1);
        }
    }
}

//int main(int argc, const char * argv[])
//{
//    test(0);
//    
//    return 0;
//}

