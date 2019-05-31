//
//  GJMHPhotoModel.h
//  图片浏览器
//
//  Created by LMH on 16/3/10.
//  Copyright © 2016年 LMH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJMHPhotoModel : NSObject

@property (nonatomic,strong) NSString *caption;
@property (nonatomic,readonly) UIImage *image;
@property (nonatomic,readonly) NSURL *photoURL;

+ (GJMHPhotoModel *)photoWithImage:(UIImage *)image;
+ (GJMHPhotoModel *)photoWithURL:(NSURL *)url;

- (id)initWithImage:(UIImage *)image;
- (id)initWithURL:(NSURL *)url;

@end
