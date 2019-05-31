//
//  GJNewsChildView.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/15.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJNewsChildView.h"

@implementation GJNewsChildView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = viewbackcolor;
        [self createdUI];
    }
    return self;
}

-(void)createdUI
{
    UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, W, 40)];
    textView.backgroundColor = [UIColor whiteColor];
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, W - 10, 40)];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    UILabel *uplable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 1)];
    uplable.backgroundColor = gycoloers;
    UILabel *downLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, W , 1)];
    downLable.backgroundColor = gycoloers;
    [textView addSubview:uplable];
    [textView addSubview:downLable];
    [textView addSubview:_textField];
    [self addSubview:textView];
}


@end
