//
//  CollectingTableViewCell.m
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import "CollectingInfoTableViewCell.h"

@implementation CollectingInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configure:(NSInteger)count {
    if (count > 0) {
        [_infoLabel setText:[NSString stringWithFormat:@"共有 %@ 項收藏", [self getGroupingNumber:count]]];
    } else {
        [_infoLabel setText:@"尚未有收藏"];
    }
}

- (NSString *)getGroupingNumber: (NSInteger)count {
    NSNumberFormatter * formatter = [NSNumberFormatter new];
    [formatter setGroupingSeparator:[[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator]];
    [formatter setGroupingSize:3];
    [formatter setUsesGroupingSeparator:YES];
    return [formatter stringFromNumber:[NSNumber numberWithInteger:count]];
}

@end
