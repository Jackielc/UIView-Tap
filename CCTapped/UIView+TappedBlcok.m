//
//  UIView+TappedBlcok.m
//  CCTappedDemo
//
//  Created by jack on 16/8/17.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "UIView+TappedBlcok.h"
#import <objc/runtime.h>

//关键字为void*指针（任意类型指针）,每一个关联的关键字必须是唯一的，通常采用静态变量来作为关键字
static char CCSingleTapBlockKey;
static char CCDoubleTapBlockKey;
static char CCDoubleFingerTapBlockKey;
static char CCTouchDownTapBlockKey;
static char CCTouchUpTapBlcokKey;
static char CCLongPressBlockKey;

@interface UIView (CCTapPrivates)

- (void)requireSingleTapsRecognizer:(UIGestureRecognizer *)recognizer;
- (void)requireDoubleTapsRecognizer:(UIGestureRecognizer *)recognizer;
- (void)requireLongPressTecognizer:(UIGestureRecognizer *)recognizer;
- (UITapGestureRecognizer *)addTapRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches sel:(SEL)sel;
- (UILongPressGestureRecognizer *)addLongPressRecognizerWithTouches:(NSUInteger)touches sel:(SEL)sel;

- (void)returnBlockForkey:(void *)key;
- (void)setBlockForKey:(void *)key block:(CCTappedBlock)block;

@end

@implementation UIView (TappedBlcok)

#pragma mark -Taps
- (void)whenTapped:(CCTappedBlock)block
{
    UITapGestureRecognizer *tap = [self addTapRecognizerWithTaps:1 touches:1 sel:@selector(singleTap)];
    [self requireDoubleTapsRecognizer:tap];
    [self requireLongPressTecognizer:tap];
    [self setBlockForKey:&CCSingleTapBlockKey block:block];
}

- (void)whenDoubleTapped:(CCTappedBlock)block
{
    UITapGestureRecognizer *tap = [self addTapRecognizerWithTaps:2 touches:1 sel:@selector(doubleTap)];
    [self requireSingleTapsRecognizer:tap];
    [self setBlockForKey:&CCDoubleTapBlockKey block:block];
}

- (void)whenDoubleFingerTapped:(CCTappedBlock)block
{
    [self addTapRecognizerWithTaps:1 touches:2 sel:@selector(doubleFingerTap)];
    [self setBlockForKey:&CCDoubleFingerTapBlockKey block:block];
}

- (void)whenLongPress:(CCTappedBlock)block
{
    [self addLongPressRecognizerWithTouches:1 sel:@selector(longPress:)];
    [self setBlockForKey:&CCLongPressBlockKey block:block];
}

- (void)whenTouchDown:(CCTappedBlock)block
{
    [self setBlockForKey:&CCTouchDownTapBlockKey block:block];
}

- (void)whenTouchUp:(CCTappedBlock)block
{
    [self setBlockForKey:&CCTouchUpTapBlcokKey block:block];
}

#pragma mark - 添加block属性
//获取关联对象
- (void)returnBlockForkey:(void *)key
{
    CCTappedBlock block = objc_getAssociatedObject(self, key);
    if (block) block();
}

//创建关联
- (void)setBlockForKey:(void *)key block:(CCTappedBlock)block
{
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



#pragma mark - CallBacks
- (void)singleTap
{
    [self returnBlockForkey:&CCSingleTapBlockKey];
}

- (void)doubleTap
{
    [self returnBlockForkey:&CCDoubleTapBlockKey];
}

- (void)doubleFingerTap
{
    [self returnBlockForkey:&CCDoubleFingerTapBlockKey];
}

- (void)longPress:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)[self returnBlockForkey:&CCLongPressBlockKey];}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self returnBlockForkey:&CCTouchDownTapBlockKey];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self returnBlockForkey:&CCTouchUpTapBlcokKey];
}

#pragma mark - 解决手势冲突
//在单击和双击手势时,由于手势的触发条件会有重合,有些情况下会产生冲突,无法达到满意的效果,利用 requireGestureRecognizerToFail 的方法指定某个手势确定失效之后才会触发本次手势，即使本次手势的触发条件已经满足
- (void)requireSingleTapsRecognizer:(UIGestureRecognizer *)recognizer
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gesture;
            if (tap.numberOfTouchesRequired==1&tap.numberOfTapsRequired == 1) {
                [tap requireGestureRecognizerToFail:recognizer];
            }
        }
    }
}

- (void)requireDoubleTapsRecognizer:(UIGestureRecognizer *)recognizer
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gesture;
            if (tap.numberOfTapsRequired == 2&tap.numberOfTouchesRequired == 1) {
                [tap requireGestureRecognizerToFail:recognizer];
            }
        }
    }
}

- (void)requireLongPressTecognizer:(UIGestureRecognizer *)recognizer
{
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
            UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)gesture;
            [longPress requireGestureRecognizerToFail:recognizer];
        }
    }
}

#pragma mark - 添加手势
- (UITapGestureRecognizer *)addTapRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches sel:(SEL)sel
{
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc]initWithTarget:self action:sel];
    tapGr.delegate = self;
    tapGr.numberOfTapsRequired = taps;
    tapGr.numberOfTouchesRequired = touches;
    [self addGestureRecognizer:tapGr];
    return tapGr;
}

- (UILongPressGestureRecognizer *)addLongPressRecognizerWithTouches:(NSUInteger)touches sel:(SEL)sel
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:sel];
    longPress.numberOfTouchesRequired = touches;
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
    return longPress;
}

#pragma mark - UIGestureRecognizerDelegate

@end
