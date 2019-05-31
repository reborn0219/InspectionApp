//
//  OrderBottomView.m
//  物联宝管家
//
//  Created by yang on 2019/3/20.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "OrderBottomView.h"
#import "PPViewTool.h"

@implementation OrderBottomView

-(void)awakeFromNib{
    [super awakeFromNib];
    [_rightBtn.layer insertSublayer:[PPViewTool setGradualChangingColor:_rightBtn] atIndex:0];

}
- (IBAction)leftBtnAction:(id)sender {
    if (_block) {
        _block(1);
    }
}
- (IBAction)rightBtnAction:(id)sender {
    if (_block) {
        _block(2);
    }
}

@end
