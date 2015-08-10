//
//  XPQRotateMenuDelegate.h
//  XPQRotateMenu
//
//  Created by RHC on 15/8/8.
//  Copyright (c) 2015年 谢攀琪. All rights reserved.
//

@protocol XPQRotateMenuDelegate <NSObject>
@optional

/**
 *  @brief  菜单即将显示，可以通过返回值来控制是否显示
 *  @return YES-菜单继续显示，NO-菜单取消显示
 */
-(BOOL)shouldShowMenu;

/**
 *  @brief  菜单显示完成
 */
-(void)didShowMenu;

/**
 *  @brief  菜单即将隐藏，可以通过返回值来控制是否隐藏
 *  @return YES-菜单继续隐藏，NO-菜单取消隐藏
 */
-(BOOL)shouldHideMenu;

/**
 *  @brief  菜单隐藏完成
 */
-(void)didHideMenu;

/**
 *  @brief  点击交汇处按钮，即将执行后续操作，可以通过返回值取消操作
 *  @return YES-继续执行，NO-取消执行
 */
-(BOOL)shouldClickIntersection;

/**
 *  @brief  点击交汇处按钮后续操作完成
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
 */
-(void)didClickMenuItem:(XPQRotateItem *)menuItem;

/**
 *  @brief  点击背景
 */
-(void)didClickBackground;
@end

