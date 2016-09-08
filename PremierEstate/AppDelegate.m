//
//  AppDelegate.m
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "AppDelegate.h"
#import "PortfolioVC.h"
#import "RequestManager.h"
#import "MBProgressHUD.h"

@interface AppDelegate ()
{
    MBProgressHUD* hud;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];

    [self initNavigation];
    
    self.window.rootViewController = _navController;
    
    [self.window makeKeyAndVisible];
    
   
    // Override point for customization after application launch.
    return YES;
}


-(void)initNavigation
{
    PortfolioVC* p = [[PortfolioVC alloc]initWithNibName:@"PortfolioVC" bundle:nil];
    // portfolio vc will also be the a container for other views
    _navController = [[UINavigationController alloc]initWithRootViewController:p];
    
    _navController.navigationBar.translucent = NO;
     [[UINavigationBar appearance] setBarTintColor:[UIColor viewFlipsideBackgroundColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}




-(void)getData
{
    
    [[RequestManager sharedManager] getCities:^(id result, NSError *error) {
        _arrCities = result;
    }];
    
    [[RequestManager sharedManager] getDistricts:^(id result, NSError *error) {
        _arrDistricts = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
            if (error!= nil) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Oops"message:@"Please connect to the internet"                                                                                                                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av show];
                
            }
        });
    }];
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
