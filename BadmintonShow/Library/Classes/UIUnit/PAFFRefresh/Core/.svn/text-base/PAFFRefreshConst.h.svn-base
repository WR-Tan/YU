//
//  PAFFRefreshConst
//  luochenxun (luochenxun@foxmail.com)
//
//  Created by luochenxun on 2015-09-02.
//  Copyright (c) 2015年 PinAgn. All rights reserved.
//
//  说明：
//    本类为 PAFFRefresh 的常量定义类，在这里，你可以定义一些与PAFFRefresh控件相关的设置项，比如：
//
//    提示字体的大小、颜色；
//    提示的文案；
//    控件所用指示图标的路径；
//    等等。

#import <UIKit/UIKit.h>
#import <objc/message.h>

// 日志输出
#ifdef DEBUG
#define PAFFRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define PAFFRefreshLog(...)
#endif

// 过期提醒
#define PAFFRefreshDeprecated(instead)                                         \
  NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
  
// 运行时objc_PAFFRefreshMsgSend
#define PAFFRefreshMsgSend(...)                                                \
  ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define PAFFRefreshMsgTarget(target) (__bridge void *)(target)

// RGB颜色
#define PAFFRefreshColor(r, g, b)                                              \
  [UIColor colorWithRed:(r) / 255.0                                            \
                  green:(g) / 255.0                                            \
                   blue:(b) / 255.0                                            \
                  alpha:1.0]
                  
// 文字颜色
#define PAFFRefreshLabelTextColor PAFFRefreshColor(90, 90, 90)

// 字体大小
#define PAFFRefreshLabelFont [UIFont boldSystemFontOfSize:14]

// 图片路径
#define PAFFRefreshSrcName(file)                                               \
  [@"PAFFRefresh.bundle" stringByAppendingPathComponent:file]
#define PAFFRefreshFrameworkSrcName(file)                                      \
  [@"Frameworks/PAFFRefresh.framework/PAFFRefresh.bundle"                      \
      stringByAppendingPathComponent:file]
      
// 常量
UIKIT_EXTERN const CGFloat PAFFRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat PAFFRefreshFooterHeight;
UIKIT_EXTERN const CGFloat PAFFRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat PAFFRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const PAFFRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const PAFFRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const PAFFRefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const PAFFRefreshKeyPathPanState;

UIKIT_EXTERN NSString *const PAFFRefreshHeaderLastUpdatedTimeKey;

UIKIT_EXTERN NSString *const PAFFRefreshHeaderIdleText;
UIKIT_EXTERN NSString *const PAFFRefreshHeaderPullingText;
UIKIT_EXTERN NSString *const PAFFRefreshHeaderRefreshingText;

UIKIT_EXTERN NSString *const PAFFRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const PAFFRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const PAFFRefreshAutoFooterNoMoreDataText;

UIKIT_EXTERN NSString *const PAFFRefreshBackFooterIdleText;
UIKIT_EXTERN NSString *const PAFFRefreshBackFooterPullingText;
UIKIT_EXTERN NSString *const PAFFRefreshBackFooterRefreshingText;
UIKIT_EXTERN NSString *const PAFFRefreshBackFooterNoMoreDataText;

// 状态检查
#define PAFFRefreshCheckState \
PAFFRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];
