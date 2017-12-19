//
//  GPTabBar.h
//  MiddleBulgeTabbar
//
//  Created by chen on 2016/12/8.
//  Copyright © 2016年 Gorpeln. All rights reserved.
//


#import <UIKit/UIKit.h>

@class GPTabBar;

@protocol GPTabBarDelegate <NSObject>
@optional

- (void)tabBarPlusBtnClick:(GPTabBar *)tabBar clickForCenterButton:(UIButton *)centerButton;
@end


@interface GPTabBar : UITabBar

/** tabbar的代理 */
@property (nonatomic, weak) id<GPTabBarDelegate> myDelegate ;

@end
