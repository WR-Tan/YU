//
//  BSBaseTabBarController.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "BSBaseTabBarController.h"
#import "BSRankController.h"
#import "BSBaseNavigationController.h"
#import "BSChatController.h"
#import "BSDiscoverController.h"
#import "BSMineController.h"
#import "BSHomePageViewController.h"

@interface BSBaseTabBarController ()

@end

@implementation BSBaseTabBarController

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
    BSHomePageViewController *homePageVC = [[BSHomePageViewController alloc] init];
    BSBaseNavigationController *homePageNav = [[BSBaseNavigationController alloc] initWithRootViewController:homePageVC];
    UIImage *yuxiuImage = [UIImage imageNamed:@"YUXIU_Tabbar"];
    UITabBarItem *homePageItem = [[UITabBarItem alloc] initWithTitle:@"羽秀" image:yuxiuImage tag:1];
    homePageVC.navigationController.navigationBar.hidden = YES ;
    homePageNav.tabBarItem = homePageItem;
    
    //  排名
    BSRankController *rank = [[BSRankController alloc] initWithStyle:UITableViewStyleGrouped];
    BSBaseNavigationController *rankNav = [[BSBaseNavigationController alloc] initWithRootViewController:rank];
    UITabBarItem *rankItem = [[UITabBarItem alloc] initWithTitle:@"排名" image:userImage tag:2];
    rankNav.tabBarItem = rankItem;
    
 
//    UIStoryboard *BSDiscover = [UIStoryboard storyboardWithName:@"BSDiscover" bundle:nil];
//    BSDiscoverController *discover  = [BSDiscover instantiateViewControllerWithIdentifier:@"BSDiscoverController"];
//    BSBaseNavigationController *discoverNav = [[BSBaseNavigationController alloc] initWithRootViewController:discover];
//    UITabBarItem *discoverItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:nil tag:3];
//    discoverNav.tabBarItem = discoverItem;
 
    //  聊天
    BSChatController *chat = [[BSChatController alloc] init];
    BSBaseNavigationController *chatNav = [[BSBaseNavigationController alloc] initWithRootViewController:chat];
    UITabBarItem *chatItem = [[UITabBarItem alloc] initWithTitle:@"聊天" image:nil tag:3];
    chatNav.tabBarItem = chatItem;
    

    
    UIStoryboard *BSMine = [UIStoryboard storyboardWithName:@"BSMine" bundle:nil];
    BSMineController *mine  = [BSMine instantiateViewControllerWithIdentifier:@"BSDiscoverController"];
    BSBaseNavigationController *mineNav = [[BSBaseNavigationController alloc] initWithRootViewController:mine];
//    UITabBarItem *mineItem = [[UITabBarItem alloc] initWithTitle:@"我" image:nil tag:0];
//    UIImage *userImage = [UIImage imageNamed:@"user"];
    UITabBarItem *mineItem = [[UITabBarItem alloc] initWithTitle:@"我" image:userImage selectedImage:userImage];
    mineNav.tabBarItem = mineItem;
 
    
    self.viewControllers = @[homePageNav,rankNav,chatNav,mineNav];
}

@end
