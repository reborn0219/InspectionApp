//
//  GJWageSecondImageTableViewCell.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/28.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJWageSecondImageTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *FirstImagename;
@property(nonatomic,strong)UILabel *SerialLable;
@property(nonatomic,strong)UILabel *numberLable;
@property(nonatomic,strong)UILabel *dataLable;
@property(nonatomic,strong)UIImageView *SecondImagename;
@property(nonatomic,strong)UILabel *uplineLable;
@property(nonatomic,strong)UILabel *downLable;
@property(nonatomic,strong)UIImageView *urgentimageView;
@property(nonatomic,strong)UILabel *timeLable;
@property(nonatomic,strong)UIImageView *rightImageView;
#pragma mark 返回高度的方法
+(CGFloat)height;

#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
