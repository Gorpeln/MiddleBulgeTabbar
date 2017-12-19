//
//  GPTabBarViewController.m
//  MiddleBulgeTabbar
//
//  Created by chen on 2016/12/8.
//  Copyright © 2016年 Gorpeln. All rights reserved.
//


#import "GPTabBarViewController.h"

#import "GPNavigationController.h"

#import "HomeViewController.h"
#import "FishViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"

#import "GPTabBar.h"
#import "GPPlusAnimate.h"


@interface GPTabBarViewController ()<GPTabBarDelegate>

@end

@implementation GPTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setUpAllChildVC];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    GPTabBar *tabbar = [[GPTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
}


#pragma mark -
#pragma mark -- 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVC{
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self setUpOneChildVCWithRootVC:homeVC Image:@"home_normal" selectedImage:@"home_highlight" title:@"首页"];
    
    FishViewController *fishVC = [[FishViewController alloc] init];
    [self setUpOneChildVCWithRootVC:fishVC Image:@"fish_normal" selectedImage:@"fish_highlight" title:@"鱼塘"];

    MessageViewController *messageVC = [[MessageViewController alloc] init];
    [self setUpOneChildVCWithRootVC:messageVC Image:@"message_normal" selectedImage:@"message_highlight" title:@"消息"];
    
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    [self setUpOneChildVCWithRootVC:mineVC Image:@"account_normal" selectedImage:@"account_highlight" title:@"我的"];

}


#pragma mark - 初始化设置tabBar上面单个按钮的方法
/**
 *  
 *
 *  设置单个tabBarButton
 *
 *  @param rootVC        每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVCWithRootVC:(UIViewController *)rootVC Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title{
    
    GPNavigationController *nav = [[GPNavigationController alloc] initWithRootViewController:rootVC];

    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    rootVC.tabBarItem.image = myImage;
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rootVC.tabBarItem.selectedImage = mySelectedImage;

    rootVC.tabBarItem.title = title;
    rootVC.navigationItem.title = title;

    //调整tabbar字体位置
    [rootVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2.5)];
    
    //设置字体大小
    NSMutableDictionary *attrnor = [NSMutableDictionary dictionary];
    attrnor[NSFontAttributeName] = [UIFont systemFontOfSize:11.0];
    [rootVC.tabBarItem setTitleTextAttributes:attrnor forState:UIControlStateNormal];
    
    //设置字体颜色
    [rootVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [rootVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:255/255.0 green:222/255.0 blue:44/255.0 alpha:1.0]} forState:UIControlStateSelected];
    
    [self addChildViewController:nav];

}

#pragma mark -
#pragma mark -- LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(GPTabBar *)tabBar clickForCenterButton:(UIButton *)centerButton{

    [GPPlusAnimate standardPublishAnimateWithView:centerButton];

}



@end
