//
//  GJOverTableViewOneCell.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/18.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJOverTableViewOneCell : UITableViewCell
@property(nonatomic,strong)UIImageView *FirstImagename;
@property(nonatomic,strong)UILabel *SerialLable;
@property(nonatomic,strong)UILabel *numberLable;
@property(nonatomic,strong)UIButton *operateButton;

@property(nonatomic,strong)UIImageView *SecondImagename;
@property(nonatomic,strong)UILabel *uplineLable;
@property(nonatomic,strong)UILabel *downLable;

@property(nonatomic,strong)UILabel *bodytextLable;
@property(nonatomic,strong)UILabel *personnameLable;
@property(nonatomic,strong)UILabel *wagetimeLable;
@property(nonatomic,strong)UIImageView *rightImageView;

@property(nonatomic,strong)UIButton *coverButton;
@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)UIAlertView *alert;
#pragma mark 返回高度的方法
+(CGFloat)height;

#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
