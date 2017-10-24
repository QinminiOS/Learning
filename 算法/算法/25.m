//
//  25.m
//  算法
//
//  Created by qinmin on 2017/10/24.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 输入一个字符串，打印出该字符串中字符的所有排列。例如输入字符串abc。则打印出由字符a、b、c 所能排列出来的所有字符串abc、acb、bac 、bca、cab 和cba 。
 */

void permutation(char chars[], int i)
{
    size_t len = strlen(chars);
    
    if (i == len-1) {
        printf("%s\n", chars);
        return;
    }else {
        for (int j = i; j < len; j++) {
            char tmp = chars[j];
            chars[j] = chars[i];
            chars[i] = tmp;
            permutation(chars, i+1);
            tmp = chars[j];
            chars[j] = chars[i];
            chars[i] = tmp;
        }
    }
}

void permutation1(char *str, char chars[], int i)
{
    size_t len = strlen(str);
    
    if (i == len) {
        printf("%s\n", chars);
        return;
    }else {
        for (int j = 0; j < len; j++) {
            chars[i] = str[j];
            permutation1(str, chars, i+1);
        }
    }
}

int main(int argc, const char * argv[])
{
    
    char str[] = "abc";
    permutation(str, 0);
    
    printf("\n");
    
    return 0;
}
