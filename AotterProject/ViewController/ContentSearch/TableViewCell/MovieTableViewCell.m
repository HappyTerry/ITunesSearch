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
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configure:(NSDictionary *)data isMusic:(BOOL)isMusic isReadMore:(BOOL)isReadMore {
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
    if (isMusic) {
        [_descriptionLabel setHidden:YES];
        [_readMoreButton setHidden:YES];
    } else {
        [_descriptionLabel setHidden:NO];
        if (isReadMore) {
            [_descriptionLabel setNumberOfLines:0];
            [_readMoreButton setHidden:YES];
        } else {
            [_descriptionLabel setNumberOfLines:2];
            [_readMoreButton setHidden:NO];
        }
    }
    
    _collectingButton.layer.cornerRadius = 5;
    [_collectingButton setSelected:[CollectingManager isCollecting:_data]];
}

- (IBAction)collectingButtonDidClick:(UIButton *)sender {
    if ([CollectingManager isCollecting:_data]) {
        [CollectingManager removeCollecting:_data];
        [_delegate cellDidSelectCancelCollect:_data];
    } else {
        [CollectingManager addCollecting:_data];
    }
    [_collectingButton setSelected:[CollectingManager isCollecting:_data]];
}

- (IBAction)readMoreButtonDidClick:(UIButton *)sender {
    [_delegate cellDidSelectReadMore:_data];
}

- (NSString *)getTimeString:(double)time {
    NSDateFormatter * dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"HH:mm:ss"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [dateFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:time / 1000]];
}
@end
