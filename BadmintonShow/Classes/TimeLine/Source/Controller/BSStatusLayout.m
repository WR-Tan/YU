//
//  BSFeedLayout.m
//  YYKitExample
//
//  Created by ibireme on 15/9/5.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "BSStatusLayout.h"

/*
 将每行的 baseline 位置固定下来，不受不同字体的 ascent/descent 影响。
 
 注意，Heiti SC 中，    ascent + descent = font size，
 但是在 PingFang SC 中，ascent + descent > font size。
 所以这里统一用 Heiti SC (0.86 ascent, 0.14 descent) 作为顶部和底部标准，保证不同系统下的显示一致性。
 间距仍然用字体默认
 */
@implementation BSTextLinePositionModifier

- (instancetype)init {
    self = [super init];
    
    if (kiOS9Later) {
        _lineHeightMultiple = 1.34;   // for PingFang SC
    } else {
        _lineHeightMultiple = 1.3125; // for Heiti SC
    }
    
    return self;
}

- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    //CGFloat ascent = _font.ascender;
    CGFloat ascent = _font.pointSize * 0.86;
    
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    BSTextLinePositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount {
    if (lineCount == 0) return 0;
//    CGFloat ascent = _font.ascender;
//    CGFloat descent = -_font.descender;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}

@end


/**
 微博的文本中，某些嵌入的图片需要从网上下载，这里简单做个封装
 */
@interface BSTextImageViewAttachment : YYTextAttachment
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, assign) CGSize size;
@end

@implementation BSTextImageViewAttachment {
    UIImageView *_imageView;
}
- (void)setContent:(id)content {
    _imageView = content;
}
- (id)content {
    /// UIImageView 只能在主线程访问
    if (pthread_main_np() == 0) return nil;
    if (_imageView) return _imageView;
    
    /// 第一次获取时 (应该是在文本渲染完成，需要添加附件视图时)，初始化图片视图，并下载图片
    /// 这里改成 YYAnimatedImageView 就能支持 GIF/APNG/WebP 动画了
    _imageView = [UIImageView new];
    _imageView.size = _size;
    [_imageView setImageWithURL:_imageURL placeholder:nil];
    return _imageView;
}
@end


@implementation BSStatusLayout

- (instancetype)initWithStatus:(BSTLModel  *)status style:(BSLayoutStyle)style {
    if (!status || !status.user) return nil;
    self = [super init];
    _status = status;
    _style = style;
    [self layout];
    return self;
}

- (void)layout {
    [self _layout];
}

- (void)updateDate {
    [self _layoutSource];
}

- (void)_layout {
    
    _marginTop = kBSCellTopMargin;
    _titleHeight = 0;
    _profileHeight = 0;
    _textHeight = 0;
    _retweetHeight = 0;
    _retweetTextHeight = 0;
    _retweetPicHeight = 0;
    _retweetCardHeight = 0;
    _picHeight = 0;
    _cardHeight = 0;
    _toolbarHeight = kBSCellToolbarHeight;
    _marginBottom = kBSCellToolbarBottomMargin;
    
    
    // 文本排版，计算布局
    [self _layoutTitle];
    [self _layoutProfile];
//    [self _layoutRetweet];   // there is no retweet here.
    if (_retweetHeight == 0) {
        [self _layoutPics];
        if (_picHeight == 0) {
            [self _layoutCard];
        }
    }
    [self _layoutText];
    [self _layoutTag];
    [self _layoutToolbar];
    
    // 计算高度
    _height = 0;
    _height += _marginTop;
    _height += _titleHeight;
    _height += _profileHeight;
    _height += _textHeight;
    if (_retweetHeight > 0) {
        _height += _retweetHeight;
    } else if (_picHeight > 0) {
        _height += _picHeight;
    } else if (_cardHeight > 0) {
        _height += _cardHeight;
    }
    if (_tagHeight > 0) {
        _height += _tagHeight;
    } else {
        if (_picHeight > 0 || _cardHeight > 0) {
            _height += kBSCellPadding;
        }
    }
    _height += _toolbarHeight;
    _height += _marginBottom;
}

