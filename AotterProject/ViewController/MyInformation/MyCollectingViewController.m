//
//  MyCollectingViewController.m
//  AotterProject
//
//  Created by Terry on 2019/3/11.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import "MyCollectingViewController.h"
#import "CollectingListViewController.h"
#import "CollectingManager.h"

@interface MyCollectingViewController ()

@end

@implementation MyCollectingViewController

#pragma mark - View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Layout
- (void)setupUI {
    [self setupPageController];
}

- (void)setupPageController {
    _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageController.dataSource = self;
    _pageController.delegate = self;
    [_pageController.view setFrame:CGRectMake(0, 0, _pageView.frame.size.width, _pageView.frame.size.height)];
    
    NSMutableArray * movieList = [NSMutableArray new];
    NSMutableArray * musicList = [NSMutableArray new];
    NSDictionary * allCollecting = [CollectingManager getAllCollection];
    for (NSString * key in allCollecting.allKeys) {
        NSDictionary * data = [allCollecting objectForKey:key];
        if ([data isKindOfClass:[NSDictionary class]]) {
            if ([data.allKeys containsObject:@"kind"]) {
                if ([data[@"kind"] containsString:@"song"]) {
                    [musicList addObject:data];
                } else if ([data[@"kind"] containsString:@"movie"]) {
                    [movieList addObject:data];
                }
            }
        }
    }
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CollectingListViewController * movieViewController = [storyboard instantiateViewControllerWithIdentifier:@"CollectingListViewController"];
    movieViewController.isMusic = NO;
    movieViewController.collectingList = movieList;
    CollectingListViewController * musicViewController = [storyboard instantiateViewControllerWithIdentifier:@"CollectingListViewController"];
    musicViewController.isMusic = YES;
    musicViewController.collectingList = musicList;
    _pageList = @[movieViewController, musicViewController];
    
    NSArray * viewControllers = @[movieViewController];
    [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:_pageController];
    [self.pageView addSubview:_pageController.view];
    [_pageController didMoveToParentViewController:self];
}

#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController {
    NSInteger index = [_pageList indexOfObject:viewController];
    index += 1;
    if (index >= _pageList.count) {
        return nil;
    }
    return [_pageList objectAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
    NSInteger index = [_pageList indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    index -= 1;
    return [_pageList objectAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSInteger index = [_pageList indexOfObject:[_pageController.viewControllers objectAtIndex:0]];
    [_kindSegControl setSelectedSegmentIndex:index];
}

#pragma mark - Event
- (IBAction)kindSegControlValueDidChanged:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    NSArray * viewControllers = @[[_pageList objectAtIndex:index]];
    if (index == 0) {
        [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    } else {
        [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}


@end
