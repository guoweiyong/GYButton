//
//  GYButton.m
//  GYButton
//
//  Created by x on 2017/12/19.
//  Copyright © 2017年 HLB. All rights reserved.
//

#import "GYButton.h"

#define HEX(hex)             [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

@interface GYButton ()

@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) UILabel *titleLable;
@property (nonatomic, readwrite)GYButtonType buttonType;

/** 内容视图 */
@property (nonatomic, strong) UIView *contentView;

/** 图片和文字之间的距离 */
@property (nonatomic, strong) NSLayoutConstraint *marginHeightCons;

/** 图片的宽度约束 */
@property (nonatomic, strong) NSLayoutConstraint *imageWidthCons;

/** 图片的高度约束 */
@property (nonatomic, strong) NSLayoutConstraint *imageHeightCons;

/** 文字与父控件的上下距离约束 */
@property (nonatomic, strong) NSLayoutConstraint *titleTopOrBottomCons;

/** 图片与父控件的左右距离约束 */
@property (nonatomic, strong) NSLayoutConstraint *imageLeftOrRightCons;



/** 原始背景颜色 */
@property (nonatomic, strong) UIColor *originalBackgroundClor;

/** 原始文字颜色 */
@property (nonatomic, strong) UIColor *originalTitleColor;

/** 原始图片 */
@property (nonatomic, strong) UIImage *originalImage;

/** 原始文字 */
@property (nonatomic, strong) NSString *originalTitle;


/** 缓存按钮各种状态的背景颜色字典 */
@property (nonatomic, strong) NSMutableDictionary *backgroundColorDic;

/** 缓存按钮各种状态的标题颜色字典 */
@property (nonatomic, strong) NSMutableDictionary *titleColorDic;

/** 缓存按钮各种状态的标题字典 */
@property (nonatomic, strong) NSMutableDictionary *titleDic;

/** 缓存按钮各种状态的图片字典 */
@property (nonatomic, strong) NSMutableDictionary *imageDic;

@end

@implementation GYButton

+ (instancetype)button {
    return [[self alloc] init];
}

- (instancetype)init {
    self= [self initWithButtonType:GYButtonTypeVerticalImageTitle];
    return self;
}

+ (instancetype)buttonWithType:(GYButtonType)buttonType {
    return [[self alloc] initWithButtonType:buttonType];
}

- (instancetype)initWithButtonType:(GYButtonType)buttonType {
    self = [super init];
    if (self) {
        
        self.buttonType = buttonType;
        
        //初始化数据
        [self setupOriginalData];
        
        //初始化UI
        [self setupUI];
    }
    return self;
}

- (void)setupOriginalData {
    self.margin = 5;
    self.titleTopOrBottonMarginToSuperView = 0;
    self.imageLeftOrRightMarginSuperView = 0;
    self.originalBackgroundClor = self.backgroundColor;
    self.originalImage = self.imageView.image;
    self.originalTitle = self.titleLable.text;
    self.originalTitleColor = self.titleLable.textColor;
}