- (void)_layoutTitle {
    _titleHeight = 0;
    _titleTextLayout = nil;
    
    BSStatusTitle *title = nil; // _status.title; by lzh
    if (title.text.length == 0) return;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:title.text];
    if (title.iconURL) {
        NSAttributedString *icon = [self _attachmentWithFontSize:kBSCellTitlebarFontSize imageURL:title.iconURL shrink:NO];
        if (icon) {
            [text insertAttributedString:icon atIndex:0];
        }
    }
    text.color = kBSCellToolbarTitleColor;
    text.font = [UIFont systemFontOfSize:kBSCellTitlebarFontSize];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - 100, kBSCellTitleHeight)];
    _titleTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    _titleHeight = kBSCellTitleHeight;
}

- (void)_layoutProfile {
    [self _layoutName];
    [self _layoutSource];
    _profileHeight = kBSCellProfileHeight;
}

/// 名字
- (void)_layoutName {
    BSProfileUserModel *user = _status.user;
    NSString *nameStr = nil;
//    if (user.remark.length) {
//        nameStr = user.remark;
//    } else
    if (user.nickName.length) {
        nameStr = user.nickName;
    } else {
        nameStr = user.userName;
    }
    if (nameStr.length == 0) {
        _nameTextLayout = nil;
        return;
    }
    
    NSMutableAttributedString *nameText = [[NSMutableAttributedString alloc] initWithString:nameStr];
    
    // 蓝V
//    if (user.userVerifyType == BSUserVerifyTypeOrganization) {
//        UIImage *blueVImage = [BSStatusHelper imageNamed:@"avatar_enterprise_vip"];
//        NSAttributedString *blueVText = [self _attachmentWithFontSize:kBSCellNameFontSize image:blueVImage shrink:NO];
//        [nameText appendString:@" "];
//        [nameText appendAttributedString:blueVText];
//    }
//    
//    // VIP
//    if (user.mbrank > 0) {
//        UIImage *yelllowVImage = [BSStatusHelper imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
//        if (!yelllowVImage) {
//            yelllowVImage = [BSStatusHelper imageNamed:@"common_icon_membership"];
//        }
//        // rich text . containing imageView
//        NSAttributedString *vipText = [self _attachmentWithFontSize:kBSCellNameFontSize image:yelllowVImage shrink:NO];
//        [nameText appendString:@" "];
//        [nameText appendAttributedString:vipText];
//    }
    
    nameText.font = [UIFont systemFontOfSize:kBSCellNameFontSize];
//    nameText.color = user.mbrank > 0 ? kBSCellNameOrangeColor : kBSCellNameNormalColor;
    nameText.color = kBSCellNameNormalColor;
    nameText.lineBreakMode = NSLineBreakByCharWrapping;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kBSCellNameWidth, 9999)];
    container.maximumNumberOfRows = 1;
    _nameTextLayout = [YYTextLayout layoutWithContainer:container text:nameText];
}

/// 时间和来源
- (void)_layoutSource {
    NSMutableAttributedString *sourceText = [NSMutableAttributedString new];
    NSString *createTime = [BSStatusHelper stringWithTimelineDate:_status.createdAt];
    
    // 时间
    if (createTime.length) {
        NSMutableAttributedString *timeText = [[NSMutableAttributedString alloc] initWithString:createTime];
        [timeText appendString:@"  "];
        timeText.font = [UIFont systemFontOfSize:kBSCellSourceFontSize];
        timeText.color = kBSCellTimeNormalColor;
        [sourceText appendAttributedString:timeText];
    }
    
    // 来自 XXX
//    if (_status.source.length) {
//        // <a href="sinaweibo://customweibosource" rel="nofollow">iPhone 5siPhone 5s</a>
//        static NSRegularExpression *hrefRegex, *textRegex;
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            hrefRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=href=\").+(?=\" )" options:kNilOptions error:NULL];
//            textRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=>).+(?=<)" options:kNilOptions error:NULL];
//        });
//        NSTextCheckingResult *hrefResult, *textResult;
//        NSString *href = nil, *text = nil;
//        hrefResult = [hrefRegex firstMatchInString:_status.source options:kNilOptions range:NSMakeRange(0, _status.source.length)];
//        textResult = [textRegex firstMatchInString:_status.source options:kNilOptions range:NSMakeRange(0, _status.source.length)];
//        if (hrefResult && textResult && hrefResult.range.location != NSNotFound && textResult.range.location != NSNotFound) {
//            href = [_status.source substringWithRange:hrefResult.range];
//            text = [_status.source substringWithRange:textResult.range];
//        }
//        if (href.length && text.length) {
//            NSMutableAttributedString *from = [NSMutableAttributedString new];
//            [from appendString:[NSString stringWithFormat:@"来自 %@", text]];
//            from.font = [UIFont systemFontOfSize:kBSCellSourceFontSize];
//            from.color = kBSCellTimeNormalColor;
//            if (_status.sourceAllowClick > 0) {
//                NSRange range = NSMakeRange(3, text.length);
//                [from setColor:kBSCellTextHighlightColor range:range];
//                YYTextBackedString *backed = [YYTextBackedString stringWithString:href];
//                [from setTextBackedString:backed range:range];
//                
//                YYTextBorder *border = [YYTextBorder new];
//                border.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
//                border.fillColor = kBSCellTextHighlightBackgroundColor;
//                border.cornerRadius = 3;
//                YYTextHighlight *highlight = [YYTextHighlight new];
//                if (href) highlight.userInfo = @{kBSLinkHrefName : href};
//                [highlight setBackgroundBorder:border];
//                [from setTextHighlight:highlight range:range];
//            }
//            
//            [sourceText appendAttributedString:from];
//        }
//    }
    
    if (sourceText.length == 0) {
        _sourceTextLayout = nil;
    } else {
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kBSCellNameWidth, 9999)];
        container.maximumNumberOfRows = 1;
        _sourceTextLayout = [YYTextLayout layoutWithContainer:container text:sourceText];
    }
}

