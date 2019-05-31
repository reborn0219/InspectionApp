//
//  GJOverTableViewOneCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/18.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJOverTableViewOneCell.h"


@implementation GJOverTableViewOneCell
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
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
    alable.backgroundColor = gycoloers;
    UILabel *blable = [[UILabel alloc]initWithFrame:CGRectMake(0, 79.5, W, 0.5)];
    blable.backgroundColor = gycoloers;
    [self addSubview:alable];
    [self addSubview:blable];
    //表头小图片
    self.FirstImagename = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 16, 16)];
    self.FirstImagename.image = [UIImage imageNamed:@"mlgj-2x34s"];
    // 单序号
    self.numberLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, W/2,20 )];
    self.numberLable.font = [UIFont fontWithName:geshi size:13];
    self.numberLable.textColor = gycoloer;
    
    //时间Lable
    self.wagetimeLable = [[UILabel alloc]initWithFrame:CGRectMake(W/2 + 25, 5, W/2 - 30, 20)];
    self.wagetimeLable.textAlignment = NSTextAlignmentRight;
    self.wagetimeLable.font = [UIFont fontWithName:geshi size:13];
    self.wagetimeLable.textColor = gycoloer;

    //    上线
    self.uplineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 30.5, W - 10, 0.5)];
    self.uplineLable.backgroundColor = gycoloers;

    //    内容
    self.bodytextLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, W-70, 20)];
    self.bodytextLable.font = ziti;
    self.bodytextLable.textColor = gycoloer;
    //    下线
    self.downLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 79.5, W - 10, 0.5)];
    self.downLable.backgroundColor = gycoloers;
    //   右侧尖号按钮
    self.rightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sssss"]];
    self.rightImageView.frame = CGRectMake(W - 30, 45, 20, 20);

    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 80, W, 8)];
    headview.backgroundColor = viewbackcolor;
  
    [self addSubview:headview];
    [self addSubview:self.rightImageView];
    [self addSubview:self.FirstImagename];
    [self addSubview:self.numberLable];
    [self addSubview:self.SecondImagename];
    [self addSubview:self.uplineLable];
    [self addSubview:self.downLable];
    [self addSubview:self.bodytextLable];
//    [self addSubview:self.wagetimeLable];
//    [self addSubview:rightImageview];
}
#pragma mark 返回高度的方法

+(CGFloat)height
{
    return 88;
}
//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJOverTableViewOneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJOverTableViewOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end
