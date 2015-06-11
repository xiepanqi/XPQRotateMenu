//
//  XPQRotateItem.h
//  XPQRotateMenu
//
//  Created by 谢攀琪 on 15/6/10.
//  Copyright (c) 2015年 谢攀琪. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MenuItemTag         0x400

@interface XPQRotateItem : UIView
-(instancetype) initWithIndex:(NSInteger)index title:(NSString *)title target:(id)target action:(SEL)action;
/// 菜单项索引
@property (nonatomic, readonly) NSInteger index;
/// 菜单项标题
@property (nonatomic, readonly) NSString *title;
@end
