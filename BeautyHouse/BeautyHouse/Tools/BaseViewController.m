//
//  BaseViewController.m
//  BeautyHouse
//
//  Created by iOS123 on 2019/4/12.
//  Copyright © 2019 iOS123. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [self colorWithHex:0xf1f1f1 alpha:1.0];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"+ Add" style:(UIBarButtonItemStyleDone) target:self action:@selector(addProduct)];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[self colorWithHex:0x6BC413 alpha:1.0] forKey:NSForegroundColorAttributeName];
    [rightitem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightitem;
     [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19], NSForegroundColorAttributeName:[self colorWithHex:0x535353 alpha:1.0]}];
}

- (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

- (void)addProduct{
//    UIActivityIndicatorView
}

@end
