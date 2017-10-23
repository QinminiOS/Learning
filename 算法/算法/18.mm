
//
//  18.m
//  算法
//
//  Created by qinmin on 2017/10/22.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "Common.h"


/**
 定义栈的数据结构，请在该类型中实现一个能够得到栈的最小数的min 函数。在该栈中，调用min、push 及pop的时间复杂度都是O(1)。
 */

#define kStackSize 100

class Stack
{
private:
    int _top;
    int _length;
    int *_elements;
    
public:
    Stack()
    {
        _top = 0;
        _length = kStackSize;
        _elements = new int(kStackSize);

    }
    
    void push(int e)
    {
        if (_top >= _length) {
            int *tmp = _elements;
            _elements = new int(_length + kStackSize);
            for (int i = 0; i < _length; i++) {
                _elements[i] = tmp[i];
            }
            _length += kStackSize;
            delete tmp;
        }
 
        _elements[_top] = e;
        _top++;
    }
    
    int pop()
    {
        assert(_top > 0);
        _top--;
        return _elements[_top];
    }
    
    int top()
    {
        assert(_top > 0);
        return _elements[_top-1];
    }
    
    int size() {
        return _top;
    }
};

class MinStack {
private:
    Stack _stack;
    Stack _minStack;
    
public:
    void push(int e)
    {
        _stack.push(e);
        if (_minStack.size() == 0 || (_minStack.size() > 0 && e < _minStack.top())) {
            _minStack.push(e);
        }
    }
    
    int pop()
    {
        int e = _stack.pop();
        if (_minStack.size() > 0 && e == _minStack.top()) {
            _minStack.pop();
        }
        return e;
    }
    
    int min()
    {
        return _minStack.top();
    }
};


//int main(int argc, const char * argv[])
//{
//
//    MinStack s;
//    s.push(2);
//    s.push(3);
//    s.push(1);
//    s.push(7);
//    s.push(6);
//
//    printf("%d\n", s.min());
//    s.pop();
//
//    printf("%d\n", s.min());
//    s.pop();
//
//    printf("%d\n", s.min());
//    s.pop();
//
//    printf("%d\n", s.min());
//    s.pop();
//
//    return 0;
//}

