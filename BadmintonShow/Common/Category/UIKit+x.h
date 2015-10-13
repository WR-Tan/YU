//
//  UIKit+x.h
//  common
//
//  Created by czh0766 on 12-9-5.
//
//

#ifndef common_UIKit_x_h
#define common_UIKit_x_h

#define OBJ_EQUAL(a,b) (a == b || [a isEqual:b])

#define RANDOM_0_1 (arc4random() / (float)0x100000000)

#define STR_EMPTY(str) (str == nil || [str isEqual:@""])

#define UIViewAutoresizingFlexibleSize \
(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)

#define REG_NOTIFY(s, n) [[NSNotificationCenter defaultCenter] addObserver:self selector:s name:n object:nil];

#define NSGBKStringEncoding CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "NSObject+x.h"
#import "NSString+x.h"
#import "NSData+x.h"
#import "NSDate+x.h"
#import "NSArray+x.h"
#import "NSDictionary+x.h"
#import "NSFileManager+x.h"
#import "NSNumber+x.h"
#import "UIColor+x.h"
#import "UIImage+x.h"
#import "UILabel+x.h"
#import "UIView+x.h"
#import "UITableView+x.h"
#import "UIAlertView+x.h"
#import "UIViewController+x.h"
#import "UITableViewCell+x.h"

#import "GeneralUtil.h"
#import "UIButton+TM.h"

#endif
