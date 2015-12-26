//
//  BSTLLayout.h
//  BadmintonShow
//
//  Created by lizhihua on 12/25/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

// 宽高
#define kTLCellTopMargin 8      // cell 顶部灰色留白
#define kTLCellTitleHeight 36   // cell 标题高度 (例如"仅自己可见")
#define kTLCellPadding 12       // cell 内边距
#define kTLCellPaddingText 10   // cell 文本与其他元素间留白
#define kTLCellPaddingPic 4     // cell 多张图片中间留白
#define kTLCellProfileHeight 56 // cell 名片高度
#define kTLCellCardHeight 70    // cell card 视图高度
#define kTLCellNamePaddingLeft 14 // cell 名字和 avatar 之间留白
#define kTLCellContentWidth (kScreenWidth - 2 * kTLCellPadding) // cell 内容宽度
#define kTLCellNameWidth (kScreenWidth - 110) // cell 名字最宽限制

#define kTLCellTagPadding 8         // tag 上下留白
#define kTLCellTagNormalHeight 16   // 一般 tag 高度
#define kTLCellTagPlaceHeight 24    // 地理位置 tag 高度

#define kTLCellToolbarHeight 35     // cell 下方工具栏高度
#define kTLCellToolbarBottomMargin 2 // cell 下方灰色留白

// 字体 应该做成动态的，这里只是 Demo，临时写死了。
#define kTLCellNameFontSize 16      // 名字字体大小
#define kTLCellSourceFontSize 12    // 来源字体大小
#define kTLCellTextFontSize 17      // 文本字体大小
#define kTLCellTextFontRetweetSize 16 // 转发字体大小
#define kTLCellCardTitleFontSize 16 // 卡片标题文本字体大小
#define kTLCellCardDescFontSize 12 // 卡片描述文本字体大小
#define kTLCellTitlebarFontSize 14 // 标题栏字体大小
#define kTLCellToolbarFontSize 14 // 工具栏字体大小

// 颜色
#define kTLCellNameNormalColor UIColorHex(333333) // 名字颜色
#define kTLCellNameOrangeColor UIColorHex(f26220) // 橙名颜色 (VIP)
#define kTLCellTimeNormalColor UIColorHex(828282) // 时间颜色
#define kTLCellTimeOrangeColor UIColorHex(f28824) // 橙色时间 (最新刷出)

#define kTLCellTextNormalColor UIColorHex(333333) // 一般文本色
#define kTLCellTextSubTitleColor UIColorHex(5d5d5d) // 次要文本色
#define kTLCellTextHighlightColor UIColorHex(527ead) // Link 文本色
#define kTLCellTextHighlightBackgroundColor UIColorHex(bfdffe) // Link 点击背景色
#define kTLCellToolbarTitleColor UIColorHex(929292) // 工具栏文本色
#define kTLCellToolbarTitleHighlightColor UIColorHex(df422d) // 工具栏文本高亮色

#define kTLCellBackgroundColor UIColorHex(f2f2f2)    // Cell背景灰色
#define kTLCellHighlightColor UIColorHex(f0f0f0)     // Cell高亮时灰色
#define kTLCellInnerViewColor UIColorHex(f7f7f7)   // Cell内部卡片灰色
#define kTLCellInnerViewHighlightColor  UIColorHex(f0f0f0) // Cell内部卡片高亮时灰色
#define kTLCellLineColor [UIColor colorWithWhite:0.000 alpha:0.09] //线条颜色

#define kTLLinkHrefName @"href" //NSString
#define kTLLinkURLName @"url" //YYURL
#define kTLLinkTagName @"tag" //YYTag
#define kTLLinkTopicName @"topic" //YYTopic
#define kTLLinkAtName @"at" //NSString

@interface BSTLLayout : NSObject

@end
