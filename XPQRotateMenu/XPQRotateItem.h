//
//  XPQRotateItem.h
//  XPQRotateMenu
//
//  Created by 谢攀琪 on 15/6/10.
//  Copyright (c) 2015年 谢攀琪. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MenuItemHight       40
#define MenuItemAnchor      20          // MenuItemAnchor = MenuItemHight / 2

#define MenuItemTag         0x400

@interface XPQRotateItem : UIView
/**
 *  @brief  初始化菜单项
 *  @param index  索引
 *  @param target 目标
 *  @param action 回调函数
 *  @return 菜单项指针
 */
-(instancetype) initWithIndex:(NSInteger)index upShadow:(BOOL)upShadow target:(id)target action:(SEL)action;

/// 菜单项索引
@property (nonatomic, readonly) NSInteger index;
/// 标题
@property (nonatomic) NSString *title;
/// 带属性标题
@property (nonatomic) NSAttributedString *attributedTitle;
@end
