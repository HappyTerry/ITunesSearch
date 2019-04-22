//
//  ThemeManager.h
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kThemeChangedKey;

typedef NS_ENUM (NSInteger, CFATheme) {
    CFAThemeLight,
    CFAThemeDark
};

#define CFACurrentTheme [[ThemeManager sharedManager] currentTheme]

@interface ThemeManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) NSNumber *forcedTheme;
@property (nonatomic, readonly) CFATheme currentTheme;

@end
