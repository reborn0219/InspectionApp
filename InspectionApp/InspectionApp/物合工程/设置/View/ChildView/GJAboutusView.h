//
//  GJAboutusView.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol aboutUsDidClickDelegate <NSObject>

-(void)aboutUsDidClicked:(UIButton *)buttontags;

@end


@interface GJAboutusView : UITableView
@property(nonatomic,strong)UILabel *emailLable;
@property(nonatomic,strong)UIView *aboutView;
@property(nonatomic,assign)id<aboutUsDidClickDelegate>delegates;
@end
