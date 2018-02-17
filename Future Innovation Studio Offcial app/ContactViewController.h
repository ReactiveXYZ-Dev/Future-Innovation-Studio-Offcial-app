//
//  ContactViewController.h
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-4-8.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationPickerView.h"
#import <MessageUI/MessageUI.h>
@interface ContactViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, LocationPickerViewDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
@property (nonatomic, strong) IBOutlet LocationPickerView *locationPickerView;
@end
