//
//  BSTLModel.h
//  BadmintonShow
//
//  Created by lizhihua on 12/25/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSBaseModel.h"
#import "AVOSCloud.h"
#import "BSProfileUserModel.h"


/// 图片标记
typedef NS_ENUM(NSUInteger, BSPictureBadgeType) {
    BSPictureBadgeTypeNone = 0, ///< 正常图片
    BSPictureBadgeTypeLong,     ///< 长图
    BSPictureBadgeTypeGIF,      ///< GIF
};

//@class BSEmoticonGroup;

typedef NS_ENUM(NSUInteger, BSEmoticonType) {
    BSEmoticonTypeImage = 0, ///< 图片表情
    BSEmoticonTypeEmoji = 1, ///< Emoji表情
};

@interface BSEmoticonGroup : NSObject
@property (nonatomic, strong) NSString *groupID; ///< 例如 com.sina.default
@property (nonatomic, assign) NSInteger version;
@property (nonatomic, strong) NSString *nameCN; ///< 例如 浪小花
@property (nonatomic, strong) NSString *nameEN;
@property (nonatomic, strong) NSString *nameTW;
@property (nonatomic, assign) NSInteger displayOnly;
@property (nonatomic, assign) NSInteger groupType;
@property (nonatomic, strong) NSArray *emoticons; ///< Array<BSEmoticon>
@end

@interface BSEmoticon : NSObject
@property (nonatomic, strong) NSString *chs;  ///< 例如 [吃惊]
@property (nonatomic, strong) NSString *cht;  ///< 例如 [吃驚]
@property (nonatomic, strong) NSString *gif;  ///< 例如 d_chijing.gif
@property (nonatomic, strong) NSString *png;  ///< 例如 d_chijing.png
@property (nonatomic, strong) NSString *code; ///< 例如 0x1f60d
@property (nonatomic, assign) BSEmoticonType type;
@property (nonatomic, weak) BSEmoticonGroup *group;
@end





@interface BSTLMedia : BSBaseModel
@property (nonatomic, strong) NSURL *url ;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
+ (instancetype)modelWithAVFile:(AVFile *)image;
@end

/**
 微博标题
 */
@interface BSStatusTitle : NSObject
@property (nonatomic, assign) int32_t baseColor;
@property (nonatomic, strong) NSString *text; ///< 文本，例如"仅自己可见"
@property (nonatomic, strong) NSString *iconURL; ///< 图标URL，需要加Default
@end


@interface BSTLModel : BSBaseModel
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSUInteger favoriteCount; // 点赞
@property (nonatomic, assign) NSUInteger commentsCount; // 评论
@property (nonatomic, assign) NSUInteger repostsCount;
@property (nonatomic, strong) BSProfileUserModel *user;
@property (nonatomic, strong) NSArray *medias;
@property (nonatomic, assign) BOOL favorited; // 已经被点赞

+ (BSTLModel *)modelWithAVObject:(AVObject *)object;
@end




/**
 一个图片的元数据
 */
@interface BSPictureMetadata : NSObject
@property (nonatomic, strong) NSURL *url; ///< Full image url
@property (nonatomic, assign) int width; ///< pixel width
@property (nonatomic, assign) int height; ///< pixel height
@property (nonatomic, strong) NSString *type; ///< "WEBP" "JPEG" "GIF"
@property (nonatomic, assign) int cutType; ///< Default:1
@property (nonatomic, assign) BSPictureBadgeType badgeType;
@end

/**
 图片
 */
@interface BSPicture : NSObject
@property (nonatomic, strong) NSString *picID;
@property (nonatomic, strong) NSString *objectID;
@property (nonatomic, assign) int photoTag;
@property (nonatomic, assign) BOOL keepSize; ///< YES:固定为方形 NO:原始宽高比
@property (nonatomic, strong) BSPictureMetadata *thumbnail;  ///< w:180
@property (nonatomic, strong) BSPictureMetadata *bmiddle;    ///< w:360 (列表中的缩略图)
@property (nonatomic, strong) BSPictureMetadata *middlePlus; ///< w:480
@property (nonatomic, strong) BSPictureMetadata *large;      ///< w:720 (放大查看)
@property (nonatomic, strong) BSPictureMetadata *largest;    ///<       (查看原图)
@property (nonatomic, strong) BSPictureMetadata *original;   ///<
@property (nonatomic, assign) BSPictureBadgeType badgeType;
@end


