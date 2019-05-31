//
//  GJFZPPullDownMenu.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJFZPPullDownMenu : UIButton<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView  *tableView;//菜单
@property(nonatomic,strong)UIButton *Cellbutton;//低层button
@property(nonatomic,strong)NSArray *dataArray;//存储数据
@property(nonatomic,strong)UILabel *leftLable;//显示左侧标题lable
@property(nonatomic,strong)UILabel *rightLable;//显示数据Lable
@property(nonatomic,strong)UIImageView *rightImageView;//显示角标图片
@end
