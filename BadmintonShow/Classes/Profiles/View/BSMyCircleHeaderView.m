//
//  BSMyCircleHeaderView.m
//  BadmintonShow
//
//  Created by lizhihua on 16/1/9.
//  Copyright © 2016年 LZH. All rights reserved.
//

static CGFloat headerHeight = 30;

#import "BSMyCircleHeaderView.h"

@interface BSMyCircleHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

@end



@implementation BSMyCircleHeaderView


#pragma mark - open

+ (BSMyCircleHeaderView *)sectionHeader {
    BSMyCircleHeaderView *header = [[BSMyCircleHeaderView alloc] init];
    header.frame = CGRectMake(0, 0, kScreenWidth, headerHeight);
    
    return header;
}

+ (CGFloat)height {
    return headerHeight;
}

#pragma mark - private

- (id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"BSMyCircleHeaderView" owner:nil options:nil] lastObject];
    self.frame = CGRectMake(0, 0, kScreenWidth, 80);
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
