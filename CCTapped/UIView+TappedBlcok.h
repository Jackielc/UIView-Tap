//
//  UIView+TappedBlcok.h
//  CCTappedDemo
//
//  Created by jack on 16/8/17.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CCTappedBlock)();

@interface UIView (TappedBlcok)<UIGestureRecognizerDelegate>

- (void)whenTapped:(CCTappedBlock)block;            //单击
- (void)whenDoubleTapped:(CCTappedBlock)block;      //双击
- (void)whenDoubleFingerTapped:(CCTappedBlock)block;//两根手指点击
- (void)whenLongPress:(CCTappedBlock)block;         //长按
- (void)whenTouchDown:(CCTappedBlock)block;        //开始点击时
- (void)whenTouchUp:(CCTappedBlock)block;           //结束点击时

@end

