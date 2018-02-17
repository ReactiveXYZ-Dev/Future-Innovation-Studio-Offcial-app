//
//  SocialTableViewCell.h
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-4-8.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *SocialIcon;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *DescriptionLabel;

@end
