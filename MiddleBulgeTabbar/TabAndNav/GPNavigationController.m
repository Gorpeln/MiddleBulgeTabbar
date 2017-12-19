//
//  GPNavigationController.m
//  MiddleBulgeTabbar
//
//  Created by chen on 2016/12/8.
//  Copyright © 2016年 Gorpeln. All rights reserved.
//


#import "GPNavigationController.h"
#import "GPTabBarViewController.h"

@interface GPNavigationController ()

@end

@implementation GPNavigationController

+ (void)load{
    UIBarButtonItem *item=[UIBarButtonItem appearanceWhenContainedIn:self, nil ];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    dic[NSForegroundColorAttributeName]=[UIColor blackColor];
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];

    if (@available(iOS 9.0, *)) {
        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        NSMutableDictionary *dicBar=[NSMutableDictionary dictionary];
        dicBar[NSFontAttributeName]=[UIFont systemFontOfSize:15];
        [bar setTitleTextAttributes:dic];
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    return [super pushViewController:viewController animated:animated];
}

@end
