//
//  ViewController.m
//  GYButton
//
//  Created by x on 2017/12/19.
//  Copyright © 2017年 HLB. All rights reserved.
//

#import "ViewController.h"
#import "GYButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self verticalImageTilte];
    [self verticalTitleImage];
    [self horizontalImageTitle];
    [self horizontalTitleImage];
    UIButton
}
- (void)verticalImageTilte {
    GYButton *btu = [GYButton buttonWithType:GYButtonTypeVerticalImageTitle];
    
    btu.frame = CGRectMake(50, 50, 200, 100);
    [btu setImage:[UIImage imageNamed:@"P3"] forState:GYControlStateNormal];
    [btu setTitle:@"图片在上" forState:GYControlStateNormal];
    [btu setBackgroundColor:[UIColor darkGrayColor] forState:GYControlStateNormal];
    [btu setTitleColor:[UIColor blackColor] forState:GYControlStateNormal];
    btu.margin = 10;
    btu.imageSize = CGSizeMake(40, 40);
    btu.fontSize = 20;
    btu.titleTopOrBottonMarginToSuperView = -4;
    btu.layer.borderColor = [UIColor orangeColor].CGColor;
    btu.layer.borderWidth = 1;
    
    [btu setTitle:@"woqu" forState:GYControlStateSelected];
    [btu setTitleColor:[UIColor orangeColor] forState:GYControlStateSelected];
    [btu setBackgroundColor:[UIColor redColor] forState:GYControlStateSelected];

    
    [btu addTarget:self action:@selector(btuClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btu];
}

- (void)verticalTitleImage {
    GYButton *btu = [GYButton buttonWithType:GYButtonTypeVerticalTitleImage];
    btu.frame = CGRectMake(50, 200, 200, 100);
    [btu setImage:[UIImage imageNamed:@"P3"] forState:GYControlStateNormal];
    [btu setTitle:@"图片在下" forState:GYControlStateNormal];
    btu.margin = 10;
    btu.imageSize = CGSizeMake(40, 40);
    btu.fontSize = 20;
    btu.layer.borderColor = [UIColor orangeColor].CGColor;
    btu.layer.borderWidth = 1;
    [btu addTarget:self action:@selector(btuClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btu];
}

- (void)horizontalImageTitle {
    
    GYButton *btu = [GYButton buttonWithType:GYButtonTypeHorizontalImageTitle];
    btu.frame = CGRectMake(50, 360, 200, 100);
    [btu setImage:[UIImage imageNamed:@"P3"] forState:GYControlStateNormal];
    [btu setTitle:@"图片在左" forState:GYControlStateNormal];
    btu.margin = 10;
    btu.imageSize = CGSizeMake(40, 40);
    btu.fontSize = 20;
    btu.layer.borderColor = [UIColor orangeColor].CGColor;
    btu.layer.borderWidth = 1;
    btu.imageLeftOrRightMarginSuperView = 4;
    [btu addTarget:self action:@selector(btuClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btu];

}

- (void)horizontalTitleImage {
    GYButton *btu = [GYButton buttonWithType:GYButtonTypeHorizontalTitleImage];
    btu.frame = CGRectMake(50, 465, 200, 100);
    [btu setImage:[UIImage imageNamed:@"P3"] forState:GYControlStateNormal];
    [btu setTitle:@"图片在右" forState:GYControlStateNormal];
    btu.margin = 10;
    btu.imageSize = CGSizeMake(40, 40);
    btu.fontSize = 20;
    btu.layer.borderColor = [UIColor orangeColor].CGColor;
    btu.layer.borderWidth = 1;
    [btu addTarget:self action:@selector(btuClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btu];

}

- (void)btuClick:(GYButton *)btu {
    btu.selected = !btu.selected;
    NSLog(@"点击方法....");
}

@end
