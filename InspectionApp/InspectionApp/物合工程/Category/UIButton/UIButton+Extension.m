//
//  UIButton+Extension.m
//  物联宝家居
//
//  Created by 付智鹏 on 16/2/24.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
+(UIButton *)rightbuttonwithimageName:(NSString *)imagename target:(id)target action:(SEL)action
{
    UIButton *rightbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    rightbutton.backgroundColor = [UIColor clearColor];
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 22, 22)];
    imageview1.image = [UIImage imageWithName:imagename];
    [rightbutton addSubview:imageview1];
    [rightbutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return rightbutton;
}

+(UIButton *)leftbuttonwithimageName:(NSString *)imagename target:(id)target action:(SEL)action
{
    //左侧导航栏按钮
    UIButton *leftbutton = [[UIButton alloc]
                            initWithFrame:CGRectMake(0, 0, 25, 30)];
    leftbutton.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 20, 15)];
    imageview.image = [UIImage imageWithName:imagename];
    [leftbutton addSubview:imageview];
    [leftbutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return leftbutton;
}

+(UIButton *)rightbuttonwithtitleName:(NSString *)titlename target:(id)target action:(SEL)action{
    //右侧导航栏按钮
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightbutton.frame = CGRectMake(0, 0, 30, 30);
    rightbutton.backgroundColor = [UIColor clearColor];
    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(-25, 5, 70, 20)];
    titlelable.font = [UIFont fontWithName:geshi size:17];
    titlelable.textColor = [UIColor whiteColor];
    titlelable.textAlignment = NSTextAlignmentCenter;
    titlelable.text = titlename;
    [rightbutton addSubview:titlelable];
    [rightbutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return rightbutton;
}

//左菜单
+(UIButton *)leftMenuButtonwithimageName:(NSString *)imagename target:(id)target action:(SEL)action
{
    //左侧导航栏按钮
    UIButton *leftbutton = [[UIButton alloc]
                            initWithFrame:CGRectMake(0, 0, 30, 30)];
    leftbutton.backgroundColor = [UIColor clearColor];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(-5, 8, 20, 15)];
    imageview.image = [UIImage imageWithName:imagename];
    [leftbutton addSubview:imageview];
    [leftbutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return leftbutton;
}

//+(UIButton *)redrightbuttonwithimageName:(NSString *)imagename target:(id)target action:(SEL)action
//{
//    UIButton *rightbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    rightbutton.backgroundColor = [UIColor clearColor];
//    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(18, 0, 10, 10)];
//    redView.backgroundColor = [UIColor redColor];
//    redView.layer.cornerRadius = 5.0;
//    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 22, 22)];
//    imageview1.image = [UIImage imageWithName:imagename];
//    [rightbutton addSubview:imageview1];
//    [imageview1 addSubview:redView];
//    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
//    NSString *ISred  = [userdefaults objectForKey:@"wechatRed"];
//    if ([ISred isEqualToString:@"YES"]) {
//        redView.hidden = NO;
//    }else
//    {
//        redView.hidden = YES;
//    }
//    [rightbutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    return rightbutton;
//}




@end
