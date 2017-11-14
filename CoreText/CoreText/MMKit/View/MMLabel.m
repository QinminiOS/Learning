//
//  MMLabel.m
//  CoreText
//
//  Created by qinmin on 2017/11/14.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "MMLabel.h"
#import <CoreText/CoreText.h>

@interface MMLabel()
{
    NSMutableArray<NSValue *> *_rectArr;
}
@end

@implementation MMLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _rectArr = [NSMutableArray array];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, self.frame.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    
    CGPathRef path = CGPathCreateWithRect(self.bounds, NULL);
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.text);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, self.text.length), path, NULL);
    CTFrameDraw(frame, ctx);
    
    
    CFArrayRef lines = CTFrameGetLines(frame);
    CFIndex lineCount = CFArrayGetCount(lines);
    CGPoint origins[lineCount];
    
    for (CFIndex i = 0; i < lineCount; i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
        
        CFRange lineRange = CTLineGetStringRange(line);
        if (![self isRange:lineRange containsRange:CFRangeMake(self.range.location, self.range.length)]) {
            continue;
        }
        
        CGFloat offset1 = CTLineGetOffsetForStringIndex(line, self.range.location, NULL);
        CGFloat offset2 = CTLineGetOffsetForStringIndex(line, self.range.location+self.range.length, NULL);
        CGFloat ascent, descent, leading;
        CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        
        CGRect rect;
        rect.size.width = offset2 - offset1;
        rect.size.height = ascent + descent;
        rect.origin.x = origins[i].x + offset1;
        rect.origin.y = origins[i].y - descent;
        
//        CGPathRef debugPath = CGPathCreateWithRect(rect, NULL);
//        CGContextAddPath(ctx, debugPath);
//        CGContextDrawPath(ctx, kCGPathStroke);
//        CFRelease(debugPath);
        
        [_rectArr addObject:@(rect)];
    }
    
    
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
}

- (CGPoint)convertToCoreTextCoord:(CGPoint)point
{
    return CGPointMake(point.x, self.frame.size.height - point.y);
}

- (BOOL)isRange:(CFRange)range containsRange:(CFRange)subRange
{
    if ((subRange.location + subRange.length < range.location) || (subRange.location > range.location + range.length)) {
        return NO;
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [self convertToCoreTextCoord:[touch locationInView:self]];
    
    for (NSValue *value in _rectArr) {
        if (CGRectContainsPoint([value CGRectValue], point)) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"哈哈" message:@"666" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            break;
        }
    }
}


@end
