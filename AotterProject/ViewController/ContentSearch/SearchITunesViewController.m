//
//  SearchITunesViewController.m
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import "SearchITunesViewController.h"

#define iTunesDomain @"https://itunes.apple.com/search"
#define TrackViewUrl @"trackViewUrl"
#define TrackID @"trackId"

@interface SearchITunesViewController () {
    NSMutableDictionary * readMoreDict;
}

@end

@implementation SearchITunesViewController

#pragma mark - View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    readMoreDict = [NSMutableDictionary new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Layout
- (void)setupUI {
    [self setupTableView];
    [self setupSearchBar];
}

- (void)setupTableView {
    _itunesTableView.dataSource = self;
    _itunesTableView.delegate = self;
}

- (void)setupSearchBar {
    _searchBar.delegate = self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_movieList.count > 0 && _musicList.count > 0) {
        return 2;
    } else if (_movieList.count > 0 || _musicList.count > 0) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_movieList.count > 0) {
        if (section == 0) {
            return _movieList.count;
        }
        if (_musicList.count > 0) {
            if (section == 1) {
                return _musicList.count;
            }
        }
    } else if (_musicList.count > 0) {
        return _musicList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    if (_movieList.count > 0) {
        if (indexPath.section == 0) {
            NSDictionary * data = [_movieList objectAtIndex:indexPath.row];
            BOOL isReadMore = NO;
            if ([data objectForKey:TrackID] != nil && readMoreDict[data[TrackID]] != nil) {
                isReadMore = [readMoreDict[data[TrackID]] boolValue];
            }
            [cell configure:data isMusic:NO isReadMore:isReadMore];
        }
        if (_musicList.count > 0) {
            if (indexPath.section == 1) {
                NSDictionary * data = [_musicList objectAtIndex:indexPath.row];
                BOOL isReadMore = NO;
                if ([data objectForKey:TrackID] != nil && readMoreDict[data[TrackID]] != nil) {
                    isReadMore = [readMoreDict[data[TrackID]] boolValue];
                }
                [cell configure:data isMusic:YES isReadMore:isReadMore];
            }
        }
    } else if (_musicList.count > 0) {
        NSDictionary * data = [_musicList objectAtIndex:indexPath.row];
        BOOL isReadMore = NO;
        if ([data objectForKey:TrackID] != nil && readMoreDict[data[TrackID]] != nil) {
            isReadMore = [readMoreDict[data[TrackID]] boolValue];
        }
        [cell configure:data isMusic:YES isReadMore:isReadMore];
    }
    cell.delegate = self;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_movieList.count > 0) {
        if (section == 0) {
            return @"電影";
        }
        if (_musicList.count > 0) {
            if (section == 1) {
                return @"音樂";
            }
        }
    } else if (_musicList.count > 0) {
        return @"音樂";
    }
    return @"";
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * urlString = @"";
    if (_movieList.count > 0) {
        if (indexPath.section == 0) {
            NSDictionary * data = [_movieList objectAtIndex:indexPath.row];
            if (data[TrackViewUrl] != NULL) {
                urlString = data[TrackViewUrl];
            }
        }
        if (_musicList.count > 0) {
            if (indexPath.section == 1) {
                NSDictionary * data = [_musicList objectAtIndex:indexPath.row];
                if (data[TrackViewUrl] != NULL) {
                    urlString = data[TrackViewUrl];
                }
            }
        }
    } else if (_musicList.count > 0) {
        NSDictionary * data = [_musicList objectAtIndex:indexPath.row];
        if (data[TrackViewUrl] != NULL) {
            urlString = data[TrackViewUrl];
        }
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
    [readMoreDict removeAllObjects];
    [self searchITunes:searchBar.text completion:^(NSArray * results) {
        NSMutableArray * __movieList = [NSMutableArray new];
        NSMutableArray * __musicList = [NSMutableArray new];
        for (NSDictionary * result in results) {
            if ([result isKindOfClass:[NSDictionary class]]) {
                if ([result.allKeys containsObject:TrackID]) {
                    [self->readMoreDict setObject:[NSNumber numberWithBool:NO] forKey:TrackID];
                }
                if ([result.allKeys containsObject:@"kind"]) {
                    if ([result[@"kind"] containsString:@"song"]) {
                        [__musicList addObject:result];
                    } else if ([result[@"kind"] containsString:@"movie"]) {
                        [__movieList addObject:result];
                    }
                }
            }
        }
        self.movieList = [NSArray arrayWithArray:__movieList];
        self.musicList = [NSArray arrayWithArray:__musicList];
        [self.itunesTableView reloadData];
    }];
}

#pragma mark - Networking
- (void)searchITunes:(NSString *)keyword completion:(void (^)(NSArray *))completion {
    NSDictionary *parameters = @{@"term": keyword,
                                 @"country": @"TW"};
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:iTunesDomain parameters:parameters error:nil];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLSessionDataTask * dataTask = [manager dataTaskWithRequest:request uploadProgress:NULL downloadProgress:NULL completionHandler:^(NSURLResponse * response, id responseObject, NSError * error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            if (responseObject == NULL) {
                return;
            }
            NSDictionary * resObject = [NSDictionary dictionaryWithDictionary:responseObject];
            if([resObject isKindOfClass:[NSDictionary class]] &&
               [resObject.allKeys containsObject:@"results"]){
                NSArray * results = resObject[@"results"];
                if ([results isKindOfClass:[NSArray class]]) {
                    completion(results);
                }
            }
        }
    }];
    [dataTask resume];
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
    [_itunesTableView reloadData];
}
@end
