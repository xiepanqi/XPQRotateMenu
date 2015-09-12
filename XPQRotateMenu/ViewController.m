//
//  ViewController.m
//  XPQRotateMenu
//
//  Created by 谢攀琪 on 15/6/10.
//  Copyright (c) 2015年 谢攀琪. All rights reserved.
//

#import "ViewController.h"
#import "XPQRotateMenu.h"

@interface ViewController () <XPQRotateMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"我是一个特别的菜单"];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,4)];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,3)];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(7,2)];
    [attriString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:20.0] range:NSMakeRange(0, 4)];
    [attriString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0] range:NSMakeRange(4, 3)];
    [attriString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:20.0] range:NSMakeRange(7, 2)];

    
    NSArray *arr = @[@"菜单1",@"菜单2",@"菜单3",@"菜单4",attriString,@"菜单6",@"菜单7",@"菜单8",@"菜单9"];
    XPQRotateMenu *menu = [[XPQRotateMenu alloc] initWithTitleArray:arr];
    menu.intersectionImage = [UIImage imageNamed:@"cancleIcon"];
//    menu.backgroundColor = [UIColor whiteColor];
//    menu.backgroundImage = [UIImage imageNamed:@"1430121054613"];
//    menu.isUpToTop = NO;
    menu.delegate = self;
    
    [self.view addSubview:menu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didClickMenuItem:(XPQRotateItem *)menuItem {
    NSLog(@"%@", menuItem);
}

@end
