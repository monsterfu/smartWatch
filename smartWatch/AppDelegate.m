//
//  AppDelegate.m
//  smartWatch
//
//  Created by Monster on 14-12-15.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/*
    smartAM
    创建时间:2014-12-31 16:15:13
    APP ID:1103881779
    APP KEY:sorkSPekuu2CfTnl
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [AVOSCloud setApplicationId:@""
//                      clientKey:@""];
//    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    //AppKey: 54a39ac6fd98c51fed000762
    
    [[ConnectionManager sharedInstance]startScanForDevice];
    
    if ([USER_DEFAULT boolForKey:KEY_First_Use] == NO) {
        [USER_DEFAULT setBool:YES forKey:KEY_First_Use];
        [USER_DEFAULT setInteger:2 forKey:KEY_HeightUnit];
        [USER_DEFAULT setInteger:1 forKey:KEY_WeightUnit];
        [USER_DEFAULT setInteger:1 forKey:KEY_LengthUnit];
    }
    [UMSocialData setAppKey:@"54a39ac6fd98c51fed000762"];
    [UMSocialQQHandler setQQWithAppId:@"1103881779" appKey:@"sorkSPekuu2CfTnl" url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
