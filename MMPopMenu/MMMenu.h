//
//  MMPopMenu.h
//  MMPopMenu
//
//  Created by 夏伟 on 2016/10/20.
//  Copyright © 2016年 夏伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MMMenu : NSObject

@property (nonatomic, copy) void(^dismissBlock)(MMMenu *menu);

+ (instancetype)sharedMenu;

+ (void)showMenuInView:(UIView *)view
               fromRect:(CGRect)rect
              menuItems:(NSArray *)menuItems;
+ (void)dismissMenu:(BOOL)animated;
+ (BOOL)isShowingInView:(UIView *)view;

+ (UIColor *)tintColor;
+ (void) setTintColor:(UIColor *)tintColor;

+ (UIColor *)lineColor;
+ (void) setLineColor:(UIColor *)lineColor;

+ (UIColor *)overlayColor;
+ (void) setOverlayColor:(UIColor *)overlayColor;

+ (UIFont *)titleFont;
+ (void)setTitleFont:(UIFont *)titleFont;

@end


@interface MMMenuItem : NSObject

@property (nonatomic, readonly, strong) UIImage *image;
@property (nonatomic, readonly, strong) NSString *title;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, strong) UIColor *foreColor;
@property (nonatomic, assign) NSTextAlignment alignment;

+ (instancetype)menuItem:(NSString *)title
                    image:(UIImage *)image
                   target:(id)target
                   action:(SEL)action;

@end
