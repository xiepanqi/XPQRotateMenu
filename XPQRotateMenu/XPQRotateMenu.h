//
//  XPQRotateMenu.h
//  XPQRotateMenu
//
//  Created by 谢攀琪 on 15/6/10.
//  Copyright (c) 2015年 谢攀琪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPQRotateItem.h"

@protocol XPQRotateMenuDelegate <NSObject>
@optional
/**
 *  @brief  菜单即将显示，可以通过返回值来控制是否显示
 *  @return YES-菜单继续显示，NO-菜单取消显示
 */
-(BOOL)shouldShowMenu;
/**
 *  @brief  菜单显示完成
 *  @return void
 */
-(void)didShowMenu;
/**
 *  @brief  菜单即将隐藏，可以通过返回值来控制是否隐藏
 *  @return YES-菜单继续隐藏，NO-菜单取消隐藏
 */
-(BOOL)shouldHideMenu;
/**
 *  @brief  菜单隐藏完成
 *  @return void
 */
-(void)didHideMenu;
/**
 *  @brief  点击交汇处按钮，即将执行后续操作，可以通过返回值取消操作
 *  @return YES-继续执行，NO-取消执行
 */
-(BOOL)shouldClickIntersection;
/**
 *  @brief  点击交汇处按钮后续操作完成
 *  @return void
 */
-(void)didClickIntersection;
/**
 *  @brief  点击菜单项，即将执行后续操作，可以通过返回值取消操作
 *  @param  menuItem    点击的菜单项
 *  @return YES-继续执行，NO-取消执行
 */
-(BOOL)shouldClickMenuItem:(XPQRotateItem *)menuItem;
/**
 *  @brief  点击菜单项后续操作完成
 *  @param  menuItem    点击的菜单项
 *  @return void
 */
-(void)didClickMenuItem:(XPQRotateItem *)menuItem;
@end

@interface XPQRotateMenu : UIView
/// 是否展开
@property (nonatomic, readonly) BOOL expand;
/// 交汇处按钮图片
@property (nonatomic) UIImage *intersectionImage;
/// 菜单显示时是向上方向，默认YES
@property (nonatomic) BOOL showDireUp;
/// 菜单隐藏时是向上方向，默认NO
@property (nonatomic) BOOL hideDireUp;
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
 *  @param  array 动画方向，YES-自下至上，NO-自上至下
 *  @return void
 */
-(void)showMenu:(BOOL)direUp;

/**
 *  @brief  隐藏菜单
 *  @param  array 动画方向，YES-自下至上，NO-自上至下
 *  @return void
 */
-(void)hideMenu:(BOOL)direUp;

/**
 *  @brief  根据索引返回对应的菜单项，如果index大于菜单数则返回nil
 *  @param  index   要查找的索引
 *  @return 索引对应的菜单项
 */
-(XPQRotateItem *)menuItemWithIndex:(NSInteger)index;
@end
