//
//  GJrunLabel.m
//  GJrunLabel
//
//  Created by 梁伟杰 on 16/6/6.
//  Copyright © 2016年 梁伟杰. All rights reserved.
//

#import "GJrunLabel.h"

//默认16字体
#define DefFont [UIFont systemFontOfSize:16]

@interface GJrunLabel ()
@property (strong, nonatomic) UILabel* label;
@property (copy, nonatomic) NSString* text;
@end

@implementation GJrunLabel

- (instancetype)initWithFrame:(CGRect)frame andText:(NSString*) text
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        _text = text;
        [self setupLabel];
        [self run];
    }
    return self;
}

- (void) setupLabel {
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    _label.font = DefFont;
    [self addSubview:_label];
}
-(void)runlabel
{
    _label.text = _text;
    CGFloat height = self.frame.size.height;
    CGRect bounds = [_text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _label.font} context:nil];
    CGRect frame = _label.frame;
    frame.size.height = height;
    frame.size.width = bounds.size.width;
    frame.origin.x = self.frame.size.width;
    _label.frame = frame;
    [UIView beginAnimations:@"GJrunLabel" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:8];
    [UIView setAnimationRepeatCount:99999];
    [UIView setAnimationRepeatAutoreverses:NO];
    
    frame = _label.frame;
    frame.origin.x = -frame.size.width;
    _label.frame = frame;
    
    [UIView commitAnimations];


}
- (void) run {
    _label.text = _text;
    CGFloat height = self.frame.size.height;
    CGRect bounds = [_text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _label.font} context:nil];
    CGRect frame = _label.frame;
    frame.size.height = height;
    frame.size.width = bounds.size.width;
    frame.origin.x = self.frame.size.width;
    _label.frame = frame;
    [UIView beginAnimations:@"GJrunLabel" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:8];
    [UIView setAnimationRepeatCount:99999];
    [UIView setAnimationRepeatAutoreverses:NO];
    
    frame = _label.frame;
    frame.origin.x = -frame.size.width;
    _label.frame = frame;
    
    [UIView commitAnimations];
}

- (void)setText:(NSString*) text {
    _text = text;
    [self run];
}

- (void)setFont:(UIFont*) font {
    _label.font = font;
    [self run];
}

- (void)setTextColor:(UIColor*) color {
    _label.textColor = color;
    [self run];
}
@end
