# CCTapped
对常用视图控件添加点击事件(UIButton、UILabel、UIImageView、UITextField.......)

Why?
===
以前做项目的时候对一个视图添加点击事件很繁琐,并且之前看过一个类似的一个开源库，感觉写的不错，今天自己又整理了一下思路，完成了本项目。

Clone CCTapeped 并导入你的项目
===

```objective-c
#import "CCTapped.h"
```
```objective-c

使用
===
@interface UIView (TappedBlcok)

- (void)whenTapped:(CCTappedBlock)block;            //单击
- (void)whenDoubleTapped:(CCTappedBlock)block;      //双击
- (void)whenDoubleFingerTapped:(CCTappedBlock)block;//两根手指点击
- (void)whenLongPress:(CCTappedBlock)block;         //长按
- (void)whenTouchDown:(CCTappedBlock)block;         //开始点击时
- (void)whenTouchUp:(CCTappedBlock)block;           //结束点击时

@end

    [view whenTapped:^{
        NSLog(@"单击");
    }];
    
    [view whenDoubleTapped:^{
        NSLog(@"双击");
    }];
    
    [view whenLongPress:^{
        NSLog(@"长按");
    }];
    
    [view whenTouchUp:^{
        NSLog(@"即将离开");
    }];
    
    [view whenTouchDown:^{
        NSLog(@"即将按下");
    }];
```
More
===
UIButton以前的写法
---
```objective-c
    [button addTarget:self action:@selector(click ) forControlEvents:UIControlEventTouchUpInside];

    #pragma mark event
    -(void)click
```
现在
---
```objective-c
    [button whenTapped:^{
        
    }];
```
欢迎Star
===




