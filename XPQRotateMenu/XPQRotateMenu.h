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

@interface XPQRotateMenu : UIView
/// 是否展开
@property (nonatomic, readonly, getter=isExpand) BOOL expand;
/// 交汇处按钮图片
@property (nonatomic) UIImage *intersectionImage;
/// 菜单显示时是向上方向，默认YES
@property (nonatomic) BOOL showClockwise;
/// 菜单隐藏时是向上方向，默认NO
@property (nonatomic) BOOL hideClockwise;
/// 启用上下滑动手势隐藏菜单,默认YES
@property (nonatomic) BOOL handleHideEnable;
/// 代理
@property (nonatomic, weak) id<XPQRotateMenuDelegate> delegate;

/**
 *  @brief 根据一个数组来创建菜单项
 *  @param  array   要创建的菜单项标题，必须是你是NSString
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
