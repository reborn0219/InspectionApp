//
//  GJHomeButton.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/7.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJHomeButton.h"

@implementation GJHomeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //内部图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //文字对齐
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //设置字体颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //设置文字大小
        self.titleLabel.font = FZNavigationTitleFont;
        //高亮的时候不要调整内部图片为灰色
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}


-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imagey = 8;
    CGFloat imagew = 15;
    CGFloat imageh = 15;
    CGFloat imagex = CGRectGetMaxX(self.titleLabel.frame) + 5;
    return CGRectMake(imagex, imagey, imagew, imageh);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titlex = 0;
    CGFloat titley = 0;
    CGFloat titlew = self.width - self.height;
    CGFloat titleh = self.height;
    return CGRectMake(titlex, titley, titlew, titleh);
    
}


@end
