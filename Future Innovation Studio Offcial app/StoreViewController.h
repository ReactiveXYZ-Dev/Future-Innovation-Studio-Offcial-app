//
//  StoreViewController.h
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-2-16.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AMScrollingNavbarViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "IBActionSheet.h"


@interface StoreViewController : AMScrollingNavbarViewController<UIWebViewDelegate,UINavigationBarDelegate,UIActionSheetDelegate>{
    
}


@property IBActionSheet *standardIBAS, *customIBAS, *funkyIBAS;

@end
