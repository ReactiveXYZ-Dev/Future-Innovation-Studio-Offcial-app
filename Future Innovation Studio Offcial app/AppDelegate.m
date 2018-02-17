//
//  AppDelegate.m
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-2-13.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import "AppDelegate.h"

#import "YISplashScreen.h"
#import "YISplashScreen+Migration.h" // extra need
#import "YISplashScreenAnimation.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _window.backgroundColor = [UIColor whiteColor] ;
    UIStoryboard * storyboard=[UIStoryboard storyboardWithName:[self storyboardName] bundle:nil];
    UIViewController *initialVC = [storyboard instantiateViewControllerWithIdentifier:@"root_vc"];
    self.window.rootViewController = initialVC;

    [self.window makeKeyAndVisible];
    return YES;

}
-(NSString*)storyboardName{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {    // The iOS device = iPhone or iPod Touch
        
        
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        
        if (iOSDeviceScreenSize.height == 480)
        {
            return @"Main_iPhone35";
        }
        
        else if (iOSDeviceScreenSize.height == 568)
        {
            return @"Main_iPhone40";
        }else{
            return 0;
        }
    }else{
        return 0;
    }
    
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
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"loaded"];
}

@end
