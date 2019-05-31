//
//  GJExecutedTableViewThreeCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/18.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJExecutedTableViewThreeCell.h"
@interface GJExecutedTableViewThreeCell()
{
    UIImageView *aimageView;
    UIButton *backButtonView;
}

@end
@implementation GJExecutedTableViewThreeCell

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
    UILabel *blable = [[UILabel alloc]initWithFrame:CGRectMake(0, 110.5, W, 0.5)];
    blable.backgroundColor = gycoloers;
    [self addSubview:alable];
    [self addSubview:blable];
    //表头小图片
    self.FirstImagename = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 16, 16)];
    self.FirstImagename.image = [UIImage imageNamed:@"mlgj-2x35s"];
    
    // 单序号
    self.numberLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, W - 70,20 )];
    self.numberLable.font = [UIFont fontWithName:geshi size:14];
    self.numberLable.textColor = gycoloer;

    //    上线
    self.uplineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 30.5, W - 10, 0.5)];
    self.uplineLable.backgroundColor = gycoloers;

    //    下线
    self.downLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 80.5, W- 10, 0.5)];
    self.downLable.backgroundColor = gycoloers;
    


    self.personnameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 87, W/2 - 20, 20)];
    self.personnameLable.textColor = gycoloer;
    self.personnameLable.font = [UIFont fontWithName:geshi size:14];
    
    self.timeLable = [[UILabel alloc]init];
    self.timeLable.textColor = gycoloer;
    self.timeLable.font = [UIFont fontWithName:geshi size:14];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 110, W, 8)];
    headview.backgroundColor = viewbackcolor;
    //   右侧尖号按钮
    self.rightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sssss"]];
    self.rightImageView.frame = CGRectMake(W - 30, 45, 20, 20);
    
    [self addSubview:headview];
    [self addSubview:self.FirstImagename];
    [self addSubview:self.SerialLable];
    [self addSubview:self.numberLable];
    [self addSubview:self.operateButton];
    [self addSubview:self.SecondImagename];
    [self addSubview:self.uplineLable];
    [self addSubview:self.downLable];
    [self addSubview:self.bodytextLable];
    [self addSubview:self.personnameLable];
    [self addSubview:self.timeLable];
    [self addSubview:self.rightImageView];
}
-(void)backbuttonDidClicked:(UIButton *)sender
{
    [sender removeFromSuperview];
}
+(CGFloat)height
{
    return 108;
}
//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJExecutedTableViewThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GJExecutedTableViewThreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    else{
        for (UIView *ve in cell.contentView.subviews) {
            [ve removeFromSuperview];
        }
        
    }
    return cell;

}


@end
