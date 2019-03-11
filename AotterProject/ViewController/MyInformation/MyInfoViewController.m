//
//  MyInfoViewController.m
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import "MyInfoViewController.h"
#import "ThemeInfoTableViewCell.h"
#import "CollectingInfoTableViewCell.h"
#import "CollectingManager.h"

#define ShowWebContent @"ShowWebContentFromMyInfoSegue"
#define ThemeCell @"themeCell"
#define CollectingCell @"collectingCell"

@interface MyInfoViewController ()

@end

@implementation MyInfoViewController

#pragma mark - View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_infoTableView reloadData];
}

#pragma mark - Layout
- (void)setupUI {
    [self setupTableView];
}

- (void)setupTableView {
    _infoTableView.dataSource = self;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:ShowWebContent]) {
        
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        NSInteger themeType = [userDefaults integerForKey:@"ThemeType"];
        ThemeInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ThemeCell];
        [cell configure:themeType];
        return cell;
    } else if (indexPath.row == 1) {
        NSInteger count = [CollectingManager getCollectingCount];
        CollectingInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CollectingCell];
        [cell configure:count];
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - Action
- (IBAction)informationButtonDidClick:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://support.apple.com/itunes"] options:@{} completionHandler:nil];
}
@end
