//
//  GJFZPPulldownMenuView.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/4/15.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJFZPPulldownMenuView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tv;//下拉列表
    NSArray *tableArray;//下拉列表数据
    UIButton *MenuButton;//底层button
    UILabel *leftLable;//左侧titlelable
    UILabel *rightLable;//显示数据Lable
    UIImageView *rightImageView;//显示角标图片
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
}
@property (nonatomic,retain) UITableView *tv;
@property (nonatomic,retain) NSArray *tableArray;
@property (nonatomic,retain) UIButton *MenuButton;
@property(nonatomic,strong)UILabel *leftLable;
@property(nonatomic,strong)UILabel *rightLable;
@end
