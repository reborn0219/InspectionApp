//
//  GJQMViewController.h
//  物联宝管家
//
//  Created by ovov on 2017/3/24.
//  Copyright © 2017年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJsignatureView.h"

@interface GJQMViewController : UIViewController<GetSignatureImageDele>
{
    UIImage *saveImage;
    UIView *saveView;
}
@property (strong,nonatomic) GJsignatureView *GJsignatureView;

@property(strong,nonatomic)NSString *repair_id;

//  标记完工

@property(strong,nonatomic)NSDictionary *WGDic;
@property(nonatomic,assign)BOOL isAnbao;



@end
