//
//  EHTAppDelegate.m
//  The Wife
//
//  Created by Morgan Cabral on 1/30/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import "EHTAppDelegate.h"
#import "Nagging.h"
#import "EHTTask.h"
@import AudioToolbox;

#define EHTNaggNotification 111

#define EHTAlertCancelButton 0
#define EHTAlertOkayButton   1

@interface EHTAppDelegate () <UIAlertViewDelegate>
@property (assign, nonatomic) SystemSoundID naggingSound;
@end

static NSString *tasksCollectionStoragePath() {
    //NSString *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSLocalDomainMask, YES)[0];
    NSString *documents = @"~/Documents";
    return [documents stringByAppendingPathComponent:@"TaskCollection"];
}

@implementation EHTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:tasksCollectionStoragePath() isDirectory:NO]) {
        _taskCollection = [NSKeyedUnarchiver unarchiveObjectWithFile:tasksCollectionStoragePath()];
    } else {
        _taskCollection = [[EHTTaskCollection alloc] init];
    }
    // TODO: make sure that when the application is launched because a notification was selected, the applciation opens to the correct task view.
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
    if ([[NSFileManager defaultManager] fileExistsAtPath:tasksCollectionStoragePath() isDirectory:NO]) {
        [[NSFileManager defaultManager] removeItemAtPath:tasksCollectionStoragePath() error:NULL];
    }
    [NSKeyedArchiver archiveRootObject:_taskCollection toFile:tasksCollectionStoragePath()];
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
    if (self.naggingSound) {
        AudioServicesDisposeSystemSoundID(self.naggingSound);
    }
    _taskCollection = nil;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // Called when the application receives a local notification. Display the notification as an alert view if necessary.
    switch (application.applicationState) {
        case UIApplicationStateActive:
        {
            NSString *customNagg = notification.userInfo[EHTTaskNaggKey];
            NSString *nagg = customNagg == nil ? randomNaggingString() : customNagg;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[nagg stringByAppendingString:@"!"]
                                                            message:notification.alertBody
                                                           delegate:self
                                                  cancelButtonTitle:@"Ignore"
                                                  otherButtonTitles:notification.alertAction, nil];
            if (self.naggingSound) {
                AudioServicesDisposeSystemSoundID(self.naggingSound);
            }
            SystemSoundID naggSound = 0;
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL URLWithString:notification.soundName]), &naggSound);
            if (naggSound != 0) {
                self.naggingSound = naggSound;
                AudioServicesPlayAlertSound(naggSound);
            }
            
            alert.tag = EHTNaggNotification;
            [alert show];
        }
            break;
            
        case UIApplicationStateBackground:
            break;
            
        case UIApplicationStateInactive:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == EHTNaggNotification && buttonIndex == EHTAlertOkayButton) {
        NSLog(@"pressed okay");
    }
}

@end
