//
//  UIImage+Image.h
//  XianYu
//
//  Created by li  bo on 16/5/28.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

/**
 *  根据颜色生成一张图片
 *  @param color 提供的颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  截图功能，根据尺寸截取view成为一张图片
 *
 *  @param view 需要截取的View
 *
 *  @return 新生成的已截取的图片
 */
+(UIImage *)imageWithCaputureView:(UIView *)view;


@end
