//
//  GJOwnChildView.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/16.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJOwnChildView.h"

@implementation GJOwnChildView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createdLeftTableview];
        [self createdRightTableView];
//        [self createdUI];
    }
    return self;
}
-(void)createdLeftTableview
{
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, W/3 - 20, self.size.height - 104)];
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableView.backgroundColor = viewbackcolor;
    UILabel *uplinelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W/3, 1)];
    uplinelable.backgroundColor = viewbackcolor;
    [self.leftTableView addSubview:uplinelable];
    UILabel *downlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 249, W/3, 1)];
    downlable.backgroundColor = gycoloers;
//    [self.leftTableView addSubview:downlable];
    [self addSubview:self.leftTableView];
}

-(void)createdRightTableView
{
    self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.leftTableView.size.width + 5, 5, W/3*2 + 20, self.size.height - 104)];
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.backgroundColor = viewbackcolor;
    UILabel *uplinelable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W/3*2, 1)];
    uplinelable.backgroundColor = gycoloers;
    [self.rightTableView addSubview:uplinelable];
    [self addSubview:self.rightTableView];
}


@end
