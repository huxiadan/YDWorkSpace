//
//  AppDelegate.h
//  YBFreight
//
//  Created by lowell on 5/22/16.
//  Copyright © 2016 Y&D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) YBTabBarController *tabBarController;
@property (nonatomic, strong) UINavigationController *rootNavigationController;

@end

