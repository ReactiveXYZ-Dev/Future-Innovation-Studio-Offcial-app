//
//  SocialTableViewCell.m
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-4-8.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import "SocialTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation SocialTableViewCell
@synthesize DescriptionLabel=_DescriptionLabel,TitleLabel=_TitleLabel,SocialIcon=_SocialIcon;
- (void)awakeFromNib
{
    // Initialization code
    [self cropImg];
}
-(void)cropImg{
    CALayer *imageLayer = _SocialIcon.layer;
    [imageLayer setCornerRadius:20];
    [imageLayer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

@end
