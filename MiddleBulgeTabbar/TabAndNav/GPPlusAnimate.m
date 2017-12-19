//
//  GPPlusAnimate.m
//  MiddleBulgeTabbar
//
//  Created by chen on 2016/12/8.
//  Copyright © 2016年 Gorpeln. All rights reserved.
//


#import "GPPlusAnimate.h"

#define numOfRow        3
#define kWidth          [UIScreen mainScreen].bounds.size.width
#define kHeight         [UIScreen mainScreen].bounds.size.height
#define kScale          [UIScreen mainScreen].bounds.size.width /375.0
#define CenterPointX    kWidth/2
#define kItemWidth      kWidth /2 /3
#define kItemPadding    kWidth /2 /4


@interface GPPlusAnimate()
//center button
@property (strong , nonatomic) UIButton         *CenterBtn;
//other function button
@property (strong , nonatomic) NSMutableArray   *BtnItem;
@property (strong , nonatomic) NSMutableArray   *BtnItemTitle;
/** rect */
@property (nonatomic,assign)   CGRect           rect;

@end

@implementation GPPlusAnimate

/**
 *  show view
 */
+ (GPPlusAnimate *)standardPublishAnimateWithView:(UIView *)view{
    GPPlusAnimate * animateView = [[GPPlusAnimate alloc]init];
    CGFloat animateViewWidth = kItemWidth;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:animateView];
    CGRect rect = [animateView convertRect:view.frame fromView:view.superview];
    
    rect.size.height = animateViewWidth;
    rect.origin.x = CenterPointX - animateViewWidth/2;
    rect.size.width = animateViewWidth;
    animateView.rect = rect;

    //Add button
    [animateView CrentBtnImageName:@"post_animate_camera" Title:@"拍照" tag:0];
    [animateView CrentBtnImageName:@"post_animate_album" Title:@"相册" tag:1];
    [animateView CrentBtnImageName:@"post_animate_akey" Title:@"一键转卖" tag:2];

    //Add center button
    [animateView CrentCenterBtnImageName:@"post_animate_add" tag:3];
    //Do animation
    [animateView AnimateBegin];
    return animateView;
}

- (instancetype)init{
    self = [super init];
    if (self){
        self.frame = [[UIScreen mainScreen]bounds];
        self.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.2];
        
        UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
        [visualEffectView setFrame:self.bounds];
        [self addSubview:visualEffectView];
    }
    return self;
}

/**
 *  creat button
 */
- (void)CrentBtnImageName:(NSString *)ImageName Title:(NSString *)Title tag:(int)tag{
//    if (_BtnItem.count >= 3)  return;
    CGRect rect = self.rect;
    rect.size = CGSizeMake(rect.size.width, rect.size.height);
    rect.origin = CGPointMake(rect.origin.x, rect.origin.y);
    UIButton * btn = [[UIButton alloc]initWithFrame:rect];
//    btn.backgroundColor = RANDOMCOLOR;
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    [self.BtnItem addObject:btn];
    [self.BtnItemTitle addObject:[self CrenterBtnTitle:Title]];
}

/**
 *  creat center button
 */
- (void)CrentCenterBtnImageName:(NSString *)ImageName tag:(int)tag{
    _CenterBtn = [[UIButton alloc]initWithFrame:self.rect];
    [_CenterBtn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [_CenterBtn addTarget:self action:@selector(cancelAnimation) forControlEvents:UIControlEventTouchUpInside];
    _CenterBtn.tag = tag;
    [self addSubview:_CenterBtn];
}

/**
 *  getter
 */
- (NSMutableArray *)BtnItem{
    if (!_BtnItem) {
        _BtnItem = [NSMutableArray array];
    }
    return _BtnItem;
}

- (NSMutableArray *)BtnItemTitle{
    if (!_BtnItemTitle) {
        _BtnItemTitle = [NSMutableArray array];
    }
    return _BtnItemTitle;
}

- (UILabel *)CrenterBtnTitle:(NSString *)Title{
    UILabel * lab = [[UILabel alloc]init];
    lab.textColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    lab.font = [UIFont fontWithName:@"heiti SC" size:13.0 *kScale];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = Title;
    [self addSubview:lab];
    return lab;
}

/**
 *  remove view and notice the selectIndex
 */
- (void)removeView:(UIButton*)btn{
    [self removeFromSuperview];
    [self.delegate didSelectBtnWithBtnTag:btn.tag];
}

/**
 *  click other space to cancle
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelAnimation];
}

/**
 *  button click
 */
- (void)BtnClick:(UIButton*)btn{
    [self.delegate didSelectBtnWithBtnTag:btn.tag];
    NSLog(@"===============   %ld  ================",(long)btn.tag);
    [self removeFromSuperview];
}

/**
 *  Do animation
 */
- (void)AnimateBegin{
    //centet button rotation
    [UIView animateWithDuration:0.2 animations:^{
        _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4-M_LOG10E);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4+M_LOG10E);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
            }];
        }];
    }];
    
    __block int  i = 0 , k = 0;
    for (UIView *  btn in _BtnItem) {
        //rotation
        [UIView animateWithDuration:0.7 delay:i*0.15 usingSpringWithDamping:0.45 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            btn.transform = CGAffineTransformScale(btn.transform, 1.0, 1.0);//缩放
            btn.center = CGPointMake((kItemWidth/2 + kItemPadding + (kItemWidth + kItemPadding) *(i++ % numOfRow)), self.frame.size.height - kItemWidth *3);
        } completion:nil];

        //move
        [UIView animateWithDuration:0.2 delay:i*0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            btn.transform = CGAffineTransformRotate (btn.transform, -M_2_PI);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                btn.transform = CGAffineTransformRotate (btn.transform, M_2_PI+M_LOG10E);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    btn.transform = CGAffineTransformRotate (btn.transform, -M_LOG10E);
                } completion:^(BOOL finished) {
                    UILabel * lab = (UILabel *)_BtnItemTitle[k++];
                    lab.frame = CGRectMake(0, 0, kItemWidth, 25 * kScale);
                    lab.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame) + 15 * kScale);
                }];
            }];
        }];
    }
    

}

/**
 *  Cancle animation
 */
- (void)cancelAnimation{
    //rotation
    [UIView animateWithDuration:0.1 animations:^{
        _CenterBtn.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        //move
        int n = (int)_BtnItem.count;
        for (int i = n-1; i>=0; i--){
            UIButton *btn = _BtnItem[i];
            [UIButton animateWithDuration:0.2 delay:0.1*(n-i) options:UIViewAnimationOptionTransitionCurlDown animations:^{
                btn.center = self.CenterBtn.center;
                btn.transform = CGAffineTransformMakeScale(1, 1);
                btn.transform = CGAffineTransformRotate(btn.transform, -M_PI_4);
                
                UILabel * lab = (UILabel *)_BtnItemTitle[i];
                [lab removeFromSuperview];
            } completion:^(BOOL finished) {
                [btn removeFromSuperview];
                if (i==0) {
                    [self removeFromSuperview];
                }
            }];
        }
    }];
}


@end
