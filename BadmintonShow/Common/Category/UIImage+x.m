//
//  UIImage+UIImagex.m
//  FrogFarm
//
//  Created by czh0766 on 11-11-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIImage+x.h"

@implementation UIImage (x)




+ (UIImage *)resizeableImageNamed:(NSString *)name capLeft:(CGFloat)left capTop:(CGFloat)top
{
    UIImage *resizeImage = [UIImage imageNamed:name];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 5.0) {
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, top, left);
        resizeImage = [resizeImage resizableImageWithCapInsets:edgeInsets];
    } else {
        resizeImage = [resizeImage stretchableImageWithLeftCapWidth:left topCapHeight:top];
    }
    return resizeImage;
}

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}

@end
