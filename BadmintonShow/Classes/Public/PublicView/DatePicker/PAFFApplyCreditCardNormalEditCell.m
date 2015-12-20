//
//  ApplyCreditCardNormalEditCell.m
//  PANewToapAPP
//
//  Created by pan.zaofeng on 14/11/1.
//  Copyright (c) 2014年 Gavin. All rights reserved.
//

#import "PAFFApplyCreditCardNormalEditCell.h"

@implementation PAFFApplyCreditCardNormalEditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat setofx = 15;
        CGRect rect = CGRectMake(setofx, 10, 110, 20);
        _firstLabel = [[UILabel alloc] initWithFrame:rect];
        self.firstLabel.backgroundColor = [UIColor clearColor];
        self.firstLabel.textColor =  RGB(102, 102, 102);
        self.firstLabel.font = kBSFontSize(14);
        [self addSubview:self.firstLabel];
        
        rect.size.width = 190;
        rect.origin.x = kScreenWidth - rect.size.width - setofx *2;
        _lastLabel = [[UILabel alloc] initWithFrame:rect];
        self.lastLabel.backgroundColor = [UIColor clearColor];
        self.lastLabel.textColor = RGB(0, 163, 255);
        self.lastLabel.font = kBSFontSize(14);
        self.lastLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.lastLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    self.firstLabel.font = kBSFontSize(14.0);
    self.lastLabel.font = kBSFontSize(14.0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
