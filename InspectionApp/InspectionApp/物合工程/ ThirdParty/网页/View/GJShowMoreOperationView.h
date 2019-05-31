//
//  GJShowMoreOperationView.h
//  MeiLin
//
//  Created by 曹学亮 on 16/9/19.
//  Copyright © 2016年 Li Chuanliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJShowMoreOperationView : UIView
@property (nonatomic,copy) void(^doneBlock)(NSString *selectIterm);
@property (nonatomic,copy) NSString *titleString;
- (void)showMenuView;
- (instancetype)initWithString:(NSString*)title DoneBlock:(void(^)(NSString *selectIterm))block;
@end
