//
//  GYButton.h
//  GYButton
//
//  Created by x on 2017/12/19.
//  Copyright © 2017年 HLB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,GYControlState) {
    GYControlStateNormal,
    GYControlStateHighlighted,
    GYControlStateSelected
};

typedef NS_ENUM(NSInteger,GYButtonType) {
    /** 竖直排布 图片在上  文字在下 */
    GYButtonTypeVerticalImageTitle, //默认按钮类型  图片在上  文字在下
    
    /** 竖直排布 文字在上 图片在下 */
    GYButtonTypeVerticalTitleImage,
    
    /** 水平方向 图片在左 文字在在右 */
    GYButtonTypeHorizontalImageTitle,
    
    /** 水平方向 文字在左 图片在右 */
    GYButtonTypeHorizontalTitleImage
};

@interface GYButton : UIControl

+ (instancetype)button;
+ (instancetype)buttonWithType:(GYButtonType)buttonType;

/** 按钮类型 */
@property (nonatomic, readonly)GYButtonType buttonType;

/** 标题 */
@property (nonatomic, strong, readonly) UILabel *titleLable;

/** 文字的大小  默认字体大小是 default font size 15 */
@property (nonatomic, assign) CGFloat fontSize;

/** 图片 */
@property (nonatomic, strong, readonly) UIImageView *imageView;

/** 图片和文字之间的距离  default 5 */
@property (nonatomic, assign)CGFloat margin;

/** 
 文字与父控件的上下距离
 
 只在GYButtonTypeVerticalImageTitle和GYButtonTypeVerticalTitleImage 类型下才起作用
 GYButtonTypeVerticalImageTitle 为负 example: -2
 GYButtonTypeVerticalTitleImage 为正 example 2
 
 default 0
 */
@property (nonatomic, assign)CGFloat titleTopOrBottonMarginToSuperView;

/** 图片与父控件的左右距离 
 
 只在GYButtonTypeHorizontalImageTitle和GYButtonTypeHorizontalImageTitle 类型下才起作用 
 GYButtonTypeHorizontalImageTitle 为正 example: 2
 GYButtonTypeHorizontalImageTitle 为负 example: -2
 
 defalt 0 
 */
@property (nonatomic, assign) CGFloat imageLeftOrRightMarginSuperView;

/** 设置图片的大小 */ //default CGSize(30,30);
@property (nonatomic, assign)CGSize imageSize;

/** 单独设置图片的圆角 default 0*/
@property (nonatomic, assign) CGFloat imageCornerRadius;

- (void)setImage:(UIImage *)image forState:(GYControlState)state;
- (void)setTitle:(NSString *)title forState:(GYControlState)state;
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(GYControlState)state;
- (void)setTitleColor:(UIColor *)titleColor forState:(GYControlState)state;








@end
