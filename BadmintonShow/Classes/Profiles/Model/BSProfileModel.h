//
//  BSProfileModel.h
//  BadmintonShow
//
//  Created by lizhihua on 12/14/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BSProfileModel(imgName,tle,dtl,clsName) \
        [BSProfileModel modelWithImageName:imgName title:tle detail:dtl className:clsName]

@interface BSProfileModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *className; // 点击Cell跳转的ViewController
@property (nonatomic, copy) NSString *thumbnailUrl; // 图片缩略图url
@property (nonatomic, copy) NSString *thumbnailPath; // 图片缩略图path

+ (instancetype)modelWithImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail className:(NSString *)className;

- (instancetype)setImageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail className:(NSString *)className;


@end
