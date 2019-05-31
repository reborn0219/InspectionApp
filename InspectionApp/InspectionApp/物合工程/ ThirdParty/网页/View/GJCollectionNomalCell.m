//
//  GJCollectionNomalCell.m
//  MeiLin
//
//  Created by 曹学亮 on 16/9/19.
//  Copyright © 2016年 Li Chuanliang. All rights reserved.
//

#import "GJCollectionNomalCell.h"
#import "GJCollectionNormalModel.h"
#import "Masonry.h"
#import "LCUIKit.h"
#import "AW_Constants.h"

@interface GJCollectionNomalCell()
@property (nonatomic,strong) UIButton *itermButton;
@end

@implementation GJCollectionNomalCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.itermButton];
    [self.itermButton mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

#pragma mark - Event Response
- (void)selectIterm{
    if (_didSelectedItermBlock) {
        _didSelectedItermBlock(_normalModel);
    }
}

#pragma mark -  Setter && Getter
- (UIButton *)itermButton{
    if (!_itermButton) {
        _itermButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itermButton setTitleColor:RGBTEXTINFO forState:UIControlStateNormal];
        _itermButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_itermButton addTarget:self action:@selector(selectIterm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _itermButton;
}

- (void)setNormalModel:(GJCollectionNormalModel *)normalModel{
    if (!normalModel) {
        return;
    }
    _normalModel = normalModel;
    [_itermButton setImage:[UIImage imageNamed:_normalModel.imageName] forState:UIControlStateNormal];
    [_itermButton setTitle:_normalModel.titleName forState:UIControlStateNormal];
    [self.itermButton lc_imageTitleVerticalAlignmentWithSpace:5];
}

@end
