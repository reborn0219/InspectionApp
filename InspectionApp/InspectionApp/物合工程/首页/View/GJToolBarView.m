//
//  GJToolBarView.m
//  MeiLin
//
//  Created by 曹学亮 on 16/8/13.
//  Copyright © 2016年 Li Chuanliang. All rights reserved.
//

#import "GJToolBarView.h"
#import "AW_Constants.h"
#import "Masonry.h"

@interface GJToolBarView()
@property (nonatomic,strong) UIButton *noSoundButton;
@property (nonatomic,strong) CAShapeLayer *topLayer;
@property (nonatomic,strong) CAShapeLayer *middleLayer;
@end

@implementation GJToolBarView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self addSubview:self.noSoundButton];
    [self.noSoundButton mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
    }];
    
    [self addSubview:self.KnowOffButton];
    [self.KnowOffButton mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.left.equalTo(self.noSoundButton.mas_right);
    }];
    
    [self.layer addSublayer:self.topLayer];
    [self.layer addSublayer:self.middleLayer];
}

#pragma mark - Event Response
- (void)orderDetail{
    _noSoundButton.selected=!_noSoundButton.selected;
    if (_noSoundButton.selected==YES) {
        [_noSoundButton setTitle:@"取消静音" forState:UIControlStateNormal];
    }else{
        
        [_noSoundButton setTitle:@"静音" forState:UIControlStateNormal];

    }
    if (_NoSoundBlock) {
        _NoSoundBlock(_noSoundButton.selected);
    }
}

- (void)orderMap{
    if (_KnockOffBlock) {
        _KnockOffBlock();
    }
}

#pragma mark - Setter && Getter
- (UIButton *)noSoundButton{
    if (!_noSoundButton) {
        _noSoundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_noSoundButton setTitle:@"静音" forState:UIControlStateNormal];
        [_noSoundButton setTitleColor:MainYellowColor forState:UIControlStateNormal];
        _noSoundButton.selected=NO;
        [_noSoundButton addTarget:self action:@selector(orderDetail) forControlEvents:UIControlEventTouchUpInside];
      
        _noSoundButton.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _noSoundButton;
}

- (UIButton *)KnowOffButton{
    if (!_KnowOffButton) {
        _KnowOffButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _KnowOffButton.backgroundColor=MainYellowColor;
        
        [_KnowOffButton addTarget:self action:@selector(orderMap) forControlEvents:UIControlEventTouchUpInside];
        
        

    }
    return _KnowOffButton;
}

-(CAShapeLayer*)topLayer{
    if (!_topLayer) {
        _topLayer = [[CAShapeLayer alloc]init];
        CGFloat lineHeight = 1.0f/([UIScreen mainScreen].scale);
        _topLayer.frame = Rect(0,0,kSCREEN_WIDTH,lineHeight);
        _topLayer.backgroundColor = RGBLINE.CGColor;
    }
    return _topLayer;
}

-(CAShapeLayer*)middleLayer{
    if (!_middleLayer) {
        _middleLayer = [[CAShapeLayer alloc]init];
        CGFloat lineHeight = 1.0f/([UIScreen mainScreen].scale);
        _middleLayer.frame = Rect(SCREEN_WIDTH/2 - 20,0,lineHeight,45);
        _middleLayer.backgroundColor = RGBLINE.CGColor;
    }
    return _middleLayer;
}

@end
