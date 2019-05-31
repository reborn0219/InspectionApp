//
//  WLBAttendanceOwnTopView.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/30.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJAttendanceOwnTopHeadView.h"

@implementation GJAttendanceOwnTopHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createdUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)createdUI
{
    self.HeadportraitImageview = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 50, 50)];
    self.HeadportraitImageview.layer.masksToBounds = YES;
    self.HeadportraitImageview.layer.cornerRadius = self.HeadportraitImageview.bounds.size.width*0.5;
    self.usernameLable = [[UILabel alloc]initWithFrame:CGRectMake(80, 15, W - 95, 20)];
    self.departmentLable = [[UILabel alloc]initWithFrame:CGRectMake(80, 40, 50, 15)];
    self.usernameLable.textColor = gycolor;
    self.departmentLable.textColor = gycoloer;
    self.usernameLable.font = [UIFont fontWithName:geshi size:16];
    self.departmentLable.font = [UIFont fontWithName:geshi size:13];
    self.yearLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, w, 15)];
    self.mouthLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 85, w/2, 40)];
    self.mouthwordLable = [[UILabel alloc]initWithFrame:CGRectMake(w/2, 90, w/2, 40)];
    self.attendanceLable = [[UILabel alloc]initWithFrame:CGRectMake(w, 75, w, 15)];
    self.dayLable = [[UILabel alloc]initWithFrame:CGRectMake(w, 100, w, 20)];
    self.lateLable = [[UILabel alloc]initWithFrame:CGRectMake(2*w, 75, w, 15)];
    self.latenumLable = [[UILabel alloc]initWithFrame:CGRectMake(2*w, 100, w, 20)];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *normal = [NSString stringWithFormat:@"%@",[userDefaults objectForKey:@"normal"]];
    NSString *actual = [NSString stringWithFormat:@"%@",[userDefaults objectForKey:@"actual"]];
    NSString *sign_month = [userDefaults objectForKey:@"sign_month"];
    NSString *sign_year = [userDefaults objectForKey:@"sign_year"];
    self.yearLable.text = sign_year;
    self.mouthLable.text = sign_month;
    self.mouthwordLable.text = @"月";
    self.attendanceLable.text = @"应出勤";
    self.dayLable.text = normal;
    self.lateLable.text = @"实出勤";
    self.latenumLable.text = actual;
    
    self.yearLable.textAlignment = NSTextAlignmentCenter;
    self.mouthLable.textAlignment = NSTextAlignmentRight;
    self.mouthwordLable.textAlignment = NSTextAlignmentLeft;
    self.attendanceLable.textAlignment = NSTextAlignmentCenter;
    self.dayLable.textAlignment = NSTextAlignmentCenter;
    self.lateLable.textAlignment = NSTextAlignmentCenter;
    self.latenumLable.textAlignment = NSTextAlignmentCenter;
    
    
    self.yearLable.textColor = gycolor;
    self.mouthLable.textColor = gycoloer;
    self.mouthwordLable.textColor = gycoloer;
    self.attendanceLable.textColor = gycolor;
    self.dayLable.textColor = gycoloer;
    self.lateLable.textColor = gycolor;
    self.latenumLable.textColor = gycoloer;
    
    
    self.yearLable.font = [UIFont fontWithName:geshi size:14];
    self.mouthLable.font = [UIFont fontWithName:geshi size:30];
    self.mouthwordLable.font = [UIFont fontWithName:geshi size:14];
    self.attendanceLable.font = [UIFont fontWithName:geshi size:14];
    self.dayLable.font = [UIFont fontWithName:geshi size:14];
    self.lateLable.font = [UIFont fontWithName:geshi size:14];
    self.latenumLable.font = [UIFont fontWithName:geshi size:14];
    UILabel *verticalLable = [[UILabel alloc]initWithFrame:CGRectMake(w - 1, 75, 1, 45)];
    verticalLable.backgroundColor = gycoloers;
    UILabel *uplineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
    uplineLable.backgroundColor = gycoloers;
    UILabel *downlineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 129.5, W, 0.5)];
    downlineLable.backgroundColor = gycoloers;
    [self addSubview:verticalLable];
    [self addSubview:uplineLable];
    [self addSubview:downlineLable];
    [self addSubview:self.HeadportraitImageview];
    [self addSubview:self.usernameLable];
    [self addSubview:self.departmentLable];
    [self addSubview:self.yearLable];
    [self addSubview:self.mouthLable];
    [self addSubview:self.mouthwordLable];
    [self addSubview:self.attendanceLable];
    [self addSubview:self.dayLable];
    [self addSubview:self.lateLable];
    [self addSubview:self.latenumLable];
}
@end
