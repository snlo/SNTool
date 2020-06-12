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
    [[SNTool sharedManager].hudLoding.label setTextColor:[UIColor redColor]];
    [SNTool showLoading:@"正在加载。。。"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    pod trunk push SNTool.podspec --verbose --allow-warnings --use-libraries
    
//    [SNTool showAlertStyle:UIAlertControllerStyleAlert title:@"提示" msg:SNString_localized(@"测试") chooseBlock:^(NSInteger actionIndx) {
//
//    } actionsStatement:@"确认", nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SNTool dismissLoading];
        
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    SNPhotoCameraViewControllor
    NSLog(@"-- -- -- - - -- %@",SNString_localized(@"测试"));
    NSLog(@"%@",[SNTool topViewController]);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [SNTool
     showAlertTitle:@"数值选择"
     message:@"0为取消"
     tyle:UIAlertControllerStyleAlert
     actionBlock:^(NSInteger index) {
        NSLog(@"%ld",(long)index);
    }
     actionColors:@[[UIColor redColor], [UIColor yellowColor]]
     actionsStatement:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
