//
//  NSObject+Description.h
//  QZone
//
//  Created by wihing on 14-3-7.
//  Copyright (c) 2014年 wihing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Description)

- (NSString *)propertiesDescription;
- (NSString *)propertiesDescription:(Class)objClass;
@end
