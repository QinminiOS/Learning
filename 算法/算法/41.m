//
//  41.m
//  算法
//
//  Created by qinmin on 2017/11/16.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 输入一个英文句子，翻转句子中单词的顺序，但单词内字的顺序不变。为简单起见，标点符号和普通字母一样处理。
 
 举例说明
 例如输入字符串”I am a student. ”，则输出”student. a am I”。
 
 第一步翻转句子中所有的字符。比如翻转“I am a student. ”中所有的字符得到”.tneduts a m a I”，此时不但翻转了句子中单词的顺序，连单词内的字符顺序也被翻转了。第二步再翻转每个单词中字符的顺序，就得到了”student. a am I”。这正是符合题目要求的输出。
 */
void revertWord(char *s, int i, int j)
{
    while (i < j) {
        char tmp = s[i];
        s[i] = s[j];
        s[j] = tmp;
        i++;
        j--;
    }
}

void reverseSentence(const char* s, char *des)
{
    if (s == NULL || des == NULL) {
        return;
    }
    
    size_t len = strlen(s);
    des[len] = '\0';
    
    for (int i = 0; i < len; i++) {
        des[len-i-1] = s[i];
    }
    
    int last = 0;
    for (int i = 0; i < len; i++) {
        if (des[i] == ' ') {
            revertWord(des, last, i-1);
            last = i+1;
        }
    }
}

//int main(int argc, const char * argv[])
//{
//    const char *s = "I am a student.";
//    char des[strlen(s)+1];
//    reverseSentence(s, des);
//    
//    printf("%s\n", des);
//
//    return 0;
//}

