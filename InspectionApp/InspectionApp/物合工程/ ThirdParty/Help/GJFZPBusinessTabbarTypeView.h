//
//  GJFZPBusinessTabbarTypeView.h
//  FZPMXN
//
//  Created by ovov on 16/4/22.
//  Copyright © 2016年 ovov. All rights reserved.
//


#import <UIKit/UIKit.h>


@protocol SunSegmentViewDelegate <NSObject>

@required
- (void)SunSegmentClick:(NSInteger)index;
@optional



@end



@interface GJFZPBusinessTabbarTypeView : UIView{
    
    
}


- (id)initWithFrame:(CGRect)frame withViewCount:(NSInteger)viewCount withNormalColor:(UIColor *)normal_color withSelectColor:(UIColor *)select_color withNormalTitleColor:(UIColor *)normal_titlecolor  withSelectTitleColor:(UIColor *)select_titlecolor;

@property(nonatomic,assign) NSInteger selectIndex;
@property(nonatomic,strong) NSArray *titleArray;


@property(nonatomic,strong) UIFont *titleFont;

@property(nonatomic,strong)UIButton *redButton;

@property (weak) NSObject <SunSegmentViewDelegate> *segmentDelegate;

@end




