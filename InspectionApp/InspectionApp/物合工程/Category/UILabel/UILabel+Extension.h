//
//  UILabel+Extension.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/11.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
+(UILabel *)lableWithName:(NSString *)name;
- (void) textLeftTopAlign;
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end
