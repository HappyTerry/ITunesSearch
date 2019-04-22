//
//  SettingThemeViewController.m
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import "SettingThemeViewController.h"
#import "UIResponder+Theme.h"
#import "ThemeOptionTableViewCell.h"

#define OptionCell @"themeOptionCell"

static NSInteger selectedTheme = 0;

@interface SettingThemeViewController ()

@end

@implementation SettingThemeViewController

#pragma mark - View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self registerForThemeChanges];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //get selectedTheme
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    selectedTheme = [userDefaults integerForKey:@"ThemeType"];
    [_themeTableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    switch (selectedTheme) {
        case 0:
            
            break;
        case 1:
            
            break;
        default:
            break;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Layout
- (void)setupUI {
    [self setupTableView];
}

- (void)setupTableView {
    _themeTableView.dataSource = self;
    _themeTableView.delegate = self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ThemeOptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:OptionCell];
    [cell configure:indexPath.row];
    if (selectedTheme == indexPath.row) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == selectedTheme) {
        return;
    }
    selectedTheme = indexPath.row;
    [tableView reloadData];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:selectedTheme forKey:@"ThemeType"];
    [userDefaults synchronize];
}

@end
