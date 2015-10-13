//
//  UITableViewCell+x.m
//  ColorScaner
//
//  Created by wihing on 12-10-18.
//  Copyright (c) 2012年 wihing. All rights reserved.
//

#import "UITableViewCell+x.h"

@implementation UITableViewCell (x)

+ (UITableViewCell *)cellFromNibName:(NSString *)nibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return nib[0];

}

@end
