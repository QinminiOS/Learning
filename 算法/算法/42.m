//
//  42.m
//  算法
//
//  Created by qinmin on 2017/11/16.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 字符串的左旋转操作是把字符串前面的若干个字符转移到字符串的尾部。请定义一个函数实现字符串左旋转操作的功能。
 
 举例说明
 比如输入字符串”abcdefg”和数字2，该函数将返回左旋转2 位得到的结”cdefgab”。
 
 以”abcdefg”为例，我们可以把它分为两部分。由于想把它的前两个字符移到后面，我们就把前两个字符分到第一部分，把后面的所有字符都分到第二部分。我们先分别翻转这两部分，于是就得到”bagfedc”。接下来我们再翻转整个字符串， 得到的”cdefgab”就是把原始字符串左旋转2 位的结果。
 
 */

void rotateWord(const char *s, char *str, int index)
{
    if (s == NULL || str == NULL) {
        return;
    }
    
    size_t len = strlen(s);
    
    if (len < index) {
        return;
    }
    
    int j = 0;
    for (int i = index; i < len; i++, j++) {
        str[j] = s[i];
    }
    
    for (int i = 0; i < len; i++, j++) {
        str[j] = s[i];
    }
    
    str[len] = '\0';
}

//int main(int argc, const char * argv[])
//{
//    const char *s = "abcdefg";
//    char des[strlen(s)+1];
//    
//    rotateWord(s, des, 2);
//    
//    printf("%s\n", des);
//    
//    return 0;
//}

