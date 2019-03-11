//
//  CollectingListViewController.h
//  AotterProject
//
//  Created by Terry on 2019/3/11.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectingListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray * collectingList;
@property (assign, nonatomic) BOOL isMusic;
@property (weak, nonatomic) IBOutlet UITableView *collectingTableView;

@end

NS_ASSUME_NONNULL_END
