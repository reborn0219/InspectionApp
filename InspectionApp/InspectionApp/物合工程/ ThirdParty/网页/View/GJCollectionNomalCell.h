//
//  GJCollectionNomalCell.h
//  MeiLin
//
//  Created by 曹学亮 on 16/9/19.
//  Copyright © 2016年 Li Chuanliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GJCollectionNormalModel;
@interface GJCollectionNomalCell : UICollectionViewCell
@property (nonatomic,strong) GJCollectionNormalModel *normalModel;
@property (nonatomic,copy) void(^didSelectedItermBlock)(GJCollectionNormalModel *normalModel);
@end
