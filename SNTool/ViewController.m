//
//  ViewController.m
//  SNTool
//
//  Created by sunDong on 2017/2/23.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "ViewController.h"

#import "SNTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"-- -- -- - - -- %@",SNString_localized(@"测试"));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
