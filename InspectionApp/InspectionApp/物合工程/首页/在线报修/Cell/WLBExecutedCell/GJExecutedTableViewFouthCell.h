//
//  GJExecutedTableViewFouthCell.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/18.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ExecutedCellFouthDelegate <NSObject>

//-(void)ExecutedCellDidClicked:(NSInteger)index;
-(void)WagetransferDidClicked:(NSInteger)index;

@end

@interface GJExecutedTableViewFouthCell : UITableViewCell
@property(nonatomic,strong)UIImageView *FirstImagename;
@property(nonatomic,strong)UILabel *SerialLable;
@property(nonatomic,strong)UILabel *numberLable;
//@property(nonatomic,strong)UIButton *operateButton;
//@property(nonatomic,strong)UILabel *dataLable;
@property(nonatomic,strong)UIImageView *SecondImagename;
@property(nonatomic,strong)UILabel *uplineLable;
@property(nonatomic,strong)UILabel *downLable;
@property(nonatomic,strong)UIImageView *urgentimageView;
@property(nonatomic,strong)UILabel *bodytextLable;
@property(nonatomic,strong)UILabel *personnameLable;
@property(nonatomic,strong)UILabel *timeLable;
//@property(nonatomic,strong)UIButton *dispatchButton;
//@property(nonatomic,strong)UIButton *invalidButton;
@property(nonatomic,strong)UIImageView *rightImageView;
@property(nonatomic,strong)UIButton *coverButton;
@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)UIAlertView *alert;

@property(nonatomic,assign)id<ExecutedCellFouthDelegate>executedFouthDelegates;
#pragma mark 返回高度的方法
+(CGFloat)height;

#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