//- (void)_layoutRetweet {
//    _retweetHeight = 0;
//    [self _layoutRetweetedText];
//    [self _layoutRetweetPics];
//    if (_retweetPicHeight == 0) {
//        [self _layoutRetweetCard];
//    }
//    
//    _retweetHeight = _retweetTextHeight;
//    if (_retweetPicHeight > 0) {
//        _retweetHeight += _retweetPicHeight;
//        _retweetHeight += kBSCellPadding;
//    } else if (_retweetCardHeight > 0) {
//        _retweetHeight += _retweetCardHeight;
//        _retweetHeight += kBSCellPadding;
//    }
//}

/// 文本
- (void)_layoutText {
    _textHeight = 0;
    _textLayout = nil;
    
    NSMutableAttributedString *text = [self _textWithStatus:_status
                                                  isRetweet:NO
                                                   fontSize:kBSCellTextFontSize
                                                  textColor:kBSCellTextNormalColor];
    if (text.length == 0) return;
    
    BSTextLinePositionModifier *modifier = [BSTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:kBSCellTextFontSize];
    modifier.paddingTop = kBSCellPaddingText;
    modifier.paddingBottom = kBSCellPaddingText;
    
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kBSCellContentWidth, HUGE);
    container.linePositionModifier = modifier;
    
    _textLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (!_textLayout) return;
    
    _textHeight = [modifier heightForLineCount:_textLayout.rowCount];
}


//- (void)_layoutRetweetedText {
//    _retweetHeight = 0;
//    _retweetTextLayout = nil;
//    NSMutableAttributedString *text = [self _textWithStatus:_status.retweetedStatus
//                                                  isRetweet:YES
//                                                   fontSize:kBSCellTextFontRetweetSize
//                                                  textColor:kBSCellTextSubTitleColor];
//    if (text.length == 0) return;
//    
//    BSTextLinePositionModifier *modifier = [BSTextLinePositionModifier new];
//    modifier.font = [UIFont fontWithName:@"Heiti SC" size:kBSCellTextFontRetweetSize];
//    modifier.paddingTop = kBSCellPaddingText;
//    modifier.paddingBottom = kBSCellPaddingText;
//    
//    YYTextContainer *container = [YYTextContainer new];
//    container.size = CGSizeMake(kBSCellContentWidth, HUGE);
//    container.linePositionModifier = modifier;
//    
//    _retweetTextLayout = [YYTextLayout layoutWithContainer:container text:text];
//    if (!_retweetTextLayout) return;
//    
//    _retweetTextHeight = [modifier heightForLineCount:_retweetTextLayout.lines.count];
//}

- (void)_layoutPics {
    [self _layoutPicsWithStatus:_status isRetweet:NO];
}

//- (void)_layoutRetweetPics {
//    [self _layoutPicsWithStatus:_status.retweetedStatus isRetweet:YES];
//}

