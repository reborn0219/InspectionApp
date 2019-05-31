//
//  GJAboutusView.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJAboutusView.h"
#define TabbarHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) // 适配iPhone x 底栏高度


@implementation GJAboutusView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //去除tableview线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = viewbackcolor;
        [self createdUI];
        [self createdCompany];
    }
    return self;
}
-(void)createdUI
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userdefaults objectForKey:@"aboutUsData"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:dic];
    
    if([dict[@"wechat"] isEqual:@"bjmeilin"]){
        //朱滴20180915版权信息改为美戴瑜洋
        NSLog(@"=-=-=-=-dic = %@",dict);
        [dict setObject:@"meidyy" forKey:@"wechat"];
        
    }
    if ([dict[@"email"] isEqual:@"kefu@meilin.cc"]) {
        [dict setObject:@"meidyy@meidyy.com" forKey:@"email"];
    }
    if ([dict[@"tel"] isEqual:@"400-8756-399"]) {
        [dict setObject:@"400-6836-524" forKey:@"tel"];
    }
    [userdefaults setObject:dict forKey:@"aboutUsData"];//重写缓存
    [userdefaults synchronize];//缓存有延迟
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(W/2 - 30, 15, 60, 60)];
    imageView.image = [UIImage imageNamed:@"180x180"];
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, W, 30)];
    alable.text = [NSString stringWithFormat:@"物联宝管家 %@",WLBGJV];
    alable.textColor = gycolor;
    alable.textAlignment = NSTextAlignmentCenter;
    alable.font = [UIFont fontWithName:geshi size:15];
    [self addSubview:imageView];
    [self addSubview:alable];
    NSArray *nameArray = [NSArray array];
    nameArray = @[@"免责声明",@"常见问题",@"官方微信",@"客服邮箱",@"服务热线"];
    NSArray *titlearray = [NSArray array];
    titlearray = @[dict[@"wechat"],dict[@"email"],dict[@"tel"]];
     self.aboutView = [[UIView alloc]initWithFrame:CGRectMake(0, 130, W, 201)];
     self.aboutView.backgroundColor = FZColor(245, 245, 245);
    for (int i = 0; i < nameArray.count; i++) {
        if (i > 1) {
            [self buttonWithCGRect:CGRectMake(0, 1+i*40, W, 40) Title:nameArray[i] Tag:i target:self action:@selector(aboutUsDidClicked:)];
            self.emailLable.text = titlearray[i - 2];
        }else
        {
            [self buttonWithCGRect:CGRectMake(0, 1+i*40, W, 40) Title:nameArray[i] Tag:i target:self action:@selector(aboutUsDidClicked:)];
        }
    }
}
-(void)buttonWithCGRect:(CGRect)rect Title:(NSString *)title Tag:(NSInteger)tags target:(id)target action:(SEL)action
{
    UILabel *uplable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
    UILabel *downlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 120.5, W, 0.5)];
    uplable.backgroundColor = gycoloers;
    downlable.backgroundColor = gycoloers;
    UIButton *button = [[UIButton alloc]initWithFrame:rect];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = tags;
    UILabel *leftlable = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 20)];
    leftlable.backgroundColor = [UIColor clearColor];
    leftlable.text = title;
    leftlable.textColor = gycolor;
    leftlable.font = [UIFont fontWithName:geshi size:16];
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 39.5, W - 15, 0.5)];
    lineLable.backgroundColor = gycoloers;
    UIImageView *rightImageview = [[UIImageView alloc]initWithFrame:CGRectMake(W - 30, 10, 20, 20)];
    rightImageview.image = [UIImage imageNamed:@"sssss"];
    self.emailLable = [[UILabel alloc] init];
    self.emailLable.frame = CGRectMake(leftlable.size.width, 10, W - leftlable.size.width - 30, 20);
    self.emailLable.textColor = gycolor;
    self.emailLable.textAlignment = NSTextAlignmentRight;
    self.emailLable.font = [UIFont fontWithName:geshi size:14];
    [button addSubview:self.emailLable];
    [self.aboutView addSubview:button];
    [button addSubview:leftlable];
    [button addSubview:lineLable];
    [button addSubview:rightImageview];
    [self.aboutView addSubview:uplable];
    [self.aboutView addSubview:downlable];
    [self addSubview:self.aboutView];
}


-(void)createdCompany
{
    
    UILabel *companyName = [[UILabel alloc]init];
    
    if (IS_iPhoneX) {
        companyName.frame=CGRectMake(0, H - 114-83, W , 15);

    }else{
        companyName.frame=CGRectMake(0, H - 114, W , 15);

        
    }
    companyName.text = @"北京美戴瑜洋（北京）国际商务服务有限公司";
    companyName.textColor = gycolor;
    companyName.textAlignment = NSTextAlignmentCenter;
    companyName.font = [UIFont fontWithName:geshi size:10];
    companyName.backgroundColor = [UIColor clearColor];
    UILabel *titleLable = [[UILabel alloc]init];
    if (IS_iPhoneX) {
        titleLable.frame=CGRectMake(0, H - 94-83, W,15);

    }else{
        titleLable.frame=CGRectMake(0, H - 94, W,15);

        
    }
 //Copyright © 2011-2018 WLB ALL Rights Reservered
    titleLable.text = @"MeiDaiYuYang(BeiJing) International Business Service Co.Ltd";
    titleLable.textColor = [UIColor orangeColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont fontWithName:geshi size:10];
    titleLable.backgroundColor = [UIColor clearColor];
    [self addSubview:companyName];
    [self addSubview:titleLable];
}


-(void)aboutUsDidClicked:(UIButton *)sender
{
    if (self.delegates && [self.delegates respondsToSelector:@selector(aboutUsDidClicked:)]) {
        [self.delegates aboutUsDidClicked:sender];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }

}

@end
