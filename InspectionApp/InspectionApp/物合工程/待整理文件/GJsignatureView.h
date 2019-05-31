//
//  GJsignatureView.h
//  签名
//
//  Created by ovov on 2017/3/23.
//  Copyright © 2017年 bjovov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetSignatureImageDele <NSObject>

-(void)getSignatureImg:(UIImage*)image;

@end

@interface GJsignatureView : UIView
{
    CGFloat min;
    CGFloat max;
    CGRect origRect;
    CGFloat origionX;
    CGFloat totalWidth;
    BOOL  isSure;
}
//签名完成后的水印文字
@property (strong,nonatomic) NSString *showMessage;
@property(nonatomic,assign)id<GetSignatureImageDele> delegate;
- (void)clear;
- (void)sure;
@end