- (void)setupUI {
    
    //1.添加子控件
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLable];
    
    //2.布局子控件
    NSMutableArray *cons = [NSMutableArray array];
    NSDictionary *dics = @{@"contentView":self.contentView,@"imageView":self.imageView,@"titleLable":self.titleLable};
    
    //2.1布局内容视图
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[contentView]-0-|" options:0 metrics:nil views:dics]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[contentView]-0-|" options:0 metrics:nil views:dics]];
    
    self.imageWidthCons = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    [cons addObject:_imageWidthCons];
    self.imageHeightCons = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    [cons addObject:_imageHeightCons];
    
    //2.2布局图片和按钮
    switch (self.buttonType) {
            
        case GYButtonTypeVerticalImageTitle:
        {
            //布局图片
            [cons addObject:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
            //Optional
//            [cons addObject:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
            
            //布局文字
            self.titleTopOrBottomCons = [NSLayoutConstraint constraintWithItem:self.titleLable attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:self.titleTopOrBottonMarginToSuperView];
            [cons addObject:_titleTopOrBottomCons];
            
            self.marginHeightCons = [NSLayoutConstraint constraintWithItem:self.titleLable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:self.margin];
            [cons addObject:_marginHeightCons];
            [cons addObject:[NSLayoutConstraint constraintWithItem:self.titleLable attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        }
            break;
          
        case GYButtonTypeVerticalTitleImage:
        {
            //布局文字
            [cons addObject:[NSLayoutConstraint constraintWithItem:self.titleLable attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
            self.titleTopOrBottomCons = [NSLayoutConstraint constraintWithItem:self.titleLable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.titleTopOrBottonMarginToSuperView];
            [cons addObject:_titleTopOrBottomCons];
            
            //布局图片
            self.marginHeightCons = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLable attribute:NSLayoutAttributeBottom multiplier:1.0 constant:self.margin];
            [cons addObject:_marginHeightCons];
            [cons addObject:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
            
        }
            break;
            
        case GYButtonTypeHorizontalImageTitle:
        {
            //布局图片
            [cons addObject:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            self.imageLeftOrRightCons = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.imageLeftOrRightMarginSuperView];
            [cons addObject:_imageLeftOrRightCons];
            
            //布局文字
            [cons addObject:[NSLayoutConstraint constraintWithItem:self.titleLable attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            self.marginHeightCons = [NSLayoutConstraint constraintWithItem:self.titleLable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:self.margin];
            [cons addObject:_marginHeightCons];

        }
            break;
            
        case GYButtonTypeHorizontalTitleImage:
        {
            //布局图片
            [cons addObject:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            self.imageLeftOrRightCons = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:self.imageLeftOrRightMarginSuperView];
            [cons addObject:_imageLeftOrRightCons];
            self.marginHeightCons = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleLable attribute:NSLayoutAttributeRight multiplier:1.0 constant:self.margin];
            [cons addObject:_marginHeightCons];
            
            //布局文字
            [cons addObject:[NSLayoutConstraint constraintWithItem:self.titleLable attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            
        }
            break;
            
        default:
            break;
    }
    
    [self addConstraints:cons];
    
}


#pragma mark -- 设置属性方法

- (void)setImageCornerRadius:(CGFloat)imageCornerRadius {
    _imageCornerRadius = imageCornerRadius;
    self.imageView.layer.cornerRadius = imageCornerRadius;
    self.imageView.layer.masksToBounds = YES;
}


- (void)setMargin:(CGFloat)margin {
    _margin = margin;
    self.marginHeightCons.constant = margin;
    [self setNeedsLayout];
}

- (void)setImageSize:(CGSize)imageSize {
    _imageSize = imageSize;
    self.imageWidthCons.constant = imageSize.width;
    self.imageHeightCons.constant = imageSize.height;
    [self setNeedsLayout];
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    self.titleLable.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setTitleTopOrBottonMarginToSuperView:(CGFloat)titleTopOrBottonMarginToSuperView {
    _titleTopOrBottonMarginToSuperView = titleTopOrBottonMarginToSuperView;
    self.titleTopOrBottomCons.constant = titleTopOrBottonMarginToSuperView;
    [self setNeedsLayout];
}

- (void)setImageLeftOrRightMarginSuperView:(CGFloat)imageLeftOrRightMarginSuperView {
    _imageLeftOrRightMarginSuperView = imageLeftOrRightMarginSuperView;
    self.imageLeftOrRightCons.constant = imageLeftOrRightMarginSuperView;
    [self setNeedsLayout];
}

- (void)setImage:(UIImage *)image forState:(GYControlState)state {
    //1.把图片存起来
    [self.imageDic setObject:image forKey:@(state)];
    
    //2.判断设置什么状态下啊图片 normal 下直接设置图片
    if (state == GYControlStateNormal) {
        self.imageView.image = image;
        self.originalImage = image;
    }
}

- (void)setTitle:(NSString *)title forState:(GYControlState)state {
    [self.titleDic setObject:title forKey:@(state)];
    
    if (state == GYControlStateNormal) {
        self.titleLable.text = title;
        self.originalTitle = title;
    }
}

- (void)setTitleColor:(UIColor *)titleColor forState:(GYControlState)state {
    [self.titleColorDic setObject:titleColor forKey:@(state)];
    
    if (state == GYControlStateNormal) {
        self.titleLable.textColor = titleColor;
        self.originalTitleColor = titleColor;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(GYControlState)state {
    [self.backgroundColorDic setObject:backgroundColor forKey:@(state)];
    
    if (state == GYControlStateNormal) {
        self.backgroundColor = backgroundColor;
        self.originalBackgroundClor = backgroundColor;
    }
}

#pragma mark -- tracking

//按压
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"开始按压....");
    //1.设置按钮高亮状态下的各种属性
    [self refreshButtonHighlight];
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"更新按钮动作...");
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.selected) {
        [self refreshButtonSelected];
    }else {
        [self refreshButtonNormal];
    }
    NSLog(@"结束按钮动作...");
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [self refreshButtonNormal];
    NSLog(@"取消按压动作...");
}

#pragma mark -- 重写按钮选择和点击的方法
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        [self refreshButtonSelected];
    }else {
        [self refreshButtonNormal];
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if (enabled) {
        [self setUnenabledButton];
    }else {
        [self refreshButtonNormal];
    }
}

#pragma  amrk -- 更改按钮的属性

//设置normal下的按钮属性
- (void)refreshButtonNormal {
    self.imageView.image = self.originalImage;
    self.backgroundColor = self.originalBackgroundClor;
    self.titleLable.text = self.originalTitle;
    self.titleLable.textColor = self.originalTitleColor;
}

//设置selected下的按钮属性
- (void)refreshButtonSelected {
    
    GYControlState state = GYControlStateSelected;
    UIImage *selectedImage = [self.imageDic objectForKey:@(state)];
    UIColor *selectedBackgrounnColor = [self.backgroundColorDic objectForKey:@(state)];
    UIColor *selectedTitleColor = [self.titleColorDic objectForKey:@(state)];
    NSString *selectedTitle = [self.titleDic objectForKey:@(state)];
    
    self.imageView.image = selectedImage ? selectedImage : self.originalImage;
    self.backgroundColor = selectedBackgrounnColor ? selectedBackgrounnColor : self.originalBackgroundClor;
    self.titleLable.textColor = selectedTitleColor ? selectedTitleColor : self.originalTitleColor;
    self.titleLable.text = selectedTitle ? selectedTitle : self.originalTitle;
}

//设置highlight下的按钮属性
- (void)refreshButtonHighlight {
    
    GYControlState state = GYControlStateHighlighted;
    UIImage *highImage = [self.imageDic objectForKey:@(state)];
    UIColor *highBackgrounnColor = [self.backgroundColorDic objectForKey:@(state)];
    UIColor *highTitleColor = [self.titleColorDic objectForKey:@(state)];
    NSString *highTitle = [self.titleDic objectForKey:@(state)];
    
    self.imageView.image = highImage ? highImage : self.originalImage;
    self.backgroundColor = highBackgrounnColor ? highBackgrounnColor : self.originalBackgroundClor;
    self.titleLable.textColor = highTitleColor ? highTitleColor : self.originalTitleColor;
    self.titleLable.text = highTitle ? highTitle : self.originalTitle;
}

//按钮进制点击的时候
- (void)setUnenabledButton {
    self.backgroundColor = HEX(0xF5F5F5);
    self.titleLable.textColor = HEX(0xCCCCCC);
    self.titleLable.text = self.originalTitle;
    self.imageView.image = self.originalImage;
}

#pragma mark -- 懒加载

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.userInteractionEnabled = NO;
    }
    return _contentView;
}

- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLable.font = [UIFont systemFontOfSize:15];//按钮字体默认大小
        _titleLable.textColor = [UIColor blackColor];
    }
    return _titleLable;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imageView;
}

- (NSMutableDictionary *)backgroundColorDic
{
    if (!_backgroundColorDic) {
        _backgroundColorDic = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return _backgroundColorDic;
}

- (NSMutableDictionary *)titleColorDic
{
    if (!_titleColorDic) {
        _titleColorDic = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return _titleColorDic;
}

- (NSMutableDictionary *)titleDic
{
    if (!_titleDic) {
        _titleDic = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return _titleDic;
}

- (NSMutableDictionary *)imageDic
{
    if (!_imageDic) {
        _imageDic = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return _imageDic;
}


@end
