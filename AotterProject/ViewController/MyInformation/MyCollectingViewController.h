//
//  MyCollectingViewController.h
//  AotterProject
//
//  Created by Terry on 2019/3/11.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCollectingViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *  pageController;
@property (strong, nonatomic) NSArray * pageList;

@property (weak, nonatomic) IBOutlet UISegmentedControl *kindSegControl;
@property (weak, nonatomic) IBOutlet UIView *pageView;

@end

NS_ASSUME_NONNULL_END
