//
//  GJMyCenterCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/23.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJMyCenterCell.h"

@implementation GJMyCenterCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createLable];
    }
    return self;
}

-(void)createLable
{
    self.LeftcellButton = [[UIButton alloc]initWithFrame:CGRectMake(0,1, W/3, 51)];
    self.LeftcellButton.backgroundColor = [UIColor whiteColor];
    [self.LeftcellButton addTarget:self action:@selector(cellButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.LeftcellButton setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
    self.LeftcellButton.tag = 100;
    self.Leftlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, W/3, 25)];
    self.Leftlable.textColor = FZColor(76, 76, 76);
    self.Leftlable.font = [UIFont fontWithName:geshi size:19];
    self.Leftlable.textAlignment = NSTextAlignmentCenter;
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, W/3, 15)];
    lable1.textColor = FZColor(160, 160, 160);
    lable1.font = [UIFont fontWithName:geshi size:13];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.text = @"累计工单";
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(W/3 - 1, 10, 1, 31)];
    lineLable.backgroundColor = gycoloers;
    [self.LeftcellButton addSubview:lineLable];
    [self.LeftcellButton addSubview:self.Leftlable];
    [self.LeftcellButton addSubview:lable1];
    
    
    self.CentercellButton = [[UIButton alloc]initWithFrame:CGRectMake(W/3,1, W/3, 51)];
    self.CentercellButton.backgroundColor = [UIColor whiteColor];
    [self.CentercellButton addTarget:self action:@selector(cellButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.CentercellButton setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
    self.CentercellButton.tag = 101;
    self.Centerlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, W/3, 25)];
    self.Centerlable.textColor = FZColor(76, 76, 76);
    self.Centerlable.font = [UIFont fontWithName:geshi size:19];
    self.Centerlable.textAlignment = NSTextAlignmentCenter;
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, W/3, 15)];
    lable2.textColor = FZColor(160, 160, 160);
    lable2.font = [UIFont fontWithName:geshi size:13];
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.text = @"累计投诉";
    UILabel *lineLables = [[UILabel alloc]initWithFrame:CGRectMake(W/3 - 1, 10, 1, 31)];
    lineLables.backgroundColor = gycoloers;
    [self.CentercellButton addSubview:lineLables];
    [self.CentercellButton addSubview:self.Centerlable];
    [self.CentercellButton addSubview:lable2];
    
    
    self.RightcellButton = [[UIButton alloc]initWithFrame:CGRectMake(W - W/3,1, W/3, 51)];
    self.RightcellButton.backgroundColor = [UIColor whiteColor];
    [self.RightcellButton addTarget:self action:@selector(cellButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.RightcellButton setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
    self.RightcellButton.tag = 102;
    self.Rightlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, W/3, 25)];
    self.Rightlable.textColor = FZColor(76, 76, 76);
    self.Rightlable.font = [UIFont fontWithName:geshi size:19];
    self.Rightlable.textAlignment = NSTextAlignmentCenter;
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, W/3, 15)];
    lable3.textColor = FZColor(160, 160, 160);
    lable3.font = [UIFont fontWithName:geshi size:13];
    lable3.textAlignment = NSTextAlignmentCenter;
    lable3.text = @"累计咨询";
    [self.RightcellButton addSubview:self.Rightlable];
    [self.RightcellButton addSubview:lable3];
    
    
    UILabel *uplable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
    uplable.backgroundColor = gycoloers;
    UILabel *downlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 52.5, W, 0.5)];
    downlable.backgroundColor = gycoloers;
    [self addSubview:downlable];
    [self addSubview:uplable];
    [self addSubview:self.LeftcellButton];
    [self addSubview:self.CentercellButton];
    [self addSubview:self.RightcellButton];
    
}
//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJMyCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJMyCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

-(void)cellButtonDidClicked:(UIButton *)sender
{
    if (self.centerCellDelegates && [self.centerCellDelegates respondsToSelector:@selector(MycenterCellDidClicked:)]) {
        [self.centerCellDelegates MycenterCellDidClicked:sender.tag];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}



@end
