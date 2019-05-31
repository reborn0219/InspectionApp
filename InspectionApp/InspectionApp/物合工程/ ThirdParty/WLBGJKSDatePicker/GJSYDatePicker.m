//
//  GJSYDatePicker.m
//  DatePickerDemo
//
//  Created by Apple on 16/3/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "GJSYDatePicker.h"

@implementation GJSYDatePicker
{
    UIButton *disMissButton;
}

- (void)showInView:(UIView *)view withFrame:(CGRect)frame andDatePickerMode:(UIDatePickerMode)mode{
    self.frame = frame;
    disMissButton = [[UIButton alloc]initWithFrame:view.frame];
    disMissButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    self.backgroundColor = [UIColor whiteColor];
    if(!self.picker){
        self.picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 8, frame.size.width, frame.size.height - 8)];
    }
    self.picker.datePickerMode = mode;
    [self.picker addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.picker];
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
    btnDone.frame = CGRectMake(8, 8, 50, 30);
    [btnDone setTitle:@"取消" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(CancelDone) forControlEvents:UIControlEventTouchUpInside];
    UIButton *cancleDone = [UIButton buttonWithType:UIButtonTypeSystem];
    cancleDone.frame = CGRectMake(kScreen_Width - 58, 8, 50, 30);
    [cancleDone setTitle:@"确定" forState:UIControlStateNormal];
    [cancleDone addTarget:self action:@selector(pickDone) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleDone];
    [self addSubview:btnDone];
    [disMissButton addSubview:self];
    [view addSubview:disMissButton];
    self.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 0);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = frame;
    }];
}

- (void)pickDone{
    if (![self.picker respondsToSelector:@selector(valueChanged:)]) {
        [self.delegate picker:self.picker ValueChanged:self.picker.date];
    }
    [disMissButton removeFromSuperview];
}

-(void)CancelDone
{
    [disMissButton removeFromSuperview];
}

- (void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
         self.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)valueChanged:(UIDatePicker *)picker{
    if([self.delegate respondsToSelector:@selector(picker:ValueChanged:)]){
        [self.delegate picker:picker ValueChanged:picker.date];
    }
}

@end
