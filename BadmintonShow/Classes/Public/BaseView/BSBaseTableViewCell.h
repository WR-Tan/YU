//
//  BSBaseTableViewCell.h
//  BadmintonShow
//
//  Created by lizhihua on 12/14/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) id object ;

- (void)displayWithItem:(id)object ;

@end
