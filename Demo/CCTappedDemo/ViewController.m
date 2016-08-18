//
//  ViewController.m
//  CCTappedDemo
//
//  Created by jack on 16/8/17.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "ViewController.h"
#import "CCTapped.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark event
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = self.view.center;
    label.layer.cornerRadius = 15;
    label.layer.masksToBounds = YES;
    [self.view addSubview:label];
    [label whenTapped:^{
        label.text = @"单击";
    }];
    
    [label whenDoubleTapped:^{
        label.text = @"双击";
    }];
    
    [label whenLongPress:^{
        label.text = @"长按";
    }];
    
    [label whenTouchUp:^{
        label.text = @"即将离开";
    }];
    
    [label whenTouchDown:^{
        label.text = @"即将按下";
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
