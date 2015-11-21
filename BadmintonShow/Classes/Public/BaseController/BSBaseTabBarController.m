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
    //  排名
    BSRankController *rank = [[BSRankController alloc] initWithStyle:UITableViewStyleGrouped];
    BSBaseNavigationController *rankNav = [[BSBaseNavigationController alloc] initWithRootViewController:rank];
    UITabBarItem *rankItem = [[UITabBarItem alloc] initWithTitle:@"排名" image:nil tag:0];
    rankNav.tabBarItem = rankItem;
    
    
    
    // 中心圆
//    UIViewController *vc = [[UIViewController alloc] init];
//    BSBaseNavigationController *nav = [[BSBaseNavigationController alloc] initWithRootViewController:vc];
//    UITabBarItem *vcItem = [[UITabBarItem alloc] initWithTitle:@"新建" image:nil tag:1];
//    nav.tabBarItem = vcItem;
     
 
    UIStoryboard *BSDiscover = [UIStoryboard storyboardWithName:@"BSDiscover" bundle:nil];
    BSDiscoverController *discover  = [BSDiscover instantiateViewControllerWithIdentifier:@"BSDiscoverController"];
    BSBaseNavigationController *discoverNav = [[BSBaseNavigationController alloc] initWithRootViewController:discover];
    UITabBarItem *discoverItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:nil tag:0];
    discoverNav.tabBarItem = discoverItem;
 
    //  聊天
    BSChatController *chat = [[BSChatController alloc] init];
    BSBaseNavigationController *chatNav = [[BSBaseNavigationController alloc] initWithRootViewController:chat];
    UITabBarItem *chatItem = [[UITabBarItem alloc] initWithTitle:@"聊天" image:nil tag:1];
    chatNav.tabBarItem = chatItem;
    

    
//    [weakSelf addItemController:[[CDConvsVC alloc] init] toTabBarController:tab];
//    [weakSelf addItemController:[[CDFriendListVC alloc] init] toTabBarController:tab];
//    [weakSelf addItemController:[[CDProfileVC alloc] init] toTabBarController:tab];

    
    
 
    UIStoryboard *BSMine = [UIStoryboard storyboardWithName:@"BSMine" bundle:nil];
    BSMineController *mine  = [BSMine instantiateViewControllerWithIdentifier:@"BSDiscoverController"];
    BSBaseNavigationController *mineNav = [[BSBaseNavigationController alloc] initWithRootViewController:mine];
    UITabBarItem *mineItem = [[UITabBarItem alloc] initWithTitle:@"我" image:nil tag:0];
    mineNav.tabBarItem = mineItem;
 
    
    self.viewControllers = @[rankNav,chatNav,mineNav];
}

@end
