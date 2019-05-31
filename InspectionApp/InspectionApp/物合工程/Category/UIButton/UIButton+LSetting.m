//
//  UIButton+LSetting.m
//  物联宝管家
//
//  Created by yang on 2019/4/24.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "UIButton+LSetting.h"

@implementation UIButton (LSetting)
- (void)layoutButtonWithImageTitleSpace:(CGFloat)space {
    
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    
}
@end
