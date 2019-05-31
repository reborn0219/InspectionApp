//
//  GJMHPhotoCollectionCell.h
//  图片浏览器
//
//  Created by LMH on 16/3/10.
//  Copyright © 2016年 LMH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJMHTapImgView.h"
#import "GJMHPhotoModel.h"

@interface GJMHPhotoCollectionCell : UICollectionViewCell<UIScrollViewDelegate,MHTapImgViewDelegate>{
    CGRect frameRect;
}

@property(nonatomic,strong)GJMHTapImgView *photoView;
@property(nonatomic,strong)UIScrollView *imgScrollView;
@property(nonatomic,strong)UIActivityIndicatorView *loadingIndicator;

- (void)reloadCellWith:(GJMHPhotoModel*)photo;
@end
