//
//  02.m
//  算法
//
//  Created by qinmin on 2017/10/18.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"


/**
*   请实现一个函数，把字符串中的每个空格替换成"%20"，例如“We are happy.”，则输出“We%20are%20happy.”。
*/

string encode(const string s)
{
    string res = "";
    for (int i = 0; i < s.length(); i++) {
        if (s[i] == ' ') {
            res += "%20";
        }else {
            res += s[i];
        }
    }
    
    return res;
}

char* cencode(const char *s)
{
    
    int whiteword = 0;
    for (int i = 0; i < strlen(s); i++) {
        if (s[i] == ' ') {
            whiteword++;
        }
    }
    
    size_t len = strlen(s) + whiteword*2 + 1;
    char *res = (char *)malloc(len);
    
    for (int i = 0, j = 0; i < strlen(s); i++) {
        if (s[i] == ' ') {
            res[j++] = '%';
            res[j++] = '2';
            res[j++] = '0';
        }else {
            res[j++] = s[i];
        }
    }
    
    res[len-1] = '\0';
    
    return res;
}

//int main(int argc, const char * argv[])
//{
//    string w = "we are happy.";
//    char* s = cencode(w.c_str());
//    printf("%s\n", s);
//    free(s);
//    s = nullptr;
//    
//    return 0;
//}

