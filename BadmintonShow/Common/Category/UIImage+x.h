//
//  UIImage+UIImagex.h
//  FrogFarm
//
//  Created by czh0766 on 11-11-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (x)

+ (UIImage *)resizeableImageNamed:(NSString *)name capLeft:(CGFloat)left capTop:(CGFloat)top;

+ (UIImage *)resizedImage:(NSString *)imgName;

@end