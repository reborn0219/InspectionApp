//
//  PSWOTextViewCell.h
//  InspectionApp
//
//  Created by guokang on 2019/6/5.
//  Copyright © 2019 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PSWOTextViewCell : UITableViewCell<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) CellEventBlock block;

@property (weak, nonatomic) IBOutlet UIView *backV;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UITextView *markTV;

@end

NS_ASSUME_NONNULL_END