- (void)_layoutPicsWithStatus:(BSTLModel  *)status isRetweet:(BOOL)isRetweet {
    if (isRetweet) {
        _retweetPicSize = CGSizeZero;
        _retweetPicHeight = 0;
    } else {
        _picSize = CGSizeZero;
        _picHeight = 0;
    }
    if (status.medias.count == 0) return;
    
    CGSize picSize = CGSizeZero;
    CGFloat picHeight = 0;
    
    CGFloat len1_3 = (kBSCellContentWidth + kBSCellPaddingPic) / 3 - kBSCellPaddingPic;
    len1_3 = CGFloatPixelRound(len1_3);
    switch (status.medias.count) {
        case 1: {
            BSPicture *pic = _status.medias.firstObject;
            BSPictureMetadata *bmiddle = pic.bmiddle;
            if (pic.keepSize || bmiddle.width < 1 || bmiddle.height < 1) {
                CGFloat maxLen = kBSCellContentWidth / 2.0;
                maxLen = CGFloatPixelRound(maxLen);
                picSize = CGSizeMake(maxLen, maxLen);
                picHeight = maxLen;
            } else {
                CGFloat maxLen = len1_3 * 2 + kBSCellPaddingPic;
                if (bmiddle.width < bmiddle.height) {
                    picSize.width = (float)bmiddle.width / (float)bmiddle.height * maxLen;
                    picSize.height = maxLen;
                } else {
                    picSize.width = maxLen;
                    picSize.height = (float)bmiddle.height / (float)bmiddle.width * maxLen;
                }
                picSize = CGSizePixelRound(picSize);
                picHeight = picSize.height;
            }
        } break;
        case 2: case 3: {
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3;
        } break;
        case 4: case 5: case 6: {
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3 * 2 + kBSCellPaddingPic;
        } break;
        default: { // 7, 8, 9
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3 * 3 + kBSCellPaddingPic * 2;
        } break;
    }
    
    if (isRetweet) {
        _retweetPicSize = picSize;
        _retweetPicHeight = picHeight;
    } else {
        _picSize = picSize;
        _picHeight = picHeight;
    }
}

- (void)_layoutCard {
    [self _layoutCardWithStatus:_status isRetweet:NO];
}

//- (void)_layoutRetweetCard {
//    [self _layoutCardWithStatus:_status.retweetedStatus isRetweet:YES];
//}

