//
//  XPQRotateMenu.m
//  XPQRotateMenu
//
//  Created by 谢攀琪 on 15/6/10.
//  Copyright (c) 2015年 谢攀琪. All rights reserved.
//

#import "XPQRotateMenu.h"

#define hideWith                25

@interface XPQRotateMenu ()
@property (nonatomic) NSMutableArray *menuItemArray;
@property (nonatomic, weak) UIButton *intersection;
@property (nonatomic, weak) UIImageView *backgroundImageView;
@end

@implementation XPQRotateMenu

#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configSelf];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configSelf];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSelf];
    }
    return self;
}

-(instancetype)initWithTitleArray:(NSArray *)array {
    self = [super init];
    if (self) {
        [self configSelf];
        [self configSubview:array];
    }
    return self;
}

-(void)configSelf {
    self.bounds = CGRectMake(0, 0, MenuItemHight, MenuItemHight);
    self.center = CGPointMake(5, [UIScreen mainScreen].bounds.size.height / 2);
    self.menuItemArray = [NSMutableArray array];
    self.time = 0.75;
    self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    super.backgroundColor = [self.backgroundColor colorWithAlphaComponent:0.0];
    self.showClockwise = YES;
    self.hideClockwise = NO;
    self.handleHideEnable = YES;
    _expand = NO;
        
    // 上滑响应
    UISwipeGestureRecognizer *upRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    upRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:upRecognizer];
    // 下滑响应
    UISwipeGestureRecognizer *downRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    downRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:downRecognizer];
}

-(void)configSubview:(NSArray *)title {
    if (title.count > 1) {
        for (NSInteger i = title.count - 1; i >= 0; i--) {
            XPQRotateItem *menuItem = [[XPQRotateItem alloc] initWithIndex:i target:self action:@selector(actionMenuItem:)];
            if ([title[i] isKindOfClass:[NSString class]]) {
                menuItem.title = title[i];
            }
            else if ([title[i] isKindOfClass:[NSAttributedString class]]) {
                menuItem.attributedTitle = title[i];
            }
            menuItem.transform = CGAffineTransformMakeRotation(M_PI);
            menuItem.center = CGPointMake(20, 20);
            [self addSubview:menuItem];
            [self.menuItemArray addObject:menuItem];
        }
        
        UIButton *intersection = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        intersection.center = CGPointMake(20, 20);
        [intersection setTitle:@"➕" forState:(UIControlStateNormal)];
        [intersection addTarget:self action:@selector(actionIntersection:) forControlEvents:(UIControlEventTouchUpInside)];
        self.intersection = intersection;
        [self addSubview:intersection];
    }
}

-(NSString *)description {
    return [NSString stringWithFormat:@"isExpand:%@ menuItem:%@", _expand ? @"YES" : @"NO", self.menuItemArray];
}

#pragma mark - 属性
-(void)setIntersectionImage:(UIImage *)intersectionImage {
    if (intersectionImage == nil) {
        [self.intersection setTitle:@"➕" forState:UIControlStateNormal];
    }
    else {
        [self.intersection setTitle:@"" forState:UIControlStateNormal];
    }
    [self.intersection setImage:intersectionImage forState:UIControlStateNormal];
}

-(UIImage *)intersectionImage {
    return [self.intersection imageForState:UIControlStateNormal];
}

-(void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    if (_backgroundImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectInset([UIScreen mainScreen].bounds, -20.0, 0.0)];
        [self insertSubview:imageView atIndex:0];
        _backgroundImageView = imageView;
    }
    _backgroundImageView.alpha = _expand ? 1.0 : 0.0;
    _backgroundImageView.image = _backgroundImage;
}

#pragma mark - 左右滑动
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    if (self.handleHideEnable) {
        [self hideMenu:(recognizer.direction == UISwipeGestureRecognizerDirectionDown)];
    }
}

#pragma mark - 点击
-(void)actionMenuItem:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(shouldClickMenuItem:)]) {
        if ([self.delegate shouldClickMenuItem:self.menuItemArray[sender.tag - MenuItemTag]] == NO) {
            return;
        }
    }
    
    [self hideMenu:self.hideClockwise];
    
    if ([self.delegate respondsToSelector:@selector(didClickMenuItem:)]) {
        [self.delegate didClickMenuItem:self.menuItemArray[sender.tag - MenuItemTag]];
    }
}

-(void)actionIntersection:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(shouldClickIntersection)]) {
        if ([self.delegate shouldClickIntersection] == NO) {
            return;
        }
    }
    
    if (self.expand) {
        [self hideMenu:self.hideClockwise];
    }
    else {
        [self showMenu:self.showClockwise];
    }
    
    if ([self.delegate respondsToSelector:@selector(didClickIntersection)]) {
        [self.delegate didClickIntersection];
    }
}

#pragma mark - 菜单显示隐藏
-(void)showMenu:(BOOL)isClockwise {
    if ([self.delegate respondsToSelector:@selector(shouldShowMenu)]) {
        if ([self.delegate shouldShowMenu] == NO) {
            return;
        }
    }
    
    if (!self.expand && self.menuItemArray.count > 1) {
        _expand = YES;
        
        [self rotateButtounAnimation:isClockwise];
        [self showBackgroundAnimation];
        [self showMenuItemAnimation:isClockwise];
    }
    
    if ([self.delegate respondsToSelector:@selector(didShowMenu)]) {
        [self.delegate didShowMenu];
    }
}

