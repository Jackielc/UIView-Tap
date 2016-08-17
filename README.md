# CCTapped
对常用视图控件添加点击事件

Clone CCTapeped 导入你的项目
===

```objective-c
#import "CCTapped.h"
```
```objective-c

@interface UIView (TappedBlcok)

- (void)whenTapped:(CCTappedBlock)block;            //单击
- (void)whenDoubleTapped:(CCTappedBlock)block;      //双击
- (void)whenDoubleFingerTapped:(CCTappedBlock)block;//两根手指点击
- (void)whenLongPress:(CCTappedBlock)block;         //长按
- (void)whenTouchDown:(CCTappedBlock)block;         //开始点击时
- (void)whenTouchUp:(CCTappedBlock)block;           //结束点击时

@end
```
