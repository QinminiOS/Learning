//
//  VisualStickView.m
//  SampleGame
//
//  Created by Zhang Xiang on 13-4-26.
//  Copyright (c) 2013年 Myst. All rights reserved.
//

#import "JoyStickView.h"

#define STICK_CENTER_TARGET_POS_LEN 30.0f

NSString* const JoyStickChangeNotification = @"JoyStickChangeNotification";

@interface JoyStickView()
{
    UIImageView *stickViewBase;
    UIImageView *stickView;
    
    UIImage *imgStickNormal;
    UIImage *imgStickHold;
    
    CGPoint mCenter;
}
@end

@implementation JoyStickView

-(void) initStickWithFrame:(CGRect)frame
{
    imgStickNormal = [UIImage imageNamed:@"stick_normal.png"];
    imgStickHold = [UIImage imageNamed:@"stick_hold.png"];

    mCenter.x = 64;
    mCenter.y = 64;
    
    stickViewBase = [[UIImageView alloc] initWithImage:imgStickNormal];
    [self addSubview:stickViewBase];
    
    stickView = [[UIImageView alloc] initWithImage:imgStickHold];
    [self addSubview:stickView];
    
    [self setFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initStickWithFrame:frame];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
	{
        // Initialization code
        [self initStickWithFrame:CGRectMake(0, 0, 128, 128)];
    }
	
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)notifyDir:(CGPoint)dir
{
    @autoreleasepool {
    
        NSValue *vdir = [NSValue valueWithCGPoint:dir];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys: vdir, @"DIR", nil];
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter postNotificationName:JoyStickChangeNotification object:nil userInfo:userInfo];
    
    }
}

- (void)stickMoveTo:(CGPoint)deltaToCenter
{
    CGRect fr = stickView.frame;
    fr.origin.x = deltaToCenter.x;
    fr.origin.y = deltaToCenter.y;
    stickView.frame = fr;
}

- (void)touchEvent:(NSSet *)touches
{

    if([touches count] != 1)
        return ;
    
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];
    if(view != self)
        return ;
    
    CGPoint touchPoint = [touch locationInView:view];
    CGPoint dtarget, dir;
    dir.x = touchPoint.x - mCenter.x;
    dir.y = touchPoint.y - mCenter.y;
    double len = sqrt(dir.x * dir.x + dir.y * dir.y);

    if(len < 10.0 && len > -10.0)
    {
        // center pos
        dtarget.x = 0.0;
        dtarget.y = 0.0;
        dir.x = 0;
        dir.y = 0;
    }
    else
    {
        double len_inv = (1.0 / len);
        dir.x *= len_inv;
        dir.y *= len_inv;
        dtarget.x = dir.x * STICK_CENTER_TARGET_POS_LEN;
        dtarget.y = dir.y * STICK_CENTER_TARGET_POS_LEN;
    }
    [self stickMoveTo:dtarget];
    
    [self notifyDir:dir];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    stickView.image = imgStickHold;
    [self touchEvent:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchEvent:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    stickView.image = imgStickNormal;
    CGPoint dtarget, dir;
    dir.x = dtarget.x = 0.0;
    dir.y = dtarget.y = 0.0;
    [self stickMoveTo:dtarget];
    
    [self notifyDir:dir];
}

@end
