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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc]initWithFrame:self.view.frame];
    [self.view addSubview:label];
    [label whenTapped:^{
        NSLog(@"单击");
    }];
    
    [label whenDoubleTapped:^{
        NSLog(@"双击");
    }];
    
    [label whenLongPress:^{
        NSLog(@"长按");
    }];
    
    [label whenTouchUp:^{
        NSLog(@"即将离开");
    }];
    
    [label whenTouchDown:^{
        NSLog(@"即将按下");
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
