//
//  ThemeInfoTableViewCell.h
//  AotterProject
//
//  Created by Terry on 2019/3/10.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThemeInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

-(void) configure:(NSInteger) themeType;

@end

NS_ASSUME_NONNULL_END
