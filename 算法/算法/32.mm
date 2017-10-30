//
//  32.m
//  算法
//
//  Created by qinmin on 2017/10/30.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"


/**
     在字符串中找出第一个只出现一次的字符。
 
     hello world
 */
char findchar(const char *str)
{
    map<char, int> dict;
    
    size_t len = strlen(str);
    for (int i = 0; i < len; i++) {
        if (dict.find(str[i]) != dict.end()) {
            dict[str[i]] = dict[str[i]] + 1;
        }else {
            dict[str[i]] = 1;
       }
    }

    for (int i = 0; i < len; i++) {
        if (dict[str[i]] == 1) {
            return str[i];
        }
    }
    
    return '0';
}

int main(int argc, const char * argv[])
{
    const char *str = "hello world";
    printf("%c\n", findchar(str));
    return 0;
}
