//
//  ViewController.m
//  SNTool
//
//  Created by snlo on 2017/2/23.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "ViewController.h"

#import "SNTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    pod trunk push SNTool.podspec --verbose --allow-warnings --use-libraries
    
    [SNTool showAlertStyle:UIAlertControllerStyleAlert title:@"提示" msg:SNString_localized(@"测试") chooseBlock:^(NSInteger actionIndx) {
        
    } actionsStatement:@"确认", nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    SNPhotoCameraViewControllor
    NSLog(@"-- -- -- - - -- %@",SNString_localized(@"测试"));
    NSLog(@"%@",[SNTool topViewController]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
