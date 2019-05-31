//
//  GJQueryView.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/9.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJQueryView.h"

@implementation GJQueryView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createdUI];
    }
    return self;
}


-(void)createdUI
{
    NSArray *titleArray = @[@"客户信息",@"合同信息",@"房产信息",@"车辆信息",@"收费记录",@"服务历史记录"];
    for (int i = 0 ; i < 6;i++) {
        if (i > 2) {
        [self buttonWithCGRect:CGRectMake((i-3)*w, 64 + w, w, w) Imagename:[NSString stringWithFormat:@"mlgj-2x%d",(int)i+53] Titlable:titleArray[i] Tag:i];
        }else{
        [self buttonWithCGRect:CGRectMake(i * w, 64, w, w) Imagename:[NSString stringWithFormat:@"mlgj-2x%d",(int)i+53] Titlable:titleArray[i] Tag:i];
        }
    }
}


-(void)buttonWithCGRect:(CGRect)rect Imagename:(NSString *)imagename Titlable:(NSString *)lable Tag:(int)tags
{
    UIButton *abutton = [[UIButton alloc]initWithFrame:rect];
    abutton.backgroundColor = [UIColor clearColor];
    [abutton setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
    abutton.tag = tags;
    [abutton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(w/2 - 20, 20, 40, 40)];
    imageview.image = [UIImage imageNamed:imagename];
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, abutton.size.width, 10)];
    alable.font = [UIFont fontWithName:geshi size:14];
    alable.alpha = 0.7;
    alable.text = lable;
    alable.textAlignment = NSTextAlignmentCenter;
    [abutton addSubview:imageview];
    [abutton addSubview:alable];
    [self addSubview:abutton];
}


-(void)buttonDidClicked:(UIButton *)sender
{
    if (self.delegates && [self.delegates respondsToSelector:@selector(buttonDidClicked:)]) {
        [self.delegates buttonDidClicked:sender];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }

}






















@end
