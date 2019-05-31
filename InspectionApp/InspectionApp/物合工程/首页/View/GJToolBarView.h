//
//  GJToolBarView.h
//  MeiLin
//
//  Created by 曹学亮 on 16/8/13.
//  Copyright © 2016年 Li Chuanliang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  @author cao, 16-08-13 18:08:03
 *
 *  pop视图底部按钮
 */
@interface GJToolBarView : UIView
@property (nonatomic,copy) void(^NoSoundBlock)(BOOL JYSelected);
@property (nonatomic,copy) void(^KnockOffBlock)();
@property (nonatomic,strong) UIButton *KnowOffButton;

@end
