//
//  ViewController.m
//  XPQRotateMenu
//
//  Created by 谢攀琪 on 15/6/10.
//  Copyright (c) 2015年 谢攀琪. All rights reserved.
//

#import "ViewController.h"
#import "XPQRotateMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *arr = @[@"菜单1",@"菜单2",@"菜单3",@"菜单4",@"菜单5",@"菜单6",@"菜单7",@"菜单8",@"菜单9",@"菜单10"];
    XPQRotateMenu *menu = [[XPQRotateMenu alloc] initWithTitleArray:arr];
    menu.intersectionImage = [UIImage imageNamed:@"cancleIcon"];
    [self.view addSubview:menu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
