//
//  CommunityViewController.h
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-2-20.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMScrollingNavbarViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "IBActionSheet.h"
@interface CommunityViewController : AMScrollingNavbarViewController<UIWebViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
@property(retain,nonatomic) id URLKey;
@property(retain,nonatomic) id titleKey;
@property IBActionSheet *standardIBAS, *customIBAS, *funkyIBAS;
@property (weak, nonatomic) IBOutlet UIToolbar *BrowserBar;

@end
