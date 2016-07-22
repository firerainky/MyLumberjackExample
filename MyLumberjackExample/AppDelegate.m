//
//  AppDelegate.m
//  MyLumberjackExample
//
//  Created by zhengkanyan on 16/7/5.
//  Copyright © 2016年 zhengkanyan. All rights reserved.
//

#import "AppDelegate.h"
#import "Logger.h"
#import "MyCustomFormatter.h"
#import "ErrorLogFileManager.h"
#import "FatalLogFileManager.h"
#import "ErrorCustomFormatter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    MyCustomFormatter *formatter = [[MyCustomFormatter alloc] init];
    [DDTTYLogger sharedInstance].logFormatter = formatter;
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:LOG_LEVEL_FATAL];
    
    // Set the path of log files
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *logsDirectory = [documentsDirectory stringByAppendingPathComponent:@"logtest"];
    
    ErrorLogFileManager *errorLogFileManager = [[ErrorLogFileManager alloc] initWithLogsDirectory:logsDirectory];
    errorLogFileManager.maximumNumberOfLogFiles = 7;
    
    FatalLogFileManager *fatalLogFileManager = [[FatalLogFileManager alloc] initWithLogsDirectory:logsDirectory];
    fatalLogFileManager.maximumNumberOfLogFiles = 7;
    
    DDFileLogger *errorFileLogger = [[DDFileLogger alloc] initWithLogFileManager:errorLogFileManager];
    DDFileLogger *fatalFileLogger = [[DDFileLogger alloc] initWithLogFileManager:fatalLogFileManager];
    
    // File logger rolling stragegy
    errorFileLogger.maximumFileSize = 1024 * 1024 * 2;
//    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    errorFileLogger.rollingFrequency = 60 * 60 * 24;   // 1 min rolling
    
    fatalFileLogger.maximumFileSize = 1024 * 1024 * 2;
    //    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fatalFileLogger.rollingFrequency = 60 * 60 * 24;   // 1 min rolling
    
    errorFileLogger.logFormatter = [[ErrorCustomFormatter alloc] init];
    fatalFileLogger.logFormatter = formatter;
    
    [DDLog addLogger:errorFileLogger withLevel:LOG_LEVEL_ERROR];
    [DDLog addLogger:fatalFileLogger withLevel:LOG_LEVEL_FATAL];
    
    LogFatal(@"wakaka", @"%@", logsDirectory);
    
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
