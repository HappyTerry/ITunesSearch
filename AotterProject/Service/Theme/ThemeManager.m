//
//  ThemeManager.m
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import "ThemeManager.h"
#import <UIKit/UIKit.h>

static NSString *const kForcedThemeDefaultsKey = @"kForcedThemeDefaultsKey";
NSString *const kThemeChangedKey = @"kThemeChangedKey";

@interface ThemeManager ()

@property (nonatomic, readwrite) CFATheme currentTheme;

@end

@implementation ThemeManager

+ (instancetype)sharedManager
{
    static ThemeManager *manager = nil;
    if (manager == nil)
    {
        manager = [[ThemeManager alloc] init];
    }
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appDidBecomeActive)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [self setCurrentTheme:[self calculateCurrentTheme] animated:NO];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setters/getters

- (void)setCurrentTheme:(CFATheme)currentTheme
{
    [self setCurrentTheme:currentTheme animated:YES];
}

- (void)setCurrentTheme:(CFATheme)currentTheme animated:(BOOL)animated
{
    if (_currentTheme != currentTheme)
    {
        _currentTheme = currentTheme;
        
        [UIView animateWithDuration:animated ? 0.5 : 0.0
                              delay:0
             usingSpringWithDamping:1
              initialSpringVelocity:0
                            options:0
                         animations:^{
                             [[NSNotificationCenter defaultCenter] postNotificationName:kThemeChangedKey
                                                                                 object:@(currentTheme)];
                         }
                         completion:nil];
    }
}

- (void)setForcedTheme:(NSNumber *)forcedTheme
{
    [[NSUserDefaults standardUserDefaults] setObject:forcedTheme forKey:kForcedThemeDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.currentTheme = [self calculateCurrentTheme];
}

- (NSNumber *)forcedTheme
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kForcedThemeDefaultsKey];
}

#pragma mark - Calculations

- (CFATheme)calculateCurrentTheme
{
    return [self.forcedTheme integerValue];
}

- (void)brightnessDidChange:(NSNotification *)notification
{
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state != UIApplicationStateActive && state != UIApplicationStateInactive)
    {
        return;
    }
    self.currentTheme = [self calculateCurrentTheme];
}

- (void)appDidBecomeActive
{
    self.currentTheme = [self calculateCurrentTheme];
}


@end
