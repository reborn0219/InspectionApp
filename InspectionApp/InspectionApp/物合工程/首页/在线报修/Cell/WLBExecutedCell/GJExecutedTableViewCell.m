//
//  GJExecutedTableViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/17.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJExecutedTableViewCell.h"

@interface GJExecutedTableViewCell()
{
    UIImageView *aimageView;
    UIButton *backButtonView;
}

@end


@implementation GJExecutedTableViewCell
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
    self.FirstImagename.image = [UIImage imageNamed:@"mlgj-2x34s"];
    
    // 单序号
    self.numberLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, W - 70,20 )];
    self.numberLable.font = [UIFont fontWithName:geshi size:14];
    self.numberLable.textColor = gycoloer;

    //上线
    self.uplineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 30.5, W - 10, 0.5)];
    self.uplineLable.backgroundColor = gycoloers;
//    //样式图片
//    self.SecondImagename = [[UIImageView alloc]initWithFrame:CGRectMake(15, 45 , 18, 18)];
//    self.SecondImagename.image = [UIImage imageNamed:@"mlgj-2x34s"];
    //内容
    self.bodytextLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, W-70, 20)];
    self.bodytextLable.font = ziti;
    self.bodytextLable.textColor = gycoloer;
    //下线
    self.downLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 80.5, W- 10, 0.5)];
    self.downLable.backgroundColor = gycoloers;
    self.personnameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 87, W/2 - 20, 20)];
    self.personnameLable.textColor = gycoloer;
    self.personnameLable.font = [UIFont fontWithName:geshi size:14];
    
    self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(W/2, 87, W/2 - 10, 20)];
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
//    [self addSubview:self.operateButton];
    [self addSubview:self.SecondImagename];
    [self addSubview:self.uplineLable];
    [self addSubview:self.downLable];
    [self addSubview:self.bodytextLable];
    [self addSubview:self.personnameLable];
    [self addSubview:self.timeLable];
    [self addSubview:self.rightImageView];
}
#pragma mark 返回高度的方法

+(CGFloat)height
{
    return 99;
}
//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJExecutedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJExecutedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
//-(void)operationButtonDidClicked:(UIButton *)sender
//{
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    backButtonView  = [[UIButton alloc]initWithFrame:window.frame];
//    backButtonView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
//    [backButtonView addTarget:self action:@selector(backbuttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
//    NSArray *namearray = [NSArray array];
//    namearray = @[@"标记完工",@"工单转移",@"标记无效"];
//    for (int i = 0 ; i < namearray.count; i ++) {
//        if (i == 0 || i == 1)
//        {
//            [self buttonWithCGRect:CGRectMake(0, (H - 160) + i * 50, W, 50) Title:namearray[i] arget:self action:@selector(wageTypeDidClicked:) Tag:i];
//            
//        }else
//        {
//            [self buttonWithCGRect:CGRectMake(0, H - 50, W, 50) Title:namearray[i] arget:self action:@selector(wageTypeDidClicked:) Tag:i];
//        }
//    }
//    [window addSubview:backButtonView];
//}
//-(UIButton *)buttonWithCGRect:(CGRect)rect Title:(NSString *)title arget:(id)target action:(SEL)action Tag:(int)tags
//{
//    UIButton *abutton = [[UIButton alloc]initWithFrame:rect];
//    abutton.backgroundColor = [UIColor whiteColor];
//    [abutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    abutton.tag = tags;
//    [abutton setTitle:title forState:UIControlStateNormal];
//    [abutton setTitleColor:gycolor forState:UIControlStateNormal];
//    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
//    lineLable.backgroundColor = gycoloers;
//    [abutton addSubview:lineLable];
//    [backButtonView addSubview:abutton];
//    return abutton;
//}
//-(void)wageTypeDidClicked:(UIButton *)sender
//{
//    if (sender.tag == 0) {
//        if (self.executeddelegates && [self.executeddelegates respondsToSelector:@selector(ExecutedCellDidClicked:)]){
//            [self.executeddelegates ExecutedCellDidClicked:self.operateButton.tag];
//            [backButtonView removeFromSuperview];
//        }
//        else
//        {
//            NSLog(@"协议方案未实现");
//        }
//    }else if(sender.tag == 1)
//    {
//        if (self.executeddelegates && [self.executeddelegates respondsToSelector:@selector(WagetransferDidClicked:)]){
//            [self.executeddelegates WagetransferDidClicked:self.operateButton.tag];
//            [backButtonView removeFromSuperview];
//        }
//        else
//        {
//            NSLog(@"协议方案未实现");
//        }
//        [sender removeFromSuperview];
//    }else
//    {
//       
//    }
////    [GJSVProgressHUD showErrorWithStatus:@"您不是管理员，无操作权限"];
//}

-(void)backbuttonDidClicked:(UIButton *)sender
{
    [sender removeFromSuperview];
}














@end
