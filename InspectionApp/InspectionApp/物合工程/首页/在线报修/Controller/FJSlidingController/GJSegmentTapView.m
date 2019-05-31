//
//  GJSegmentTapView.m
//  GJSegmentTapView
//
//  Created by fujin on 15/6/20.
//  Copyright (c) 2015年 fujin. All rights reserved.
//
#import "GJSegmentTapView.h"
#define DefaultTextNomalColor [UIColor blackColor]
#define DefaultTextSelectedColor NAVCOlOUR
#define DefaultLineColor NAVCOlOUR
#define DefaultTitleFont 15
#define LineHeigh 3
@interface GJSegmentTapView ()
@property (nonatomic, strong)NSMutableArray *buttonsArray;
@property (nonatomic, strong)UIImageView *lineImageView;
@end
@implementation GJSegmentTapView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _buttonsArray = [[NSMutableArray alloc] init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeCommunityID) name:@"changeCommunityID" object:nil];

        //默认
        _textNomalColor    = DefaultTextNomalColor;
        _textSelectedColor = DefaultTextSelectedColor;
        _lineColor = DefaultLineColor;
        _titleFont = DefaultTitleFont;
    }
    return self;
}

-(void)addSubSegmentView
{
    [self.lineImageView removeFromSuperview];
    [self.buttonsArray removeAllObjects];
    float width = self.frame.size.width / _dataArray.count;
    for (int i = 0 ; i < _dataArray.count ; i++) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, self.frame.size.height)];
        if (i == 0 || i == 1 || i == 2 || i == 3) {
            UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(width - 0.5, 0, 0.5, self.frame.size.height)];
            linelable.backgroundColor = gycoloers;
            [_button addSubview:linelable];
        }
        UILabel *downlinelable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.size.height - 0.5,width, 0.5)];
        downlinelable.backgroundColor = gycoloers;
        [_button addSubview:downlinelable];
        _button.tag = i+1;
        _button.backgroundColor = [UIColor clearColor];
        [_button setTitle:[_dataArray objectAtIndex:i] forState:UIControlStateNormal];
        [_button setTitleColor:self.textNomalColor    forState:UIControlStateNormal];
        [_button setTitleColor:self.textSelectedColor forState:UIControlStateSelected];
        _button.titleLabel.font = [UIFont systemFontOfSize:_titleFont];
        [_button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        //默认第一个选中
        if (i == 0) {
            _button.selected = YES;
        }
        else{
            _button.selected = NO;
        }
        [self.buttonsArray addObject:_button];
        [self addSubview:_button];
    }
    self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - LineHeigh, width, LineHeigh)];
    self.lineImageView.backgroundColor = _lineColor;
    [self addSubview:self.lineImageView];
    
}

-(void)tapAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    __weak GJSegmentTapView *weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
       weakSelf.lineImageView.frame = CGRectMake(button.frame.origin.x, weakSelf.frame.size.height - LineHeigh, button.frame.size.width, LineHeigh);
    }];
    for (UIButton *subButton in self.buttonsArray) {
        if (button == subButton) {
            subButton.selected = YES;
        }
        else{
            subButton.selected = NO;
        }
    }
    if ([self.delegate respondsToSelector:@selector(selectedIndex:)]) {
        [self.delegate selectedIndex:button.tag -1];
    }
}
-(void)selectIndex:(NSInteger)index
{
    for (UIButton *subButton in self.buttonsArray) {
        if (index != subButton.tag) {
            subButton.selected = NO;
        }
        else{
            __weak GJSegmentTapView *weakSelf = self;
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.lineImageView.frame = CGRectMake(subButton.frame.origin.x, weakSelf.frame.size.height - LineHeigh, subButton.frame.size.width, LineHeigh);
            } completion:^(BOOL finished) {
                subButton.selected = YES;
            }];
        }
    }
}
#pragma mark -- set
-(void)setDataArray:(NSArray *)dataArray{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
        [self addSubSegmentView];
    }
}
-(void)setLineColor:(UIColor *)lineColor{
    if (_lineColor != lineColor) {
        self.lineImageView.backgroundColor = lineColor;
        _lineColor = lineColor;
    }
}
-(void)setTextNomalColor:(UIColor *)textNomalColor{
    if (_textNomalColor != textNomalColor) {
        for (UIButton *subButton in self.buttonsArray){
            [subButton setTitleColor:textNomalColor forState:UIControlStateNormal];
        }
        _textNomalColor = textNomalColor;
    }
}
-(void)setTextSelectedColor:(UIColor *)textSelectedColor{
    if (_textSelectedColor != textSelectedColor) {
        for (UIButton *subButton in self.buttonsArray){
            [subButton setTitleColor:textSelectedColor forState:UIControlStateSelected];
        }
        _textSelectedColor = textSelectedColor;
    }
}
-(void)setTitleFont:(CGFloat)titleFont{
    if (_titleFont != titleFont) {
        for (UIButton *subButton in self.buttonsArray){
            subButton.titleLabel.font = [UIFont systemFontOfSize:titleFont] ;
        }
        _titleFont = titleFont;
    }
}
-(void)changeCommunityID
{
    [self addSubSegmentView];
}
@end
