//
//  GJMyView.h
//  FZvovo
//
//  Created by 付智鹏 on 16/2/19.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyViewDelegate <NSObject>
-(void)buttonDidClicked:(UIButton *)sender;
-(void)newVCDidClicked:(UIButton *)sender;
@end
@interface GJMyView : UIScrollView
@property (nonatomic,assign)id<MyViewDelegate>delegates;
@property(nonatomic,strong)UITableView *tableView;
@end
