//
//  PatroPlayerItem.h
//  物联宝管家
//
//  Created by yang on 2019/3/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatroPlayerItem : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itmeImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneLb;
@property (weak, nonatomic) IBOutlet UIView *backShadowView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
