//
//  AppDelegate.m
//  BadmintonShow
//
//  Created by lzh on 15/6/14.
//  Copyright (c) 2015年 LZH. All rights reserved.
//

#import "AppDelegate.h"
#import "BSTabBarController.h"
#import "NewFeatureController.h"
#import "BSLoginController.h"
#import "BSNavigationController.h"

#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

//  从LeanChat搬过来的代码
//  LeanChat imports - 1
#import "CDCommon.h"
#import "CDLoginVC.h"
#import "CDBaseTabC.h"
#import "CDBaseNavC.h"
#import "CDConvsVC.h"
#import "CDFriendListVC.h"
#import "CDProfileVC.h"
#import "CDAbuseReport.h"
#import "CDCacheManager.h"

//  LeanChat imports - 2
#import "CDUtils.h"
#import "CDAddRequest.h"
#import "CDIMService.h"
#import "LZPushManager.h"
#import <iRate/iRate.h>
#import <iVersion/iVersion.h>
#import <LeanCloudSocial/AVOSCloudSNS.h>
#import <OpenShare/OpenShareHeader.h>
#import "BSDBManager.h"
#import "BSRegisterUserNameController.h"

//  自己的appID和key
//  羽秀
static  NSString *kAVOSCloudID = @"6RUURXEoKPYQ3MCf3eX30tQI";
static  NSString *kAVOSCloudKey = @"OTdaWMltiPg9WNcY7SEvK9HC";


//  公共的key，请替换成自己的id和key ，或用 leancloud@163.com/Public123  登录，来查看后台数据
#define AVOSCloudAppID  @"ohqhxu3mgoj2eyj6ed02yliytmbes3mwhha8ylnc215h0bgk"
#define AVOSCloudAppKey @"6j8fuggqkbc5m86b8mp4pf2no170i5m7vmax5iypmi72wldc"


@interface AppDelegate ()
@property (nonatomic, strong) BSTabBarController *tabBarCtl;
@property (nonatomic, strong) BSLoginController *loginCtl;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [BSDBManager initDBWithID:[AVUser currentUser].objectId];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 1.Override point for customization after application launch.
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x25B6ED)];

    // 2.LeanCloud
    [AVOSCloud setApplicationId:kAVOSCloudID
                      clientKey:kAVOSCloudKey];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [AVOSCloud setLastModifyEnabled:YES];


    // 3.mainPage
    [self setFirstPage:application];
    
    //  4.LeanChat Settings
    [self  leanChatSetting];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}



#pragma mark - 设置首页
- (void)setFirstPage:(UIApplication *)application
{
    NSString *key = (NSString *)kCFBundleVersionKey;
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if ([AVUser currentUser]) {
        self.window.rootViewController = self.tabBarCtl;
        [self toMain]; // 主要是设置聊天
    } else {
        self.window.rootViewController =  [[UINavigationController alloc] initWithRootViewController:self.loginCtl];
    }   
}


#pragma mark - AVOSCloud/LeanChat Settings
- (void)leanChatSetting
{
    
    [CDAddRequest registerSubclass];
    [CDAbuseReport registerSubclass];
    
    [[LZPushManager manager] registerForRemoteNotification];
    
#ifdef DEBUG
    [AVPush setProductionMode:YES];  // 如果要测试申请好友是否有推送，请设置为 YES
    [AVAnalytics setAnalyticsEnabled:NO];
    [AVOSCloud setAllLogsEnabled:YES];
#endif

}


- (void)toMainCtl
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationKeyUserChanged object:nil];
    self.window.rootViewController = self.tabBarCtl;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //[[LZPushManager manager] cleanBadge];
    [application cancelAllLocalNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[LZPushManager manager] syncBadge];
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[LZPushManager manager] saveInstallationWithDeviceToken:deviceToken userId:[AVUser currentUser].objectId];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    DLog(@"%@", error);
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (application.applicationState == UIApplicationStateActive) {
        // 应用在前台时收到推送，只能来自于普通的推送，而非离线消息推送
    }
    else {
        //  当使用 https://github.com/leancloud/leanchat-cloudcode 云代码更改推送内容的时候
        //        {
        //            aps =     {
        //                alert = "lzwios : sdfsdf";
        //                badge = 4;
        //                sound = default;
        //            };
        //            convid = 55bae86300b0efdcbe3e742e;
        //        }
        [[CDChatManager manager] didReceiveRemoteNotification:userInfo];
        [AVAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
    DLog(@"receiveRemoteNotification");
}

- (void)toLogin {
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.loginCtl];
    self.tabBarCtl.selectedIndex = 0;
    
}

- (void)addItemController:(UIViewController *)itemController toTabBarController:(CDBaseTabC *)tab {
    CDBaseNavC *nav = [[CDBaseNavC alloc] initWithRootViewController:itemController];
    [tab addChildViewController:nav];
}

- (void)toMain{
    //  更新版本
    [iRate sharedInstance].applicationBundleID = @"BD.BadmintonShow";
    [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    [iRate sharedInstance].previewMode = NO;
    [iVersion sharedInstance].applicationBundleID = @"BD.BadmintonShow";
    [iVersion sharedInstance].previewMode = NO;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.window.rootViewController = self.tabBarCtl;
    
    
    if (![AVUser currentUser]) {
        return ;
    }
    
    [[CDCacheManager manager] registerUsers:@[[AVUser currentUser]]];
    WEAKSELF
    [CDChatManager manager].userDelegate = [CDIMService service];
    
#ifdef DEBUG
#warning 使用开发证书来推送，方便调试，具体可看这个变量的定义处
    [CDChatManager manager].useDevPushCerticate = YES;
#endif
    

    
    [[CDChatManager manager] openWithClientId:[AVUser currentUser].objectId callback: ^(BOOL succeeded, NSError *error) {
        DLog(@"%@", error);
//        weakSelf.window.rootViewController = tab;
    }];
    
    
    
}

#pragma mark -

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [AVOSCloudSNS handleOpenURL:url];
    [OpenShare handleOpenURL:url];
    return YES;
}



#pragma mark -  lazy
-(BSTabBarController *)tabBarCtl{
    if (!_tabBarCtl) {
        _tabBarCtl  = [[BSTabBarController alloc] init];
    }
    return _tabBarCtl;
}

-(BSLoginController *)loginCtl{
    if (!_loginCtl) {
        _loginCtl  = [[BSLoginController alloc] initWithNibName:@"BSLoginController" bundle:nil];
    }
    return _loginCtl;
}


@end
