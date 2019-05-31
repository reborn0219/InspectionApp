//
//  UIButton+Extension.h
//  物联宝家居
//
//  Created by 付智鹏 on 16/2/24.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
//右侧导航栏按钮
+(UIButton *)rightbuttonwithimageName:(NSString *)imagename target:(id)target action:(SEL)action;
//左侧导航栏按钮
+(UIButton *)leftbuttonwithimageName:(NSString *)imagename target:(id)target action:(SEL)action;

//右侧导航栏按钮(文字)
+(UIButton *)rightbuttonwithtitleName:(NSString *)titlename target:(id)target action:(SEL)action;
//左侧导航栏菜单
+(UIButton *)leftMenuButtonwithimageName:(NSString *)imagename target:(id)target action:(SEL)action;

//+(UIButton *)redrightbuttonwithimageName:(NSString *)imagename target:(id)target action:(SEL)action;
@end
