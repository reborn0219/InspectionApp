//
//  GJKSDatePicker.h
//  Bespeak
//
//  Created by kong on 16/3/4.
//  Copyright © 2016年 孔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJKSDatePickerAppearance.h"

@interface GJKSDatePicker : UIView

@property (nonatomic, strong, readonly)GJKSDatePickerAppearance* appearance;

- (void)reloadAppearance;

- (void)show;
- (void)hidden;

@end

