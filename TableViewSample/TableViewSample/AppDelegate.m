//
//  AppDelegate.m
//  TableViewSample
//
//  Created by ELA on 16/12/15.
//  Copyright © 2015 test. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *vc=[[ViewController alloc]init];
    self.window.rootViewController = vc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self registerForRemoteNotification];
    return YES;
}

- (void)registerForRemoteNotification {
    UIUserNotificationType types = UIUserNotificationTypeSound |
                                   UIUserNotificationTypeBadge |
                                    UIUserNotificationTypeAlert;  // to get permission to provide notification on the notification screen (once)
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification   //detects the Local Notification delivery

{
    if ( application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground  ) //checks if the application is opend thround the notification bar
    {
        //opened from a push notification when the app was on background
        [UIApplication sharedApplication].applicationIconBadgeNumber=0;  //resets the batch count
        NSLog(@"notifcation value %@",notification.alertBody);
        ViewController* mainController = (ViewController*)  self.window.rootViewController;
        [mainController savedb:notification.alertBody];  // calls the function on the main controller

        
    }
    
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
    NSLog(@"hai");
    ViewController* mainController = (ViewController*)  self.window.rootViewController;
    [mainController settime];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
