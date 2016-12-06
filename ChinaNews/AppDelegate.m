//
//  AppDelegate.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/21.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "AppDelegate.h"
#import "CRIDrawerViewController.h"
#import "CNHomePageViewController.h"
#import "CNMyViewController.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
    CNHomePageViewController *homePageVC = [[CNHomePageViewController alloc] init];
    UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:homePageVC];
    mainNC.navigationBar.translucent = NO;
    mainNC.navigationBar.barTintColor = [CNColor getMainColorWithAlpha:1.];        //导航栏背景颜色
    mainNC.navigationBar.tintColor = [UIColor whiteColor];          //导航栏返回按钮颜色
    [mainNC.navigationBar setTitleTextAttributes:@{NSFontAttributeName: CN_FONTTSIZE(20.),NSForegroundColorAttributeName: [UIColor whiteColor]}];    //导航栏标题大小及颜色
    CNMyViewController *myVC = [[CNMyViewController alloc] init];
    
    _window.rootViewController = [CRIDrawerViewController drawerVCWithMainVC:mainNC leftVC:myVC leftVCMaxWidth:300*CN_WIDTH_BASE];
    
    [_window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Close Rotation

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{

    if ([NSStringFromClass([[[window subviews] lastObject] class]) isEqualToString:@"UITransitionView"]) {
        //优酷 土豆  乐视  已经测试可以
        return UIInterfaceOrientationMaskAll;
    }
    
    return UIInterfaceOrientationMaskPortrait;
}

@end
