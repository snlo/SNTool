//
//  sn_ViewController.m
//  SNTool
//
//  Created by sunDong on 2017/3/6.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "sn_ViewController.h"

@interface sn_ViewController ()

@end

@implementation sn_ViewController

- (void)dealloc {
    NSLog(@"dealloc - - - %s",__func__);
}
//- (instancetype)init { /* ... */ }

#pragma mark - View Lifecycle （View 的生命周期）

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib
    
//    word 
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if ([self.view window]  == nil) {
        
        self.view = nil;
    }
}

#pragma mark - Custom Accessors （自定义访问器）

#pragma mark - IBActions

#pragma mark - Public （公有方法、接口）

#pragma mark - Private （私有方法）

#pragma mark - Protocl （协议）

#pragma mark - _Superclass (重载超类的方法)

#pragma mark - NSObject （setter、getter）

@end