-(void)hideMenu:(BOOL)isClockwise {
    if ([self.delegate respondsToSelector:@selector(shouldHideMenu)]) {
        if ([self.delegate shouldHideMenu] == NO) {
            return;
        }
    }
    
    if (self.expand && self.menuItemArray.count > 1) {
        _expand = NO;
        
        [self rotateButtounAnimation:isClockwise];
        [self hideBackgroundAnimation];
        [self hideMenuItemAnimation:isClockwise];
    }
    
    if ([self.delegate respondsToSelector:@selector(didHideMenu)]) {
        [self.delegate didHideMenu];
    }
}

-(XPQRotateItem *)menuItemWithIndex:(NSInteger)index {
    return self.menuItemArray[index];
}

#pragma mark -动画
/**
 *  @brief  菜单项显示时的转动动画
 *  @param isClockwise 旋转方向，YES-顺时针,NO-逆时钟
 */
-(void)showMenuItemAnimation:(BOOL)isClockwise {
    CGFloat unitAngle = M_PI / (self.menuItemArray.count - 1) * 2 / 3;
    CGFloat angle = M_PI * 2 / 3;
    if (!isClockwise) {
        angle -= (2 * M_PI);
    }
    for (int i = 0; i < self.menuItemArray.count; i++) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0];
        animation.toValue = [NSNumber numberWithFloat:angle];
        animation.duration = self.time;
        animation.cumulative = YES;
        animation.additive = YES;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [((UIView*)self.menuItemArray[i]).layer addAnimation:animation forKey:@"rotationMenuItem"];
        
        angle += unitAngle;
    }
}

/**
 *  @brief  菜单项隐藏时的转动动画
 *  @param isUp 旋转方向，YES-顺时针,NO-逆时钟
 */
-(void)hideMenuItemAnimation:(BOOL)isClockwise {
    CGFloat unitAngle = M_PI / (self.menuItemArray.count - 1) * 2 / 3;
    CGFloat angle = (self.menuItemArray.count - 1) * unitAngle + M_PI * 2 / 3;
    if (isClockwise) {
        angle -= (2 * M_PI);
    }
    for (NSInteger i = self.menuItemArray.count - 1; i >= 0; i--) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:angle];
        animation.toValue = [NSNumber numberWithFloat:0];
        animation.duration = self.time;
        animation.cumulative = YES;
        animation.additive = YES;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [((UIView*)self.menuItemArray[i]).layer addAnimation:animation forKey:@"rotationMenuItem"];
        
        angle -= unitAngle;
    }
}

/**
 *  @brief  背景显示动画
 */
-(void)showBackgroundAnimation {
    // 先把背景铺满全屏，
    self.frame = CGRectMake(-20, 0, [UIScreen mainScreen].bounds.size.width + 25, [UIScreen mainScreen].bounds.size.height);
    // 和调整好按钮的位置
    self.intersection.center = CGPointMake(25, self.frame.size.height / 2);
    for (UIView *item in self.menuItemArray) {
        item.center = CGPointMake(25, self.frame.size.height / 2);
    }
    // 慢慢显示背景，并向右移动使菜单完全显示
    [UIView beginAnimations:@"showBackgroundAnimation" context:nil];
    [UIView setAnimationDuration:self.time];
    self.center = CGPointMake(self.center.x + 20, self.center.y);
    if (self.backgroundImageView != nil) {
        self.backgroundImageView.center = CGPointMake(self.backgroundImageView.center.x - 20, self.backgroundImageView.center.y);
        self.backgroundImageView.alpha = 1.0;
    }
    super.backgroundColor = self.backgroundColor;
    [UIView commitAnimations];
}

/**
 *  @brief  背景隐藏动画
 */
-(void)hideBackgroundAnimation {
    // 慢慢隐藏背景，并向左移动使部分菜单被遮掩
    [UIView beginAnimations:@"hideBackgroundAnimation" context:nil];
    [UIView setAnimationDuration:self.time];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(self.center.x - 20, self.center.y);
    if (self.backgroundImageView != nil) {
        self.backgroundImageView.center = CGPointMake(self.backgroundImageView.center.x + 20, self.backgroundImageView.center.y);
        self.backgroundImageView.alpha = 0.0;
    }
    super.backgroundColor = [self.backgroundColor colorWithAlphaComponent:0.0];
    [UIView commitAnimations];
}

-(void)rotateButtounAnimation:(BOOL)isClockwise {
    [UIView beginAnimations:@"test" context:nil];
    [UIView setAnimationDuration:self.time];
    // 交汇按钮转动
    if (isClockwise) {
        self.intersection.transform = CGAffineTransformRotate(self.intersection.transform, M_PI_4);
    }
    else {
        self.intersection.transform = CGAffineTransformRotate(self.intersection.transform, -M_PI_4);
    }
    [UIView commitAnimations];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    // 隐藏背景动画结束后把背景视图缩小
    if ([(NSString*)anim isEqualToString:@"hideBackgroundAnimation"]) {
        self.bounds = CGRectMake(0, 0, MenuItemHight, MenuItemHight);
        self.center = CGPointMake(5, [UIScreen mainScreen].bounds.size.height / 2);
        // 让菜单项和按钮看上去位置不变化
        self.intersection.center = CGPointMake(20, self.frame.size.height / 2);
        for (UIView *item in self.menuItemArray) {
            item.center = CGPointMake(20, self.frame.size.height / 2);
        }
    }
}
@end
