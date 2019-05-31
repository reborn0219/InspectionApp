//
//  GJTableView.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/9.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJTableView.h"

@implementation GJTableView
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
    
    self.leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, W/2+1, 40)];
    _leftbutton.selected = YES;
     self.rightbutton = [[UIButton alloc]initWithFrame:CGRectMake(W/2+0.5, 64, W/2, 40)];
    _leftbutton.tag = 1;
    _rightbutton.tag = 2;
    [_leftbutton addTarget:self action:@selector(ButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_rightbutton addTarget:self action:@selector(ButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(W/2 - 1, 5, 1, 30)];
    alable.backgroundColor = gycoloers;
    
    [_leftbutton setTitle:@"扫码生成" forState:UIControlStateNormal];
    _leftbutton.titleLabel.font = [UIFont fontWithName:geshi size:15];
    _rightbutton.titleLabel.font = [UIFont fontWithName:geshi size:15];
    [_leftbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_leftbutton setTitleColor:NAVCOlOUR forState:UIControlStateSelected];
    [_rightbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightbutton setTitleColor:NAVCOlOUR forState:UIControlStateSelected];
    _leftbutton.backgroundColor = [UIColor whiteColor];
    _rightbutton.backgroundColor = [UIColor whiteColor];
    [_rightbutton setTitle:@"手动输入" forState:UIControlStateNormal];
    [_leftbutton addSubview:alable];
    [self addSubview:_leftbutton];
    [self addSubview:_rightbutton];
    
//    self.sweepView = [[GJTableSweepView alloc]initWithFrame:CGRectMake(0, 0, W, H - 105)];
    self.tabview = [[UITableView alloc]initWithFrame:CGRectMake(W, 0, W, H - 105)];
    self.tabview.backgroundColor = viewbackcolor;
    self.tabview.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self createdTableView];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 104, W, H)];
    self.scrollView.contentSize = CGSizeMake(2*W, H);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
//    [self.scrollView addSubview:self.sweepView];
    [self.scrollView addSubview:self.tabview];
    [self addSubview:self.scrollView];
    self.bottomLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 102, W/2-60, 3)];
    self.bottomLable.backgroundColor = FZColor(110, 185,43);
    [self addSubview:self.bottomLable];
}

-(void)ButtonDidClicked:(UIButton *)sender
{
    if (sender.tag == 2) {
        self.leftbutton.selected = NO;
        self.rightbutton.selected = YES;
        self.bottomLable.x = W/2 + 30;
        self.scrollView.contentOffset = CGPointMake(W, 0);
    }
    else
    {
        self.rightbutton.selected = NO;
        self.leftbutton.selected = YES;
        self.bottomLable.x = 30;
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
}

-(void)createdTableView
{
    [self viewWithtitle:@"房间号" textFiled:@"北京青年汇三期1栋1102" CGRect:CGRectMake(0, 10, W, 40)];
    [self viewWithtitle:@"联系人" textFiled:@"张三丰" CGRect:CGRectMake(0, 55, W, 40)];
    [self viewWithtitle:@"手机号" textFiled:@"18241232142" CGRect:CGRectMake(0, 100, W, 40)];
    [self viewWithtitle:@"本月度数" textFiled:@"1240°" CGRect:CGRectMake(0, 145, W, 40)];
    [self viewWithtitle:@"抄表日期" textFiled:@"2016-03-15 16:44:21" CGRect:CGRectMake(0, 190, W, 40)];

    
}

-(void)viewWithtitle:(NSString *)title textFiled:(NSString *)text CGRect:(CGRect )rect
{
    UIView *aview = [[UIView alloc]initWithFrame:rect];
    aview.backgroundColor = [UIColor whiteColor];
    UILabel *uplable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W , 1)];
    uplable.backgroundColor = gycoloers;
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 80, 20)];
    titleLable.font = [UIFont fontWithName:geshi size:15];
    titleLable.text = title;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = gycolor;
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 1, 40)];
    lineLable.backgroundColor = gycoloers;
    UITextField *textLable = [[UITextField alloc]initWithFrame:CGRectMake(91, 10, W - 80, 20)];
    textLable.placeholder = text;
    textLable.font = [UIFont fontWithName:geshi size:15];
    textLable.textColor = gycoloer;
    
    UILabel *downLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, W, 1)];
    downLable.backgroundColor = gycoloers;
    [aview addSubview:uplable];
    [aview addSubview:titleLable];
    [aview addSubview:lineLable];
    [aview addSubview:textLable];
    [aview addSubview:downLable];
    [self.tabview addSubview:aview];
}




@end
