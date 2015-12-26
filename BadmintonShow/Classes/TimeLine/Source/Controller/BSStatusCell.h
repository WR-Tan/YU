//
//  BSFeedCell.h
//  YYKitExample
//
//  Created by ibireme on 15/9/5.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYKit.h"
#import "BSStatusLayout.h"
#import "YYTableViewCell.h"
@class BSStatusCell;
@protocol BSStatusCellDelegate;


@interface BSStatusTitleView : UIView
@property (nonatomic, strong) YYLabel *titleLabel;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, weak) BSStatusCell *cell;
@end

@interface BSStatusProfileView : UIView
@property (nonatomic, strong) UIImageView *avatarView; ///< 头像
@property (nonatomic, strong) UIImageView *avatarBadgeView; ///< 徽章
@property (nonatomic, strong) YYLabel *nameLabel;
@property (nonatomic, strong) YYLabel *sourceLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, assign) BSUserVerifyType verifyType;
@property (nonatomic, weak) BSStatusCell *cell;
@end


@interface BSStatusCardView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *badgeImageView;
@property (nonatomic, strong) YYLabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) BSStatusCell *cell;
@end


@interface BSStatusToolbarView : UIView
@property (nonatomic, strong) UIButton *repostButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *likeButton;

@property (nonatomic, strong) UIImageView *repostImageView;
@property (nonatomic, strong) UIImageView *commentImageView;
@property (nonatomic, strong) UIImageView *likeImageView;

@property (nonatomic, strong) YYLabel *repostLabel;
@property (nonatomic, strong) YYLabel *commentLabel;
@property (nonatomic, strong) YYLabel *likeLabel;

@property (nonatomic, strong) CAGradientLayer *line1;
@property (nonatomic, strong) CAGradientLayer *line2;
@property (nonatomic, strong) CALayer *topLine;
@property (nonatomic, strong) CALayer *bottomLine;
@property (nonatomic, weak) BSStatusCell *cell;

- (void)setWithLayout:(BSStatusLayout *)layout;
// set both "liked" and "likeCount"
- (void)setLiked:(BOOL)liked withAnimation:(BOOL)animation;
@end


@interface BSStatusTagView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) YYLabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) BSStatusCell *cell;
@end




@interface BSStatusView : UIView
@property (nonatomic, strong) UIView *contentView;              // 容器
@property (nonatomic, strong) BSStatusTitleView *titleView;     // 标题栏
@property (nonatomic, strong) BSStatusProfileView *profileView; // 用户资料
@property (nonatomic, strong) YYLabel *textLabel;               // 文本
@property (nonatomic, strong) NSArray *picViews;                // 图片 Array<UIImageView>
@property (nonatomic, strong) UIView *retweetBackgroundView;    //转发容器
@property (nonatomic, strong) YYLabel *retweetTextLabel;        // 转发文本
@property (nonatomic, strong) BSStatusCardView *cardView;       // 卡片
@property (nonatomic, strong) BSStatusTagView *tagView;         // 下方Tag
@property (nonatomic, strong) BSStatusToolbarView *toolbarView; // 工具栏
@property (nonatomic, strong) UIImageView *vipBackgroundView;   // VIP 自定义背景
@property (nonatomic, strong) UIButton *menuButton;             // 菜单按钮
@property (nonatomic, strong) UIButton *followButton;           // 关注按钮

@property (nonatomic, strong) BSStatusLayout *layout;
@property (nonatomic, weak) BSStatusCell *cell;
@end



@protocol BSStatusCellDelegate;
@interface BSStatusCell : YYTableViewCell
@property (nonatomic, weak) id<BSStatusCellDelegate> delegate;
@property (nonatomic, strong) BSStatusView *statusView;
- (void)setLayout:(BSStatusLayout *)layout;
@end



@protocol BSStatusCellDelegate <NSObject>
@optional
/// 点击了 Cell
- (void)cellDidClick:(BSStatusCell *)cell;
/// 点击了 Card
- (void)cellDidClickCard:(BSStatusCell *)cell;
/// 点击了转发内容
- (void)cellDidClickRetweet:(BSStatusCell *)cell;
/// 点击了Cell菜单
- (void)cellDidClickMenu:(BSStatusCell *)cell;
/// 点击了关注
- (void)cellDidClickFollow:(BSStatusCell *)cell;
/// 点击了转发
- (void)cellDidClickRepost:(BSStatusCell *)cell;
/// 点击了下方 Tag
- (void)cellDidClickTag:(BSStatusCell *)cell;
/// 点击了评论
- (void)cellDidClickComment:(BSStatusCell *)cell;
/// 点击了赞
- (void)cellDidClickLike:(BSStatusCell *)cell;
/// 点击了用户
- (void)cell:(BSStatusCell *)cell didClickUser:(BSProfileUserModel *)user;
/// 点击了图片
- (void)cell:(BSStatusCell *)cell didClickImageAtIndex:(NSUInteger)index;
/// 点击了 Label 的链接
- (void)cell:(BSStatusCell *)cell didClickInLabel:(YYLabel *)label textRange:(NSRange)textRange;
@end
