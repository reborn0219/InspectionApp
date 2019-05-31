//
//  PPMembersView.h
//  物联宝管家
//
//  Created by yang on 2019/3/20.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PPMembersView : UIView
@property (nonatomic,copy) AlertBlock block;

@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *departmentLb;

@property (weak, nonatomic) IBOutlet UILabel *taskNoLb;
@property (weak, nonatomic) IBOutlet UILabel *taskLb;
@property (weak, nonatomic) IBOutlet UILabel *cardLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneLb;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImgV;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *stateView;

@end
