//
//  MyInfoViewController.h
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyInfoViewController : UIViewController<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

- (IBAction)informationButtonDidClick:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
