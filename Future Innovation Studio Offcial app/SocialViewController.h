//
//  SocialViewController.h
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-2-16.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface SocialViewController : UIViewController<MFMailComposeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *SocialTable;

@end
