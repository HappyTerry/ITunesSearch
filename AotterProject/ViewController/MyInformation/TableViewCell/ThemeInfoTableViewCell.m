//
//  ThemeInfoTableViewCell.m
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import "ThemeInfoTableViewCell.h"

@implementation ThemeInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configure:(NSInteger)themeType {
    switch (themeType) {
        case 0:
            [_infoLabel setText:@"深色主題"];
            break;
        case 1:
            [_infoLabel setText:@"淺色主題"];
            break;
        default:
            [_infoLabel setText:@""];
            break;
    }
}

@end
