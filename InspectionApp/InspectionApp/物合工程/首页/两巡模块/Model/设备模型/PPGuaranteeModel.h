//
//  PPGuaranteeModel.h
//  物联宝管家
//
//  Created by guokang on 2019/4/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GuaranteeListModel.h"

@interface PPGuaranteeModel : NSObject
@property (nonatomic,copy) NSArray <GuaranteeListModel *> *guarantee_list;
@end
