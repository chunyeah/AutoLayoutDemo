//
//  AppDelegate.m
//  CCAutoLayoutDemo
//
//  Created by Chun Ye on 10/27/14.
//  Copyright (c) 2014 Chun Tips. All rights reserved.
//

#import "CCAppDelegate.h"
#import "CCInstagramMainViewController.h"

@interface CCAppDelegate ()

@end

@implementation CCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    CCInstagramMainViewController *instagramMainViewController = [[CCInstagramMainViewController alloc] init];
    UINavigationController *windowRootViewController = [[UINavigationController alloc] initWithRootViewController:instagramMainViewController];
    
    self.window.rootViewController = windowRootViewController;
    
    return YES;
}

@end
