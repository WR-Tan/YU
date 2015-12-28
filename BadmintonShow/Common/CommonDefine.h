//
//  CommonDefine.h
//  OnlineDiagnose
//
//  Created by AllenMa on 3/20/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#ifndef OnlineDiagnose_CommonDefine_h
#define OnlineDiagnose_CommonDefine_h

/******************** 常用的宏定义  ***********/
#define kScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeigth  ([UIScreen mainScreen].bounds.size.height)
#define QZ_ADAPT_WIDTH(x) (kScreenWidth / 320.0 * (x))
#define isIOS8 ([CommonUtils iOS8])
#define isIOS7 ([CommonUtils iOS7])
#define isIOS6 ([CommonUtils iOS6])
#define isIOS5 ([CommonUtils iOS5])
#define IOS7_OFFSET_FIX ((isIOS7) ? 64 : 0)

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

/******************** 常用的宏定义 - lzh ***********/
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define DECLARE_WEAK_SELF __typeof(&*self) __weak weakSelf = self
#define DECLARE_STRONG_SELF __typeof(&*self) __strong strongSelf = weakSelf

#define RGB(R,G,B) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1.0f]
#define RGBA(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)/255]

#define  kTableViewBackgroudColor RGB(240,240,240)
#define  kBackgroudColor  kTableViewBackgroudColor
#define  kDetailLabelFont [UIFont systemFontOfSize:15]
#define  kDetailLabelFontLarge [UIFont systemFontOfSize:16]

#define kBSDefaultFont    [UIFont systemFontOfSize:16]
#define kBSFontSize(size)     [UIFont systemFontOfSize:size]
#define kBSAvatarRadius   36
#define kBSAvatarPlaceHolder  @"MaleDefault"
#define UIImageNamed(name)  [UIImage imageNamed:(name)]
#define kDefaultUserAvatar   @"bs_def_userAvatar"
#define kUserAvatarImage  UIImageNamed(kBSAvatarPlaceHolder)

typedef void (^BSArrayResultBlock)(NSArray *objects, NSError *error);
typedef void (^BSBooleanResultBlock)(BOOL succeeded, NSError *error);

#endif
