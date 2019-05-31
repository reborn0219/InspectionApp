//
//  GJrunLabel.h
//  GJrunLabel
//
//  Created by 梁伟杰 on 16/6/6.
//  Copyright © 2016年 梁伟杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJrunLabel : UIView

- (instancetype)initWithFrame:(CGRect)frame andText:(NSString*) text;

- (void)setText:(NSString*) text;

- (void)setFont:(UIFont*) font;

- (void)setTextColor:(UIColor*) color;

-(void)runlabel;
@end