- (void)_layoutCardWithStatus:(BSTLModel  *)status isRetweet:(BOOL)isRetweet {
    if (isRetweet) {
        _retweetCardType = BSStatusCardTypeNone;
        _retweetCardHeight = 0;
        _retweetCardTextLayout = nil;
        _retweetCardTextRect = CGRectZero;
    } else {
        _cardType = BSStatusCardTypeNone;
        _cardHeight = 0;
        _cardTextLayout = nil;
        _cardTextRect = CGRectZero;
    }
//    BSPageInfo *pageInfo = status.pageInfo;
//    if (!pageInfo) return;
//    
//    BSStatusCardType cardType = BSStatusCardTypeNone;
//    CGFloat cardHeight = 0;
//    YYTextLayout *cardTextLayout = nil;
//    CGRect textRect = CGRectZero;
//    
//    if ((pageInfo.type == 11) && [pageInfo.objectType isEqualToString:@"video"]) {
//        // 视频，一个大图片，上面播放按钮
//        if (pageInfo.pagePic) {
//            cardType = BSStatusCardTypeVideo;
//            cardHeight = (2 * kBSCellContentWidth - kBSCellPaddingPic) / 3.0;
//        }
//    } else {
//        BOOL hasImage = pageInfo.pagePic != nil;
//        BOOL hasBadge = pageInfo.typeIcon != nil;
//        BSButtonLink *button = pageInfo.buttons.firstObject;
//        BOOL hasButtom = button.pic && button.name;
//        
//        /*
//         badge: 25,25 左上角 (42)
//         image: 70,70 方形
//                100, 70 矩形
//         btn:  60,70
//         
//         lineheight 20
//         padding 10
//         */
//        textRect.size.height = 70;
//        if (hasImage) {
//            if (hasBadge) {
//                textRect.origin.x = 100;
//            } else {
//                textRect.origin.x = 70;
//            }
//        } else {
//            if (hasBadge) {
//                textRect.origin.x = 42;
//            }
//        }
//        textRect.origin.x += 10; //padding
//        textRect.size.width = kBSCellContentWidth - textRect.origin.x;
//        if (hasButtom) textRect.size.width -= 60;
//        textRect.size.width -= 10; //padding
//        
//        NSMutableAttributedString *text = [NSMutableAttributedString new];
//        if (pageInfo.pageTitle.length) {
//            NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:pageInfo.pageTitle];
//            
//            title.font = [UIFont systemFontOfSize:kBSCellCardTitleFontSize];
//            title.color = kBSCellNameNormalColor;
//            [text appendAttributedString:title];
//        }
//        
//        if (pageInfo.pageDesc.length) {
//            if (text.length) [text appendString:@"\n"];
//            NSMutableAttributedString *desc = [[NSMutableAttributedString alloc] initWithString:pageInfo.pageDesc];
//            desc.font = [UIFont systemFontOfSize:kBSCellCardDescFontSize];
//            desc.color = kBSCellNameNormalColor;
//            [text appendAttributedString:desc];
//        } else if (pageInfo.content2.length) {
//            if (text.length) [text appendString:@"\n"];
//            NSMutableAttributedString *content3 = [[NSMutableAttributedString alloc] initWithString:pageInfo.content2];
//            content3.font = [UIFont systemFontOfSize:kBSCellCardDescFontSize];
//            content3.color = kBSCellTextSubTitleColor;
//            [text appendAttributedString:content3];
//        } else if (pageInfo.content3.length) {
//            if (text.length) [text appendString:@"\n"];
//            NSMutableAttributedString *content3 = [[NSMutableAttributedString alloc] initWithString:pageInfo.content3];
//            content3.font = [UIFont systemFontOfSize:kBSCellCardDescFontSize];
//            content3.color = kBSCellTextSubTitleColor;
//            [text appendAttributedString:content3];
//        }
//        
//        if (pageInfo.tips.length) {
//            if (text.length) [text appendString:@"\n"];
//            NSMutableAttributedString *tips = [[NSMutableAttributedString alloc] initWithString:pageInfo.tips];
//            tips.font = [UIFont systemFontOfSize:kBSCellCardDescFontSize];
//            tips.color = kBSCellTextSubTitleColor;
//            [text appendAttributedString:tips];
//        }
//        
//        if (text.length) {
//            text.maximumLineHeight = 20;
//            text.minimumLineHeight = 20;
//            text.lineBreakMode = NSLineBreakByTruncatingTail;
//            
//            YYTextContainer *container = [YYTextContainer containerWithSize:textRect.size];
//            container.maximumNumberOfRows = 3;
//            cardTextLayout = [YYTextLayout layoutWithContainer:container text:text];
//        }
//        
//        if (cardTextLayout) {
//            cardType = BSStatusCardTypeNormal;
//            cardHeight = 70;
//        }
//    }
//    
//    if (isRetweet) {
//        _retweetCardType = cardType;
//        _retweetCardHeight = cardHeight;
//        _retweetCardTextLayout = cardTextLayout;
//        _retweetCardTextRect = textRect;
//    } else {
//        _cardType = cardType;
//        _cardHeight = cardHeight;
//        _cardTextLayout = cardTextLayout;
//        _cardTextRect = textRect;
//    }
    
}

- (void)_layoutTag {
    _tagType = BSStatusTagTypeNone;
    _tagHeight = 0;
    
//    BSTag *tag = _status.tagStruct.firstObject;
//    if (tag.tagName.length == 0) return;
//    
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:tag.tagName];
//    if (tag.tagType == 1) {
//        _tagType = BSStatusTagTypePlace;
//        _tagHeight = 40;
//        text.color = [UIColor colorWithWhite:0.217 alpha:1.000];
//    } else {
//        _tagType = BSStatusTagTypeNormal;
//        _tagHeight = 32;
//        if (tag.urlTypePic) {
//            NSAttributedString *pic = [self _attachmentWithFontSize:kBSCellCardDescFontSize imageURL:tag.urlTypePic.absoluteString shrink:YES];
//            [text insertAttributedString:pic atIndex:0];
//        }
//        // 高亮状态的背景
//        YYTextBorder *highlightBorder = [YYTextBorder new];
//        highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
//        highlightBorder.cornerRadius = 2;
//        highlightBorder.fillColor = kBSCellTextHighlightBackgroundColor;
//        
//        [text setColor:kBSCellTextHighlightColor range:text.rangeOfAll];
//        
//        // 高亮状态
//        YYTextHighlight *highlight = [YYTextHighlight new];
//        [highlight setBackgroundBorder:highlightBorder];
//        // 数据信息，用于稍后用户点击
//        highlight.userInfo = @{kBSLinkTagName : tag};
//        [text setTextHighlight:highlight range:text.rangeOfAll];
//    }
//    text.font = [UIFont systemFontOfSize:kBSCellCardDescFontSize];
//    
//    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(9999, 9999)];
//    _tagTextLayout = [YYTextLayout layoutWithContainer:container text:text];
//    if (!_tagTextLayout) {
//        _tagType = BSStatusTagTypeNone;
//        _tagHeight = 0;
//    }
}

