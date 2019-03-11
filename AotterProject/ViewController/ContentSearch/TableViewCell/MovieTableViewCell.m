//
//  MovieTableViewCell.m
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import "MovieTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CollectingManager.h"

@implementation MovieTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configure:(NSDictionary *)data isMusic:(BOOL)isMusic {
    _data = [NSDictionary dictionaryWithDictionary:data];
    _isMusic = isMusic;
    [_iconImageView setImage:[UIImage imageNamed:@""]];
    //iconImageView;
    if ([data.allKeys containsObject:@"artworkUrl60"]) {
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:data[@"artworkUrl60"]]];
    }
    if ([data.allKeys containsObject:@"trackName"]) {
        [_trackNameLabel setText:data[@"trackName"]];
    }
    if ([data.allKeys containsObject:@"artistName"]) {
        [_artistNameLabel setText:data[@"artistName"]];
    }
    if ([data.allKeys containsObject:@"collectionName"]) {
        [_collectionNameLabel setText:data[@"collectionName"]];
    }
    if ([data.allKeys containsObject:@"trackTimeMillis"]) {
        [_lengthLabel setText:[self getTimeString:[data[@"trackTimeMillis"] doubleValue]]];
    }
    if ([data.allKeys containsObject:@"longDescription"]) {
        [_descriptionLabel setText:data[@"longDescription"]];
    }
    [_descriptionLabel setNumberOfLines:2];
    [_descriptionLabel setHidden:(_isMusic ? YES : NO)];
    [_readMoreButton setHidden:(_isMusic ? YES : NO)];
    
    _collectingButton.layer.cornerRadius = 5;
    [_collectingButton setTitle:([CollectingManager isCollecting:_data] ? @"取消收藏" : @"收藏") forState:UIControlStateNormal];
}

- (IBAction)collectingButtonDidClick:(UIButton *)sender {
    if ([CollectingManager isCollecting:_data]) {
        [CollectingManager removeCollecting:_data];
    } else {
        [CollectingManager addCollecting:_data];
    }
}

- (IBAction)readMoreButtonDidClick:(UIButton *)sender {
    [_descriptionLabel setNumberOfLines:0];
    [_readMoreButton setHidden:YES];
}

- (NSString *)getTimeString:(double)time {
    NSDateFormatter * dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [dateFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:time / 1000]];
}
@end
