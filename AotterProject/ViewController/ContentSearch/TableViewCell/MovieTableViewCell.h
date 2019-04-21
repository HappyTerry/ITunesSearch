//
//  MovieTableViewCell.h
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MovieCellDelegate;

@interface MovieTableViewCell : UITableViewCell

@property (strong, nonatomic) NSDictionary * data;
@property (nonatomic) BOOL isMusic;
@property (weak, nonatomic) id delegate;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *readMoreButton;
@property (weak, nonatomic) IBOutlet UIButton *collectingButton;

- (void)configure:(NSDictionary *)data isMusic:(BOOL)isMusic isReadMore:(BOOL)isReadMore;

@end

@protocol MovieCellDelegate<NSObject>

@optional
- (void)cellDidSelectReadMore: (NSDictionary *)data;
- (void)cellDidSelectCancelCollect: (NSDictionary *)data;
@end
NS_ASSUME_NONNULL_END
