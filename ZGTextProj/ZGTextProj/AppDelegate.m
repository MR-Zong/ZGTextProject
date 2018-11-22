//
//  AppDelegate.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/7/28.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UncaughtExceptionHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
//    NSLog(@"path %@",path);
    
    // Bundle 路径
    NSString *p = [[NSBundle mainBundle] pathForResource:@"myPlayer" ofType:@"mp4"];
//    NSLog(@"p %@",p);
    
    // Override point for customization after application launch.
    
//    InstallUncaughtExceptionHandler(); 
    
    ViewController *view = [[ViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:view];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;

    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSLog(@"openUrl %@",url);
    NSLog(@"options %@",options);
    
    NSString *sourceApp = options[UIApplicationOpenURLOptionsSourceApplicationKey];
    if ([@"com.apple.mobilesafari" isEqualToString:sourceApp]) {
        return NO;
    }
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


@end
