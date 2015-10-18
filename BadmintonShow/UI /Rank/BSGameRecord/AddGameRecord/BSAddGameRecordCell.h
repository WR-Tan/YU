//
//  BSAddGameRecordCell.h
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSMatchModel.h"

@protocol BSAddGameRecordCellDelegate <NSObject>



@end

@interface BSAddGameRecordCell : UITableViewCell

@property (nonatomic, assign) BSMatchType matchType ;



@end
