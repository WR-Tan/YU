//
//  BSProfileEditCell.h
//  BadmintonShow
//
//  Created by lizhihua on 12/16/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSBaseTableViewCell.h"

@class BSProfileEditCell;

@protocol BSProfileEditCellDelegate <NSObject>
- (void)cell:(BSProfileEditCell *)cell imageView:(UIImageView *)imageView displayImageUrl:(NSString *)imageUrl;
@end

@interface BSProfileEditCell : BSBaseTableViewCell
@property (nonatomic, weak) id <BSProfileEditCellDelegate> delegate;
- (void)setAvatar:(UIImage *)image;
@end
