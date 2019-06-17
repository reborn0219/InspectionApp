//
//  MyViewControllerCell.m
//  物联宝管家
//
//  Created by guokang on 2019/5/25.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "MyViewControllerCell.h"

@implementation MyViewControllerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setIsHidden:(BOOL)isHidden
{
    if (isHidden == YES) {
        self.clickBtn.hidden = YES;
    }else{
        self.clickBtn.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
