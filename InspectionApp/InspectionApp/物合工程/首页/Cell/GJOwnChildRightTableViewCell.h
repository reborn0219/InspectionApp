//
//  GJOwnChildRightTableViewCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/16.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GJOwnChildRightTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *topimageView;
@property(nonatomic,strong)UILabel *leftLables;
@property(nonatomic,strong)UIImageView *rightImageview;
@property(nonatomic,strong)UIImageView *realImageView;
@property(nonatomic,strong)UILabel *RealLable;
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
