//
//  GJCusInView.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/11.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJCusInView.h"

@implementation GJCusInView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = viewbackcolor;
        [self createdViewUI];
    }
    return self;
}

-(void)createdViewUI
{
    NSArray *namearray = [NSArray array];
    namearray = @[@"客户名称 :",@"手       机 :",@"地       址 :",@"E - m a i l :"];
    for (int i = 0; i < 4; i++)
    {
    [self titleWithName:namearray[i] Frame:CGRectMake(15, 80+41*i, W - 30, 40)];
    }
    UIButton *determineButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 300, W - 80, 50)];
    [determineButton setBackgroundImage:[UIImage imageNamed:@"dl_1x14"] forState:UIControlStateNormal];
    [determineButton setTitle:@"查询" forState:UIControlStateNormal];
    [self addSubview:determineButton];
    [determineButton addTarget:self action:@selector(determineButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)titleWithName:(NSString *)name Frame:(CGRect)rect
{
    UIView *aview = [[UIView alloc]initWithFrame:rect];
    aview.backgroundColor = [UIColor whiteColor];
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 80, 20)];
    alable.text = name;
    alable.textColor = gycoloer;
    alable.backgroundColor = [UIColor clearColor];
    self.textFiled = [[UITextField alloc]initWithFrame:CGRectMake(90,10, aview.size.width - alable.size.width, 20)];
    _textFiled.backgroundColor = [UIColor clearColor];
    [aview addSubview:alable];
    [aview addSubview:_textFiled];
    [self addSubview:aview];
}


-(void)determineButtonDidClicked
{
    if (self.delegates && [self.delegates respondsToSelector:@selector(determineDidClicked)]) {
        [self.delegates determineDidClicked];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}














@end
