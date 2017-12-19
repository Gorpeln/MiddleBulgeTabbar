//
//  GPPlusAnimate.h
//  MiddleBulgeTabbar
//
//  Created by chen on 2016/12/8.
//  Copyright © 2016年 Gorpeln. All rights reserved.
//


#import <UIKit/UIKit.h>
//通知点击按钮协议
@protocol PublishAnimateDelegate <NSObject>
- (void)didSelectBtnWithBtnTag:(NSInteger)tag;
@end


@interface GPPlusAnimate : UIView
//通知点击按钮代理人
@property(weak,nonatomic) id<PublishAnimateDelegate> delegate;
//弹出动画view
+(GPPlusAnimate *)standardPublishAnimateWithView:(UIView *)view;

@end
