//
//  BSBaseTableViewCell.m
//  BadmintonShow
//
//  Created by lizhihua on 12/14/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSBaseTableViewCell.h"

@implementation BSBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setObject:(id)object {
    _object = object;
    [self displayWithItem:object];
}

- (void)displayWithItem:(id)object {
    // 子类重写
}



@end
