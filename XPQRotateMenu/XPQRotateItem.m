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

-(instancetype)initWithIndex:(NSInteger)index target:(id)target action:(SEL)action {
    CGFloat itemWidth = [UIScreen mainScreen].bounds.size.height / 2;
    self = [super initWithFrame:CGRectMake(0, 0, itemWidth, MenuItemHight)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.anchorPoint = CGPointMake(MenuItemAnchor / ScreenWidth, 0.5);
        
        // 阴影效果
        self.layer.shouldRasterize = YES;
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(-2, 2);
        self.layer.shadowOpacity = 0.9;
        
        _isLeft = YES;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(MenuItemHight + 10, 0, self.frame.size.width - 70, self.frame.size.height)];
        button.tag = MenuItemTag + index;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        self.button = button;
        [self addSubview:button];
    }
    
    return self;
}

-(NSInteger)index {
    return self.button.tag - MenuItemTag;
}

-(NSString *)title {
    return [self.button titleForState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title {
    [self.button setTitle:title forState:UIControlStateNormal];
}

-(NSAttributedString *)attributedTitle {
    return [self.button attributedTitleForState:UIControlStateNormal];
}

-(void)setAttributedTitle:(NSAttributedString *)attributedTitle {
    [self.button setAttributedTitle:attributedTitle forState:UIControlStateNormal];
}

-(void)setUpShadow:(BOOL)upShadow {
    _upShadow = upShadow;
    self.layer.shadowOffset = CGSizeMake(-2, upShadow ? 2 : -2);    
}

-(void)setIsLeft:(BOOL)isLeft {
    _isLeft = isLeft;
    if (isLeft) {
        self.button.frame = CGRectMake(MenuItemHight + 10, 0, self.frame.size.width - 70, self.frame.size.height);
        self.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.layer.anchorPoint = CGPointMake(MenuItemAnchor / ScreenWidth, 0.5);
    }
    else {
        self.button.frame = CGRectMake(20, 0, self.frame.size.width - 70, self.frame.size.height);
        self.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.layer.anchorPoint = CGPointMake(1 - MenuItemAnchor / ScreenWidth, 0.5);
    }
}

-(NSString *)description {
    NSString *title = self.title;
    NSString *attTitle = self.attributedTitle.string;
    NSString *returnStr;
    if (title == nil || [title isEqualToString:@""]) {
        returnStr = [NSString stringWithFormat:@"attTitle:%@ index:%ld", attTitle, self.index];
    }
    else {
        returnStr = [NSString stringWithFormat:@"title:%@ index:%ld", title, self.index];
    }
    return returnStr;
}
@end
