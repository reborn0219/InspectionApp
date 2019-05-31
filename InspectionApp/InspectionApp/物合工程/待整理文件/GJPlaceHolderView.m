//
//  GJPlaceHolderView.m
//  MeiLin
//
//  Created by 曹学亮 on 16/9/10.
//  Copyright © 2016年 Li Chuanliang. All rights reserved.
//

#import "GJPlaceHolderView.h"
#import "Masonry.h"
#import "LCUIKit.h"

@interface GJPlaceHolderView()
@property (nonatomic,strong) UIImageView *placeHolderImage; //没数据时占位图片
@end

@implementation GJPlaceHolderView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self addSubview:self.placeHolderImage];
    [self.placeHolderImage mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).offset(-30);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    [self addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.placeHolderImage.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kSCREEN_WIDTH - 16);
    }];
}

#pragma mark - Setter && Getter
- (UIImageView *)placeHolderImage{
    if (!_placeHolderImage) {
        _placeHolderImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ios2x_1_09"]];
    }
    return _placeHolderImage;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = HexRGB(0xAEAEAE);
        _tipLabel.font = [UIFont systemFontOfSize:17];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"暂无数据";
    }
    return _tipLabel;
}

@end
