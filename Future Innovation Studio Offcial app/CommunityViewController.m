//
//  CommunityViewController.m
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-2-20.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import "CommunityViewController.h"
#import "MMProgressHUD.h"
#import "CXAlertView.h"
#import "UITabBarController+HideTabBar.h"
@interface CommunityViewController ()<UIScrollViewDelegate>{
    NSString*filePath1;
    __weak IBOutlet UIActivityIndicatorView *loadIndicator;
    
}
@property (weak, nonatomic) IBOutlet UIWebView *communityWebView;

@end

@implementation CommunityViewController
@synthesize URLKey,titleKey;
@synthesize BrowserBar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
            }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController setTabBarHidden:YES animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = titleKey;
	// Do any additional setup after loading the view.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    filePath1 = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[NSString stringWithFormat:@"%@.html",titleKey]];
    
    
    
    self.communityWebView.delegate = self;
    self.communityWebView.scrollView.delegate = self;
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath1]) {
        UIAlertView *choice = [[UIAlertView alloc]initWithTitle:@"Options" message:@"It seems like you have a local cache of this page, do you want to load it instead? You may set default in the extra tab." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"Web version", nil];
        [choice setTag:0];
        [choice show];
        
       
    }else{
        [self.communityWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLKey]]];
    }
   

}
//alertview
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 0) {
        switch (buttonIndex) {
            case 0:
                 [self.communityWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath1]]];
                break;
            case 1:
                [self.communityWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLKey]]];
                break;
            default:
                break;
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    loadIndicator.hidden = NO;
    [loadIndicator startAnimating];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    loadIndicator.hidden = YES;
    [loadIndicator stopAnimating];

    [MMProgressHUD dismissWithSuccess:@"Success"];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    loadIndicator.hidden = YES;
    [loadIndicator stopAnimating];

    [MMProgressHUD dismissWithError:@"Failed"];
}

//extra functions

- (IBAction)showMore:(id)sender {
    UIActionSheet*actionsheet = [[UIActionSheet alloc] initWithTitle:@"More functions" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Reload" otherButtonTitles:@"Cache the page", @"Remove cache", nil];//will add login management section
    actionsheet.tag = 0;
    
    [actionsheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 0) {
        NSLog(@"Button at index: %ld clicked\nIt's title is '%@'", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
        
        switch (buttonIndex) {
            case 0:
                [self.communityWebView reload];
                break;
            case 1:{    
                
                /*  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                 NSString *filePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],@"index.html"];
                 
                 // Download and write to file
                 NSURL *url = [NSURL URLWithString:@"http://store.fistudio.net"];
                 NSData *urlData = [NSData dataWithContentsOfURL:url];
                 [urlData writeToFile:filePath atomically:YES];*/
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSLog(@"Downloading Started");
                    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
                    [MMProgressHUD showWithTitle:@"Cacheing" status:@""];
                    NSString *urlToDownload = URLKey;
                    NSURL *url = [NSURL URLWithString:urlToDownload];
                    NSData *urlData = [NSData dataWithContentsOfURL:url];
                    if ( urlData )
                    {
                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                        NSString *documentsDirectory = [paths objectAtIndex:0];
                        
                        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[NSString stringWithFormat:@"%@.html",titleKey]];
                        
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [urlData writeToFile:filePath atomically:YES];
                            [MMProgressHUD dismissWithSuccess:@"Success"];
                        });
                        
                    }
                    
                });
                
                
            }
                break;
            case 2:{
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[NSString stringWithFormat:@"%@.html",titleKey]];
                if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
                    NSError *error;
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
                    [[NSURLCache sharedURLCache]removeAllCachedResponses];
                    if (success) {
                        
                        CXAlertView *removeSuccessFulAlert = [[CXAlertView alloc] initWithTitle:@"Success" message:@"The cache has been removed" cancelButtonTitle:nil];
                        
                        
                        [removeSuccessFulAlert addButtonWithTitle:@"Okay"
                                                             type:CXAlertViewButtonTypeDefault
                                                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                                                              [alertView dismiss];
                                                          }];
                        [removeSuccessFulAlert show];
                        
                        
                    }
                    else
                    {
                        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
                    }
                }
            }
                break;
            case 3:
                // cancer button
                break;
            default:
                break;
        }
    }
}

@end
