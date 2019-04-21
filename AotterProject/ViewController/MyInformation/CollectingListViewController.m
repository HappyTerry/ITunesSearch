//
//  CollectingListViewController.m
//  AotterProject
//
//  Created by Terry on 2019/3/11.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import "CollectingListViewController.h"

#define TrackViewUrl @"trackViewUrl"
#define TrackID @"trackId"

@interface CollectingListViewController () {
    NSMutableDictionary * readMoreDict;
}

@end

@implementation CollectingListViewController

#pragma mark - View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    readMoreDict = [NSMutableDictionary new];
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
    BOOL isReadMore = NO;
    if ([data objectForKey:TrackID] != nil) {
        isReadMore = [[data objectForKey:TrackID] boolValue];
    }
    [cell configure:data isMusic:_isMusic isReadMore:isReadMore];
    cell.delegate = self;
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

#pragma mark - MovieCellDelegate
- (void)cellDidSelectReadMore:(NSDictionary *)data {
    if (data[TrackID] != nil) {
        BOOL isReadMore = NO;
        if (readMoreDict[data[TrackID]] != nil) {
            isReadMore = [readMoreDict[data[TrackID]] boolValue];
        }
        readMoreDict[data[TrackID]] = [NSNumber numberWithBool:!isReadMore];
    }
    [_collectingTableView reloadData];
}
@end
