//
//  ViewController.m
//  CoreText
//
//  Created by qinmin on 2017/11/13.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "MMLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    [self coreTextDraw:ctx];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    self.view.layer.contents = (__bridge id _Nullable)(image.CGImage);
    
    MMLabel *label = [[MMLabel alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    label.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:30],
                                 NSForegroundColorAttributeName:[UIColor greenColor],
                                 NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)
                                 };
    
    NSString *s = @"hello6666666666 酷狗！！！";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:s attributes:attributes];
    label.range = [s rangeOfString:@"酷狗"];
    label.text = str;
    [self.view addSubview:label];
}

static CGFloat ascentCallBacks(void * ref)
{
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"height"] floatValue];
}

static CGFloat descentCallBacks(void * ref)
{
    return 0;
}

static CGFloat widthCallBacks(void * ref)
{
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"width"] floatValue];
}

- (void)coreTextDraw:(CGContextRef)ctx
{
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, [UIScreen mainScreen].bounds.size.height);
    CGContextScaleCTM(ctx, 1, -1);

    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:@"\n这里在测试图文混排，\n我是一个富文本"];
    
    CTRunDelegateCallbacks callBacks;
    memset(&callBacks,0,sizeof(CTRunDelegateCallbacks));//memset将已开辟内存空间 callbacks 的首 n 个字节的值设为值 0, 相当于对CTRunDelegateCallbacks内存空间初始化
    callBacks.version = kCTRunDelegateCurrentVersion;//设置回调版本，默认这个
    callBacks.getAscent = ascentCallBacks;//设置图片顶部距离基线的距离
    callBacks.getDescent = descentCallBacks;//设置图片底部距离基线的距离
    callBacks.getWidth = widthCallBacks;//设置图片宽度
    
    NSDictionary * dicPic = @{
                              @"height" : @129,
                              @"width" : @300
                              };
    
    unichar placeHolder = 0xFFFC;
    NSString * placeHolderStr = [NSString stringWithCharacters:&placeHolder length:1];
    NSMutableAttributedString *placeHolderAttrStr = [[NSMutableAttributedString alloc] initWithString:placeHolderStr];
    
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callBacks, (__bridge void *)dicPic);
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    [attributeStr insertAttributedString:placeHolderAttrStr atIndex:12];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.view.bounds);
    NSInteger length = attributeStr.length;
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path, NULL);
    CTFrameDraw(frame, ctx);
    
    UIImage* image = [UIImage imageNamed:@"123.jpg"];
    CGRect imgFrm = [self calculateImageRectWithFrame:frame];
    CGContextDrawImage(ctx, imgFrm, image.CGImage);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}

- (CGRect)calculateImageRectWithFrame:(CTFrameRef)frame
{
    NSArray * arrLines = (NSArray *)CTFrameGetLines(frame);
    NSInteger count = [arrLines count];
    CGPoint points[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
    for (int i = 0; i < count; i ++) {
        CTLineRef line = (__bridge CTLineRef)arrLines[i];
        NSArray * arrGlyphRun = (NSArray *)CTLineGetGlyphRuns(line);
        for (int j = 0; j < arrGlyphRun.count; j ++) {
            CTRunRef run = (__bridge CTRunRef)arrGlyphRun[j];
            NSDictionary * attributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegate == nil) {
                continue;
            }
            NSDictionary * dic = CTRunDelegateGetRefCon(delegate);
            if (![dic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            CGPoint point = points[i];
            CGFloat ascent;
            CGFloat descent;
            CGRect boundsRun;
            boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            boundsRun.size.height = ascent + descent;
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            boundsRun.origin.x = point.x + xOffset;
            boundsRun.origin.y = point.y - descent;
            CGPathRef path = CTFrameGetPath(frame);
            CGRect colRect = CGPathGetBoundingBox(path);
            CGRect imageBounds = CGRectOffset(boundsRun, colRect.origin.x, colRect.origin.y);
            return imageBounds;
        }
    }
    return CGRectZero;
}

@end
