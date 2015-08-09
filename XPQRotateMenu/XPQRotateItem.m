//
//  XPQRotateItem.m
//  XPQRotateMenu
//
//  Created by 谢攀琪 on 15/6/10.
//  Copyright (c) 2015年 谢攀琪. All rights reserved.
//

#import "XPQRotateItem.h"

@interface XPQRotateItem ()
@property (nonatomic, weak) UIButton *button;
@end

@implementation XPQRotateItem

-(instancetype)initWithIndex:(NSInteger)index title:(NSString *)title target:(id)target action:(SEL)action {
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.height / 2;
    self = [super initWithFrame:CGRectMake(0, 0, itemWidth, MenuItemHight)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.center = CGPointMake(MenuItemAnchor, [UIScreen mainScreen].bounds.size.height / 2);
        self.layer.cornerRadius = 5;
        self.layer.anchorPoint = CGPointMake(MenuItemAnchor / [UIScreen mainScreen].bounds.size.width, 0.5);
        
        // 阴影效果
        self.layer.shouldRasterize = YES;
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(-2, -2);
        self.layer.shadowOpacity = 0.9;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(MenuItemHight + 10, 0, self.frame.size.width - 70, self.frame.size.height)];
        button.tag = MenuItemTag + index;
        [button setTitle:title forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
        self.button = button;
        [self addSubview:button];
    }
    
    return self;
}

-(NSInteger)index {
    return self.button.tag - MenuItemTag;
}

-(NSString *)title {
    return [self.button titleForState:(UIControlStateNormal)];
}
@end
