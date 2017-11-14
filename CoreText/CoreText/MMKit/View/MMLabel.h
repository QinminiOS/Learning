//
//  MMLabel.h
//  CoreText
//
//  Created by qinmin on 2017/11/14.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMLabel : UIView
@property(nullable, nonatomic, copy) NSAttributedString *text;
@property(nonatomic, assign) NSRange range;

@property(nullable, nonatomic, strong) UIFont *font;
@property(nullable, nonatomic, strong) UIColor *textColor;

@property(nullable, nonatomic, strong) UIColor *shadowColor;
@property(nonatomic, assign) CGSize shadowOffset;

@property(nonatomic, assign) NSTextAlignment textAlignment;
@property(nonatomic, assign) NSLineBreakMode lineBreakMode;

@property(nonatomic, assign) NSInteger numberOfLines;
@end
