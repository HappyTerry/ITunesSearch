//
//  CollectingListViewController.m
//  AotterProject
//
//  Created by Terry on 2019/3/11.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import "CollectingListViewController.h"
#import "MovieTableViewCell.h"

#define TrackViewUrl @"trackViewUrl"

@interface CollectingListViewController ()

@end

@implementation CollectingListViewController

#pragma mark - View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - Layout
- (void)setupUI {
    [self setupTableView];
}

- (void)setupTableView {
    _collectingTableView.dataSource = self;
    _collectingTableView.delegate = self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _collectingList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    NSDictionary * data = [_collectingList objectAtIndex:indexPath.row];
    [cell configure:data isMusic:_isMusic];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * urlString = @"";
    NSDictionary * data = [_collectingList objectAtIndex:indexPath.row];
    if (data[TrackViewUrl] != nil) {
        urlString = data[TrackViewUrl];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
}

@end
