//
//  XPQRotateMenu.h
//  XPQRotateMenu
//
//  Created by 谢攀琪 on 15/6/10.
//  Copyright (c) 2015年 谢攀琪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPQRotateItem.h"
#import "XPQRotateMenuDelegate.h"

/**
 菜单交汇点位置。
 */
typedef enum : NSUInteger {
    XPQRotateMenuDependPositionLeft,
    XPQRotateMenuDependPositionLeftDown,
    XPQRotateMenuDependPositionLeftUp,
    XPQRotateMenuDependPositionRight,
    XPQRotateMenuDependPositionRightDown,
    XPQRotateMenuDependPositionRightUp,
} XPQRotateMenuDependPosition;

@interface XPQRotateMenu : UIView
/// 动画时间,默认0.75
@property (nonatomic) NSTimeInterval time;
/// 展开时背景色，默认r:0.5 g:0.5 r:0.5 a:1.0
@property (nonatomic) UIColor *backgroundColor;
/// 是否展开
@property (nonatomic, readonly, getter=isExpand) BOOL expand;
/// 是否上方菜单放上面
@property (nonatomic) BOOL isUpToTop;
/// 交汇处按钮图片
@property (nonatomic) UIImage *intersectionImage;
/// 背景图片，默认nil
@property (nonatomic) UIImage *backgroundImage;
/// 菜单显示时是向上方向，默认YES
@property (nonatomic) BOOL showClockwise;
/// 菜单隐藏时是向上方向，默认NO
@property (nonatomic) BOOL hideClockwise;
/// 启用上下滑动手势隐藏菜单,默认YES
@property (nonatomic) BOOL handleHideEnable;
/// 交汇点位置
@property (nonatomic) XPQRotateMenuDependPosition dependPosition;
/// 代理
@property (nonatomic, weak) id<XPQRotateMenuDelegate> delegate;

/**
 *  @brief 根据一个数组来创建菜单项
 *  @param  array   要创建的菜单项标题，可以是NSString或者NSAttributedString
 *  @return 创建的对象
 */
-(instancetype)initWithTitleArray:(NSArray *)array;

/**
 *  @brief  显示菜单
 *  @param  isClockwise 旋转方向，YES-顺时针,NO-逆时钟
 *  @return void
 */
-(void)showMenu:(BOOL)isClockwise;

/**
 *  @brief  隐藏菜单
 *  @param  isClockwise 旋转方向，YES-顺时针,NO-逆时钟
 *  @return void
 */
-(void)hideMenu:(BOOL)isClockwise;

/**
 *  @brief  根据索引返回对应的菜单项，如果index大于菜单数则返回nil
 *  @param  index   要查找的索引
 *  @return 索引对应的菜单项
 */
-(XPQRotateItem *)menuItemWithIndex:(NSInteger)index;
@end
