//
//  LoginsNoteViewController.h
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-4-11.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
//encryption
#import "NSData-AES.h"
#import "Base64.h"

@interface LoginsNoteViewController : UIViewController<UIAlertViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>{
    long long expectedLength;
	long long currentLength;
}
@property (weak, nonatomic) IBOutlet UITextView *LoginText;
@property (weak, nonatomic) IBOutlet UITextField *NameText;

@end
