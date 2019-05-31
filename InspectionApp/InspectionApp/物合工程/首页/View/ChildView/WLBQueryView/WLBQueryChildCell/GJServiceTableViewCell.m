//
//  GJServiceTableViewCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/11.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJServiceTableViewCell.h"

@implementation GJServiceTableViewCell
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
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 15, 15)];
    self.topImageView.image = [UIImage imageNamed:@"xc_2x01"];
    
    self.topLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 80, 20)];
    self.topLable.text = @"34号楼-105";
    self.topLable.textColor = gycoloer;
    self.topLable.font = [UIFont fontWithName:geshi size:12];
    
    self.numberLable = [[UILabel alloc]initWithFrame:CGRectMake(110, 5, 100, 20)];
    self.numberLable.textColor = gycoloers;
    self.numberLable.font = [UIFont fontWithName:geshi size:10];
    self.numberLable.text = @"2016-3-10 15:33";
    
    self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(W-80, 5, 30, 20)];
    self.timeLable.textColor = gycoloers;
    self.timeLable.font = [UIFont fontWithName:geshi size:11];
    self.timeLable.text = @"状态:";
    
    self.dataLable = [[UILabel alloc]initWithFrame:CGRectMake(W - 50, 5, 40, 20)];
    self.dataLable.textColor = gycoloers;
    self.dataLable.font = [UIFont fontWithName:geshi size:12];
    self.dataLable.text = @"已完成";
    
    self.lineLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 29, W - 20, 1)];
    self.lineLable .backgroundColor = gycoloers;
    
    self.contentImageview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 35, 15, 15)];
    self.contentImageview.image = [UIImage imageNamed:@"xc_2x09"];
    
    self.contenttypelable = [[UILabel alloc]initWithFrame:CGRectMake(35, 35, 60, 20)];
    self.contenttypelable.text = @"[水工维修]";
    self.contenttypelable.textColor = gycoloer;
    self.contenttypelable.font = [UIFont fontWithName:geshi size:11];
    
    self.contentLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 35, W - 40, 20)];
    self.contentLable.textColor = gycoloer;
    self.contentLable.font = [UIFont fontWithName:geshi size:10];
    self.contentLable.text = @"我家洗衣机坏了,麻烦维修师傅修一下";
    
    
    self.rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 35, 20, 20)];
    self.rightImage.image = [UIImage imageNamed:@"sssss"];
    
    self.upLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 1)];
    self.upLable.backgroundColor = gycoloers;
    
    self.downLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 59, W, 1)];
    self.downLable.backgroundColor = gycoloers;
    
    [self addSubview:self.topImageView];
    [self addSubview:self.topLable];
    [self addSubview:self.numberLable];
    [self addSubview:self.timeLable];
    [self addSubview:self.dataLable];
    [self addSubview:self.lineLable];
    [self addSubview:self.contenttypelable];
    [self addSubview:self.contentImageview];
    [self addSubview:self.contentLable];
    [self addSubview:self.rightImage];
    [self addSubview:self.upLable];
    [self addSubview:self.downLable];
}

//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJServiceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
