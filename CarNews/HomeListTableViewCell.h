//
//  HomeListTableViewCell.h
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeListTableViewCell : UITableViewCell
- (void)setCellWithModel:(HomeResultNewslistModel*)listModel;
@end
