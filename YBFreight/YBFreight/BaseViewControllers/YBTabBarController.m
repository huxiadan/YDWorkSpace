//
//  YBTabBarController.m
//  YBFreight
//
//  Created by lowell on 5/22/16.
//  Copyright © 2016 Y&D. All rights reserved.
//

#import "YBTabBarController.h"
#import "YBFreightVC.h"
#import "YBOrderVC.h"
#import "YBPersonalCenterVC.h"

@interface YBTabBarController()<RDVTabBarControllerDelegate>

@end

@implementation YBTabBarController

+ (YBTabBarController *)createTabBarController {
    YBTabBarController *tabBarController = [[YBTabBarController alloc] init];
    tabBarController.delegate = tabBarController;
    return tabBarController;
}

- (instancetype)init {
    if (self = [super init]) {
        YBFreightVC *vc = [YBFreightVC new];
        UINavigationController *firstNav = [[UINavigationController alloc]
                                           initWithRootViewController:vc];
        
        YBOrderVC *orderVC = [YBOrderVC new];
        UINavigationController *secondNav = [[UINavigationController alloc]
                                             initWithRootViewController:orderVC];
        
        YBPersonalCenterVC *personVC = [YBPersonalCenterVC new];
        UINavigationController *thirdNav = [[UINavigationController alloc]
                                            initWithRootViewController:personVC];
        [self setViewControllers:@[firstNav, secondNav, thirdNav]];
        [self setupViewControllers];
        self.title = @"找货";
        self.delegate = self;
    }
    return self;
}

- (void)setupViewControllers {
    [self customizeTabBarForController:self];
}

- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    switch (tabBarController.selectedIndex) {
        case 0:
            self.title = @"找货";
            break;
        case 1:
            self.title = @"订单";
            break;
        case 2:
            self.title = @"我的";
            break;
        default:
            break;
    }
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    NSArray *tabBarItemImages = @[@"icon_freight_normal", @"icon_order_normal", @"icon_person_normal"];
    NSArray *tabBarItemSelectImages = @[@"icon_freight_highlight", @"icon_order_highlight", @"icon_person_highlight"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        UIImage *selectedimage = [UIImage imageNamed:tabBarItemSelectImages[index]];
        UIImage *unselectedimage = [UIImage imageNamed:tabBarItemImages[index]];
        [item setBackgroundColor:[UIColor whiteColor]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        index++;
    }
}

@end
