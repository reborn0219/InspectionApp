//
//  GJMyView.m
//  FZvovo
//
//  Created by 付智鹏 on 16/2/19.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJMyView.h"
#import "GJSetUpController.h"
#import "GJNavigationController.h"
#import "GJmyViewController.h"
@class GJmyViewController;
@interface GJMyView()
@end
@implementation GJMyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, W, H)];
        self.tableView.backgroundColor = viewbackcolor;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self addSubview:self.tableView];
        [self createdUI3];
    }
    return self;
}
-(void)createdUI3
{
        [self buttonRectWith:CGRectMake(0, 5, W, 35) Lable:@"设置" imagename:@"mlgj-2x28" target:self action:@selector(shezhi:)tag:6];
}

-(UIButton *)buttonRectWith:(CGRect)rect Lable:(NSString *)lable imagename:(NSString *)imagename target:(id)target action:(SEL)action tag:(int)tags
{
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor whiteColor];
    [button setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
    button.frame = rect;
    button.tag = tags;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 18, 18)];
    imageview.image = [UIImage imageNamed:imagename];
    
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(38, 9, 80, 18)];
    lable1.text = lable;
    lable1.font = [UIFont fontWithName:geshi size:15];
    lable1.alpha = 0.6;
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(W-30 , 7, 20, 20)];
    imageview1.image = [UIImage imageNamed:@"sssss"];
    
//    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, W-10, 0.5)];
//    lable2.backgroundColor = FZColor(220, 220, 220);
//    [button addSubview:lable2];
    [button addSubview:imageview1];
    [button addSubview:imageview];
    [button addSubview:lable1];
    [self.tableView addSubview:button];
    return button;
}

-(UILabel *)lableWithrect:(CGRect)rect
{
    UILabel *lable = [[UILabel alloc]initWithFrame:rect];
    lable.backgroundColor = FZColor(220, 220, 220);
    [self.tableView addSubview:lable];
    return lable;
}
-(void)shezhi:(UIButton *)sender
{
    if (self.delegates && [self.delegates respondsToSelector:@selector(buttonDidClicked:)]) {
        [self.delegates buttonDidClicked:sender];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
    
}
@end
