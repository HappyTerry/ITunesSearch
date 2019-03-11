//
//  ThemeManager.m
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager

+ (void)darkTheme {
    UIButton * proxyButton = [UIButton appearance];
    [proxyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [proxyButton setTintColor:[UIColor blackColor]];
    UILabel * proxyLabel = [UILabel appearance];
    [proxyLabel setTextColor:[UIColor blackColor]];
    UINavigationBar * proxyNavBar = [UINavigationBar appearance];
}

+ (void)lightTheme {
    UIButton * proxyButton = [UIButton appearance];
    [proxyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [proxyButton setTintColor:[UIColor lightGrayColor]];
    UILabel * proxyLabel = [UILabel appearance];
    [proxyLabel setTextColor:[UIColor lightGrayColor]];
}

@end
