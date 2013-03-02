//
//  AppDelegate.m
//  DimBoard
//
//  Created by conicacui on 30/1/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    MortgageRecordViewController* recordController = [[MortgageRecordViewController alloc] init];
    UINavigationController* recordNavController = [[UINavigationController alloc] initWithRootViewController:recordController];
    MortgageCalViewController* calController = [[MortgageCalViewController alloc] init];
    [calController setRecordViewController:recordController];
    UINavigationController* calNavController = [[UINavigationController alloc] initWithRootViewController:calController];

    UITabBarController* tabController = [[UITabBarController alloc] init];
        
    UITabBarItem* item1 = [[UITabBarItem alloc] initWithTitle:@"計算器" image:[UIImage imageNamed:@"cal.png"] tag:1];
    UITabBarItem* item2 = [[UITabBarItem alloc] initWithTitle:KEY_MY_MORTGAGE image:[UIImage imageNamed:@"record.png"] tag:2];
    
    [calNavController setTabBarItem:item1];
    [recordNavController setTabBarItem:item2];
    
    [tabController setViewControllers:[NSArray arrayWithObjects:calNavController,recordNavController,nil]];
    
    self.viewController = tabController;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