/**
 链接
 */
@interface BSURL : NSObject
@property (nonatomic, assign) BOOL result;
@property (nonatomic, strong) NSString *shortURL; ///< 短域名 (原文)
@property (nonatomic, strong) NSString *oriURL;   ///< 原始链接
@property (nonatomic, strong) NSString *urlTitle; ///< 显示文本，例如"网页链接"，可能需要裁剪(24)
@property (nonatomic, strong) NSString *urlTypePic; ///< 链接类型的图片URL
@property (nonatomic, assign) int32_t urlType; ///< 0:一般链接 36地点 39视频/图片
@property (nonatomic, strong) NSString *log;
@property (nonatomic, strong) NSDictionary *actionLog;
@property (nonatomic, strong) NSString *pageID; ///< 对应着 BSPageInfo
@property (nonatomic, strong) NSString *storageType;
//如果是图片，则会有下面这些，可以直接点开看
@property (nonatomic, strong) NSArray *picIds; /// Array<NSString>
@property (nonatomic, strong) NSDictionary *picInfos; /// Dic<NSString,BSPicItem>
@property (nonatomic, strong) NSArray *pics; ///< Array<BSPicItem>
@end


/**
 话题
 */
@interface BSTopic : NSObject
@property (nonatomic, strong) NSString *topicTitle; ///< 话题标题
@property (nonatomic, strong) NSString *topicURL; ///< 话题链接 sinaweibo://
@end


/**
 标签
 */
@interface BSTag : NSObject
@property (nonatomic, strong) NSString *tagName; ///< 标签名字，例如"上海·上海文庙"
@property (nonatomic, strong) NSString *tagScheme; ///< 链接 sinaweibo://...
@property (nonatomic, assign) int32_t tagType; ///< 1 地点 2其他
@property (nonatomic, assign) int32_t tagHidden;
@property (nonatomic, strong) NSURL *urlTypePic; ///< 需要加 _default
@end


/**
 按钮
 */
@interface BSButtonLink : NSObject
@property (nonatomic, strong) NSURL *pic;  ///< 按钮图片URL (需要加_default)
@property (nonatomic, strong) NSString *name; ///< 按钮文本，例如"点评"
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSDictionary *params;
@end


/**
 卡片 (样式有多种，最常见的是下方这样)
 -----------------------------
 title
 pic     title        button
 tips
 -----------------------------
 */
@interface BSPageInfo : NSObject
@property (nonatomic, strong) NSString *pageTitle; ///< 页面标题，例如"上海·上海文庙"
@property (nonatomic, strong) NSString *pageID;
@property (nonatomic, strong) NSString *pageDesc; ///< 页面描述，例如"上海市黄浦区文庙路215号"
@property (nonatomic, strong) NSString *content1;
@property (nonatomic, strong) NSString *content2;
@property (nonatomic, strong) NSString *content3;
@property (nonatomic, strong) NSString *content4;
@property (nonatomic, strong) NSString *tips; ///< 提示，例如"4222条微博"
@property (nonatomic, strong) NSString *objectType; ///< 类型，例如"place" "video"
@property (nonatomic, strong) NSString *objectID;
@property (nonatomic, strong) NSString *scheme; ///< 真实链接，例如 http://v.qq.com/xxx
@property (nonatomic, strong) NSArray *buttons; ///< Array<BSButtonLink>
@property (nonatomic, assign) int32_t isAsyn;
@property (nonatomic, assign) int32_t type;
@property (nonatomic, strong) NSString *pageURL; ///< 链接 sinaweibo://...
@property (nonatomic, strong) NSURL *pagePic; ///< 图片URL，不需要加(_default) 通常是左侧的方形图片
@property (nonatomic, strong) NSURL *typeIcon; ///< Badge 图片URL，不需要加(_default) 通常放在最左上角角落里
@property (nonatomic, assign) int32_t actStatus;
@property (nonatomic, strong) NSDictionary *actionlog;
@property (nonatomic, strong) NSDictionary *mediaInfo;
@end

