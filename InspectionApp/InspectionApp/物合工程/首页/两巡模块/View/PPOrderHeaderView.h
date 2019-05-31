//
//  PPOrderHeaderView.h
//  物联宝管家
//
//  Created by yang on 2019/3/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTaskDetailModel.h"

@interface PPOrderHeaderView : UIView
@property(nonatomic,copy)AlertBlock block;
-(void)assignmentWithModel:(PPTaskDetailModel *)model Type:(NSInteger)type;


@end
