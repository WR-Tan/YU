//
//  BSTabBarController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSTabBarController.h"
#import "BSRankController.h"
#import "BSNavigationController.h"
#import "BSChatController.h"
#import "BSDiscoverController.h"
#import "BSProfileController.h"
#import "BSHomePageViewController.h"

@interface BSTabBarController ()

@end

@implementation BSTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildTabBar];
    }
    return self;
}



- (void)buildTabBar
{
    UIImage *userImage = [UIImage imageNamed:@"xxxx"];
    // 首页资讯
//    BSHomePageViewController *homePageVC = [[BSHomePageViewController alloc] init];
//    BSNavigationController *homePageNav = [[BSNavigationController alloc] initWithRootViewController:homePageVC];
//    UIImage *yuxiuImage = [UIImage imageNamed:@"YUXIU_Tabbar"];
//    UITabBarItem *homePageItem = [[UITabBarItem alloc] initWithTitle:@"羽秀" image:yuxiuImage tag:1];
//    homePageNav.tabBarItem = homePageItem;
    
    //  排名
    BSRankController *rank = [[BSRankController alloc] init ];
    BSNavigationController *rankNav = [[BSNavigationController alloc] initWithRootViewController:rank];
    UITabBarItem *rankItem = [[UITabBarItem alloc] initWithTitle:@"排名" image:userImage tag:2];
    rankNav.tabBarItem = rankItem;
    
  
    //  聊天
    BSChatController *chat = [[BSChatController alloc] init];
    BSNavigationController *chatNav = [[BSNavigationController alloc] initWithRootViewController:chat];
    UITabBarItem *chatItem = [[UITabBarItem alloc] initWithTitle:@"聊天" image:nil tag:3];
    chatNav.tabBarItem = chatItem;
    

    
    BSProfileController *mine  = [[BSProfileController alloc] init];
    BSNavigationController *mineNav = [[BSNavigationController alloc] initWithRootViewController:mine];
//    UITabBarItem *mineItem = [[UITabBarItem alloc] initWithTitle:@"我" image:nil tag:0];
//    UIImage *userImage = [UIImage imageNamed:@"user"];
    UITabBarItem *mineItem = [[UITabBarItem alloc] initWithTitle:@"我" image:userImage selectedImage:userImage];
    mineNav.tabBarItem = mineItem;
 
    
    self.viewControllers = @[rankNav,chatNav,mineNav];
}

@end
