//
//  GJDispatchCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/9.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJDispatchCell.h"

@implementation GJDispatchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self createLable];
    }
    return self;
}

-(void)createLable
{
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 25, 25)];
    self.topImageView.image = [UIImage imageNamed:@"mlgjss"];
    
    self.topLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 40, 20)];
    self.topLable.text = @"编号 : ";
    self.topLable.textColor = gycoloer;
    self.topLable.font = [UIFont fontWithName:geshi size:13];
    
    self.numberLable = [[UILabel alloc]initWithFrame:CGRectMake(65, 5, 100, 20)];
    self.numberLable.textColor = gycoloer;
    self.numberLable.font = [UIFont fontWithName:geshi size:13];

    self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(170, 5, 100, 20)];
    self.timeLable.textColor = gycoloers;
    self.timeLable.font = [UIFont fontWithName:geshi size:11];
    
    
    self.dataLable = [[UILabel alloc]initWithFrame:CGRectMake(W - 103, 5, 100, 20)];
    self.dataLable.textColor = gycoloers;
    self.dataLable.font = [UIFont fontWithName:geshi size:12];
    
    
    self.lineLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 29.5, W - 10, 0.5)];
    self.lineLable .backgroundColor = gycoloer;
    
    self.contentLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, W - 40, 20)];
    self.contentLable.textColor = gycoloer;
    self.contentLable.font = [UIFont fontWithName:geshi size:12];

    
    self.rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 35, 20, 20)];
    self.rightImage.image = [UIImage imageNamed:@"sssss"];
    
    self.upLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
    self.upLable.backgroundColor = gycoloers;
    
    self.downLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 59.5, W, 0.5)];
    self.downLable.backgroundColor = gycoloers;
    
    [self addSubview:self.topImageView];
    [self addSubview:self.topLable];
    [self addSubview:self.numberLable];
    [self addSubview:self.timeLable];
    [self addSubview:self.dataLable];
    [self addSubview:self.lineLable];
    [self addSubview:self.contentLable];
    [self addSubview:self.rightImage];
    [self addSubview:self.upLable];
    [self addSubview:self.downLable];
}

//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJDispatchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJDispatchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
