//
//  AppDelegate.h
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController* navController;
//@property (strong, nonatomic) SideMenuVC* sideMenuVC;

@property (strong, nonatomic) NSMutableArray* arrCities;
@property (strong, nonatomic) NSMutableArray* arrDistricts;
@end

