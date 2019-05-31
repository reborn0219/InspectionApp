//
//  PatrolOnlinePlayersCell.h
//  物联宝管家
//
//  Created by yang on 2019/3/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTaskDetailModel.h"

@interface PatrolOnlinePlayersCell : UITableViewCell
@property(nonatomic,copy)CellEventBlock block;
//@property (nonatomic,copy) NSArray<PPTaskDetailModelMember_list*> *member_list;
-(void)assignmentWithArray:(NSArray<PPTaskDetailModelMember_list*> *) member_list;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
