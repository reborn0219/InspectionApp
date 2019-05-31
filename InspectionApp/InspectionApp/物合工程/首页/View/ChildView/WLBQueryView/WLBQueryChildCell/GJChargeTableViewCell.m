//
//  GJChargeTableViewCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/11.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJChargeTableViewCell.h"

@implementation GJChargeTableViewCell

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
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    self.topImageView.image = [UIImage imageNamed:@"mlgjss"];
    
    self.dataLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 100, 20)];
    self.dataLable.textColor = gycoloer;
    self.dataLable.font = [UIFont fontWithName:geshi size:12];
    
    self.stateLable = [[UILabel alloc]initWithFrame:CGRectMake(W - 60, 5, 100, 20)];
    self.stateLable.textColor = NAVCOlOUR;
    self.stateLable.font = [UIFont fontWithName:geshi size:13];
    
    self.lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 29, W - 30, 1)];
    self.lineLable.backgroundColor = gycoloers;

    
    self.contentliftLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, 40, 20)];
    self.contentliftLable.textColor = gycoloer;
    self.contentliftLable.font = [UIFont fontWithName:geshi size:12];

    self.contentLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 35, W - 40, 20)];
    self.contentLable.textColor = gycoloer;
    self.contentLable.font = [UIFont fontWithName:geshi size:12];
    
    
    self.rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 35, 20, 20)];
    self.rightImage.image = [UIImage imageNamed:@"sssss"];
    
    self.upLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 1)];
    self.upLable.backgroundColor = gycoloers;
    
    self.downLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 59, W, 1)];
    self.downLable.backgroundColor = gycoloers;
    
    [self addSubview:self.topImageView];
    [self addSubview:self.contentliftLable];
    [self addSubview:self.stateLable];
    [self addSubview:self.dataLable];
    [self addSubview:self.lineLable];
    [self addSubview:self.contentLable];
    [self addSubview:self.rightImage];
    [self addSubview:self.upLable];
    [self addSubview:self.downLable];
}

//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJChargeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJChargeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}



@end