- (void)_layoutToolbar {
    // should be localized
    UIFont *font = [UIFont systemFontOfSize:kBSCellToolbarFontSize];
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, kBSCellToolbarHeight)];
    container.maximumNumberOfRows = 1;
    
    NSMutableAttributedString *repostText = [[NSMutableAttributedString alloc] initWithString:_status.repostsCount <= 0 ? @"转发" : [BSStatusHelper shortedNumberDesc:_status.repostsCount]];
    repostText.font = font;
    repostText.color = kBSCellToolbarTitleColor;
    _toolbarRepostTextLayout = [YYTextLayout layoutWithContainer:container text:repostText];
    _toolbarRepostTextWidth = CGFloatPixelRound(_toolbarRepostTextLayout.textBoundingRect.size.width);
    
    NSMutableAttributedString *commentText = [[NSMutableAttributedString alloc] initWithString:_status.commentsCount <= 0 ? @"评论" : [BSStatusHelper shortedNumberDesc:_status.commentsCount]];
    commentText.font = font;
    commentText.color = kBSCellToolbarTitleColor;
    _toolbarCommentTextLayout = [YYTextLayout layoutWithContainer:container text:commentText];
    _toolbarCommentTextWidth = CGFloatPixelRound(_toolbarCommentTextLayout.textBoundingRect.size.width);
    
    NSMutableAttributedString *likeText = [[NSMutableAttributedString alloc] initWithString:_status.favoriteCount <= 0 ? @"赞" : [BSStatusHelper shortedNumberDesc:_status.favoriteCount]];
    likeText.font = font;
    likeText.color = _status.favorited ? kBSCellToolbarTitleHighlightColor : kBSCellToolbarTitleColor;
    _toolbarLikeTextLayout = [YYTextLayout layoutWithContainer:container text:likeText];
    _toolbarLikeTextWidth = CGFloatPixelRound(_toolbarLikeTextLayout.textBoundingRect.size.width);
}




