//
//  GJMyUpCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/23.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJMyUpCell.h"

@implementation GJMyUpCell
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
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.userImageView = [[UIImageView alloc]init];
    self.userImageView.frame = CGRectMake(10, 7, 60, 60);
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width * 0.5;
    self.userImageView.layer.borderColor = NAVCOlOUR.CGColor;
    self.userImageView.layer.borderWidth = 0.5;
    self.nicknameLable = [[UILabel alloc]initWithFrame:CGRectMake(74, 15, W - 100, 20)];
    self.nicknameLable.backgroundColor = [UIColor clearColor];
    self.nicknameLable.textAlignment = NSTextAlignmentLeft;
    self.nicknameLable.textColor = gycolor;
    self.nicknameLable.font = [UIFont fontWithName:geshi size:16];
    
    
    
    
    
    
    
    
    
    
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 27.5, 20, 20)];
    UILabel *uplable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
    uplable.backgroundColor = gycoloers;
    UILabel *downlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 74.5, W, 0.5)];
    downlable.backgroundColor = gycoloers;
    [self addSubview:downlable];
    [self addSubview:uplable];

    [self addSubview:self.nicknameLable];
    [self addSubview:self.userImageView];
    [self addSubview:self.iconImageView];
}
//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJMyUpCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJMyUpCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
