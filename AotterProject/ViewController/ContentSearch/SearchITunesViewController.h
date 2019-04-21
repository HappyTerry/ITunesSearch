//
//  SearchITunesViewController.h
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "MovieTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchITunesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MovieCellDelegate>
@property (strong, nonatomic) NSArray * movieList;
@property (strong, nonatomic) NSArray * musicList;
@property (weak, nonatomic) IBOutlet UITableView *itunesTableView;
@property (strong, nonatomic) IBOutlet UISearchBar * searchBar;

@end

NS_ASSUME_NONNULL_END
