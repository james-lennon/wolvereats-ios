//
//  AppDelegate.m
//  WolverEats
//
//  Created by Cameron Cohen and Amelia Miller on 2/3/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingViewController.h"
#import "TripsListViewController.h"
#import "ProfileViewController.h"
#import "MyTripsListViewController.h"
#import "OrdersListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /* Create window */
    LoadingViewController *loadingController = [[LoadingViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = loadingController;
    
    [self.window makeKeyAndVisible];
    
    UINavigationController *tripsNav = [[UINavigationController alloc] initWithRootViewController:[[TripsListViewController alloc] init]];
    UINavigationController *profileNav = [[UINavigationController alloc] initWithRootViewController:[[ProfileViewController alloc] init]];
     UINavigationController *ordersNav = [[UINavigationController alloc] initWithRootViewController:[[OrdersListViewController alloc] init]];
    UINavigationController *myTripsNav = [[UINavigationController alloc] initWithRootViewController:[[MyTripsListViewController alloc] init]];
    loadingController.viewControllers = @[tripsNav, myTripsNav, ordersNav, profileNav];

    //[[UINavigationBar appearance]setBarTintColor: [UIColor colorWithRed:(42/255.0f) green:(179/255.0f) blue:(139/255.0f) alpha:1]];

    [[UINavigationBar appearance]setTintColor:[UIColor colorWithRed:(42/255.0f) green:(179/255.0f) blue:(139/255.0f) alpha:1]];
    //[[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.window setBackgroundColor:[UIColor whiteColor]];

    [UITabBarItem.appearance setTitleTextAttributes:
     @{NSForegroundColorAttributeName : [UIColor colorWithRed:(42/255.0f) green:(179/255.0f) blue:(139/255.0f) alpha:1]}
                                           forState:UIControlStateSelected];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:(42/255.0f) green:(179/255.0f) blue:(139/255.0f) alpha:1]];
    
    return YES;
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
