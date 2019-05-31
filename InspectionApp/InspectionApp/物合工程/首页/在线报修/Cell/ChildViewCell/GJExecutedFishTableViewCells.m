//
//  GJExecutedFishTableViewCells.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/27.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJExecutedFishTableViewCells.h"

@implementation GJExecutedFishTableViewCells
{
    UIImageView *moneyImageView;
    UIImageView *WeChatImageView;
    BOOL ISMoney;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createdUI];
    }
    return self;
}

+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJExecutedFishTableViewCells *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJExecutedFishTableViewCells alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(void)createdUI
{
    _leftLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, W/2 - 15,20)];
    _leftLable.textColor = gycoloer;
    _leftLable.font = [UIFont fontWithName:geshi size:13];
    _leftLable.textAlignment = NSTextAlignmentLeft;
    _leftLable.text = @"付款方式";
    [self addSubview:_leftLable];
    
    
    
//    

    
    UILabel *downLineLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 39.5, W - 10, 0.5)];
    downLineLable.backgroundColor = gycoloers;
    [self addSubview:downLineLable];
}
////付款方式点击事件
//-(void)moneyButtonDidClicked
//{
//    ISMoney = YES;
////    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:2];
////    [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//}
//-(void)wechatButtonDidClicked
//{
//    ISMoney = NO;
//    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:2];
////    [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    UIButton *disCoverButton = [[UIButton alloc]initWithFrame:window.frame];
//    disCoverButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
//    [disCoverButton addTarget:self action:@selector(discoverDisMiss:) forControlEvents:UIControlEventTouchUpInside];
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2 - 80, HEIGHT/2 - 80, 160, 160)];
//    imageView.image = [UIImage imageNamed:@"180x180"];
//    [disCoverButton addSubview:imageView];
//    [window addSubview:disCoverButton];
//    
//}


@end