- (NSMutableAttributedString *)_textWithStatus:(BSTLModel  *)status
                                     isRetweet:(BOOL)isRetweet
                                      fontSize:(CGFloat)fontSize
                                     textColor:(UIColor *)textColor {
    if (!status) return nil;
    
    NSMutableString *string = status.text.mutableCopy;
    if (string.length == 0) return nil;
//    if (isRetweet) {
//        NSString *name = status.user.name;
//        if (name.length == 0) {
//            name = status.user.screenName;
//        }
//        if (name) {
//            NSString *insert = [NSString stringWithFormat:@"@%@:",name];
//            [string insertString:insert atIndex:0];
//        }
//    }
    // 字体
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    // 高亮状态的背景
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.cornerRadius = 3;
    highlightBorder.fillColor = kBSCellTextHighlightBackgroundColor;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    text.font = font;
    text.color = textColor;
    
    // 根据 urlStruct 中每个 URL.shortURL 来匹配文本，将其替换为图标+友好描述
//    for (BSURL *wburl in status.urlStruct) {
//        if (wburl.shortURL.length == 0) continue;
//        if (wburl.urlTitle.length == 0) continue;
//        NSString *urlTitle = wburl.urlTitle;
//        if (urlTitle.length > 27) {
//            urlTitle = [[urlTitle substringToIndex:27] stringByAppendingString:YYTextTruncationToken];
//        }
//        NSRange searchRange = NSMakeRange(0, text.string.length);
//        do {
//            NSRange range = [text.string rangeOfString:wburl.shortURL options:kNilOptions range:searchRange];
//            if (range.location == NSNotFound) break;
//            
//            if (range.location + range.length == text.length) {
//                if (status.pageInfo.pageID && wburl.pageID &&
//                    [wburl.pageID isEqualToString:status.pageInfo.pageID]) {
//                    if ((!isRetweet && !status.retweetedStatus) || isRetweet) {
//                        if (status.pics.count == 0) {
//                            [text replaceCharactersInRange:range withString:@""];
//                            break; // cut the tail, show with card
//                        }
//                    }
//                }
//            }
//            
//            if ([text attribute:YYTextHighlightAttributeName atIndex:range.location] == nil) {
//                
//                // 替换的内容
//                NSMutableAttributedString *replace = [[NSMutableAttributedString alloc] initWithString:urlTitle];
//                if (wburl.urlTypePic.length) {
//                    // 链接头部有个图片附件 (要从网络获取)
//                    NSURL *picURL = [BSStatusHelper defaultURLForImageURL:wburl.urlTypePic];
//                    UIImage *image = [[YYImageCache sharedCache] getImageForKey:picURL.absoluteString];
//                    NSAttributedString *pic = (image && !wburl.pics.count) ? [self _attachmentWithFontSize:fontSize image:image shrink:YES] : [self _attachmentWithFontSize:fontSize imageURL:wburl.urlTypePic shrink:YES];
//                    [replace insertAttributedString:pic atIndex:0];
//                }
//                replace.font = font;
//                replace.color = kBSCellTextHighlightColor;
//                
//                // 高亮状态
//                YYTextHighlight *highlight = [YYTextHighlight new];
//                [highlight setBackgroundBorder:highlightBorder];
//                // 数据信息，用于稍后用户点击
//                highlight.userInfo = @{kBSLinkURLName : wburl};
//                [replace setTextHighlight:highlight range:NSMakeRange(0, replace.length)];
//                
//                // 添加被替换的原始字符串，用于复制
//                YYTextBackedString *backed = [YYTextBackedString stringWithString:[text.string substringWithRange:range]];
//                [replace setTextBackedString:backed range:NSMakeRange(0, replace.length)];
//                
//                // 替换
//                [text replaceCharactersInRange:range withAttributedString:replace];
//                
//                searchRange.location = searchRange.location + (replace.length ? replace.length : 1);
//                if (searchRange.location + 1 >= text.length) break;
//                searchRange.length = text.length - searchRange.location;
//            } else {
//                searchRange.location = searchRange.location + (searchRange.length ? searchRange.length : 1);
//                if (searchRange.location + 1>= text.length) break;
//                searchRange.length = text.length - searchRange.location;
//            }
//        } while (1);
//    }
    
    // 根据 topicStruct 中每个 Topic.topicTitle 来匹配文本，标记为话题
//    for (BSTopic *topic in status.topicStruct) {
//        if (topic.topicTitle.length == 0) continue;
//        NSString *topicTitle = [NSString stringWithFormat:@"#%@#",topic.topicTitle];
//        NSRange searchRange = NSMakeRange(0, text.string.length);
//        do {
//            NSRange range = [text.string rangeOfString:topicTitle options:kNilOptions range:searchRange];
//            if (range.location == NSNotFound) break;
//            
//            if ([text attribute:YYTextHighlightAttributeName atIndex:range.location] == nil) {
//                [text setColor:kBSCellTextHighlightColor range:range];
//                
//                // 高亮状态
//                YYTextHighlight *highlight = [YYTextHighlight new];
//                [highlight setBackgroundBorder:highlightBorder];
//                // 数据信息，用于稍后用户点击
//                highlight.userInfo = @{kBSLinkTopicName : topic};
//                [text setTextHighlight:highlight range:range];
//            }
//            searchRange.location = searchRange.location + (searchRange.length ? searchRange.length : 1);
//            if (searchRange.location + 1>= text.length) break;
//            searchRange.length = text.length - searchRange.location;
//        } while (1);
//    }
    
    // 匹配 @用户名
    NSArray *atResults = [[BSStatusHelper regexAt] matchesInString:text.string options:kNilOptions range:text.rangeOfAll];
    for (NSTextCheckingResult *at in atResults) {
        if (at.range.location == NSNotFound && at.range.length <= 1) continue;
        if ([text attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil) {
            [text setColor:kBSCellTextHighlightColor range:at.range];
            
            // 高亮状态
            YYTextHighlight *highlight = [YYTextHighlight new];
            [highlight setBackgroundBorder:highlightBorder];
            // 数据信息，用于稍后用户点击
            highlight.userInfo = @{kBSLinkAtName : [text.string substringWithRange:NSMakeRange(at.range.location + 1, at.range.length - 1)]};
            [text setTextHighlight:highlight range:at.range];
        }
    }
    
    // 匹配 [表情]
    NSArray *emoticonResults = [[BSStatusHelper regexEmoticon] matchesInString:text.string options:kNilOptions range:text.rangeOfAll];
    NSUInteger emoClipLength = 0;
    for (NSTextCheckingResult *emo in emoticonResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
        NSRange range = emo.range;
        range.location -= emoClipLength;
        if ([text attribute:YYTextHighlightAttributeName atIndex:range.location]) continue;
        if ([text attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        NSString *emoString = [text.string substringWithRange:range];
        NSString *imagePath = [BSStatusHelper emoticonDic][emoString];
        UIImage *image = [BSStatusHelper imageWithPath:imagePath];
        if (!image) continue;
        
        NSAttributedString *emoText = [NSAttributedString attachmentStringWithEmojiImage:image fontSize:fontSize];
        [text replaceCharactersInRange:range withAttributedString:emoText];
        emoClipLength += range.length - 1;
    }
    
    return text;
}


- (NSAttributedString *)_attachmentWithFontSize:(CGFloat)fontSize image:(UIImage *)image shrink:(BOOL)shrink {
    
    //    CGFloat ascent = YYEmojiGetAscentWithFontSize(fontSize);
    //    CGFloat descent = YYEmojiGetDescentWithFontSize(fontSize);
    //    CGRect bounding = YYEmojiGetGlyphBoundingRectWithFontSize(fontSize);
    
    // Heiti SC 字体。。
    CGFloat ascent = fontSize * 0.86;
    CGFloat descent = fontSize * 0.14;
    CGRect bounding = CGRectMake(0, -0.14 * fontSize, fontSize, fontSize);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0);
    
    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width;
    
    YYTextAttachment *attachment = [YYTextAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = contentInsets;
    attachment.content = image;
    
    if (shrink) {
        // 缩小~
        CGFloat scale = 1 / 10.0;
        contentInsets.top += fontSize * scale;
        contentInsets.bottom += fontSize * scale;
        contentInsets.left += fontSize * scale;
        contentInsets.right += fontSize * scale;
        contentInsets = UIEdgeInsetPixelFloor(contentInsets);
        attachment.contentInsets = contentInsets;
    }
    
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [atr setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
    [atr setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate);
    
    return atr;
}

- (NSAttributedString *)_attachmentWithFontSize:(CGFloat)fontSize imageURL:(NSString *)imageURL shrink:(BOOL)shrink {
    /*
     微博 URL 嵌入的图片，比临近的字体要小一圈。。
     这里模拟一下 Heiti SC 字体，然后把图片缩小一下。
     */
    CGFloat ascent = fontSize * 0.86;
    CGFloat descent = fontSize * 0.14;
    CGRect bounding = CGRectMake(0, -0.14 * fontSize, fontSize, fontSize);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0);
    CGSize size = CGSizeMake(fontSize, fontSize);
    
    if (shrink) {
        // 缩小~
        CGFloat scale = 1 / 10.0;
        contentInsets.top += fontSize * scale;
        contentInsets.bottom += fontSize * scale;
        contentInsets.left += fontSize * scale;
        contentInsets.right += fontSize * scale;
        contentInsets = UIEdgeInsetPixelFloor(contentInsets);
        size = CGSizeMake(fontSize - fontSize * scale * 2, fontSize - fontSize * scale * 2);
        size = CGSizePixelRound(size);
    }
    
    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width;
    
    BSTextImageViewAttachment *attachment = [BSTextImageViewAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = contentInsets;
    attachment.size = size;
    attachment.imageURL = [BSStatusHelper defaultURLForImageURL:imageURL];
    
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [atr setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
    [atr setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate);
    
    return atr;
}

- (BSTextLinePositionModifier *)_textlineModifier {
    static BSTextLinePositionModifier *mod;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mod = [BSTextLinePositionModifier new];
        mod.font = [UIFont fontWithName:@"Heiti SC" size:kBSCellTextFontSize];
        mod.paddingTop = 10;
        mod.paddingBottom = 10;
    });
    return mod;
}

@end
