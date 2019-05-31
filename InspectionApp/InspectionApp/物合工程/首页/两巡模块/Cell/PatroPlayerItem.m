//
//  PatroPlayerItem.m
//  物联宝管家
//
//  Created by yang on 2019/3/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatroPlayerItem.h"
#import "ColorDefinition.h"
@interface PatroPlayerItem()
@end
@implementation PatroPlayerItem

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _backView.clipsToBounds = YES;
    _backView.layer.cornerRadius = 10;
    _backShadowView.layer.cornerRadius = 10;
    _backShadowView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _backShadowView.layer.shadowOffset = CGSizeMake(0,0);
    _backShadowView.layer.shadowOpacity = 0.2;
    _backShadowView.layer.shadowRadius = 2;
    
}

@end
