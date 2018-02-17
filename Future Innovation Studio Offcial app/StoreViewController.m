//
//  StoreViewController.m
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-2-16.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import "StoreViewController.h"
#import "MMProgressHUD.h"
#import "MMProgressHUDOverlayView.h"
#import "CXAlertView.h"
#import "UITabBarController+HideTabBar.h"
@interface StoreViewController ()<UIScrollViewDelegate>{
    
    __weak IBOutlet UIBarButtonItem *goback;
}
  
@property (weak, nonatomic) IBOutlet UIWebView *StoreWebView;


@end

@implementation StoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self followScrollView:self.StoreWebView];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"store.html"];
    

    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        [self.StoreWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
    }else{
        [self.StoreWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://store.fistudio.net"]]];
    }
    self.StoreWebView.delegate = self;
    self.StoreWebView.scrollView.delegate = self;
    
}
//Web view Delegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
    [MMProgressHUD showWithTitle:@"Loading"
                          status:@"Tap to cancel"
             confirmationMessage:@"Cancel loading?"
                     cancelBlock:^{
                         NSLog(@"Task was cancelled!");
                         [self.StoreWebView stopLoading];
                     }];

    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MMProgressHUD dismissWithSuccess:@"Success"];
   }

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MMProgressHUD dismissWithError:@"Failed"];
}

//extra functions
- (IBAction)goback:(id)sender {
    if ([self.StoreWebView canGoBack]) {
        [self.StoreWebView goBack];
    }else{
        CXAlertView*alert = [[CXAlertView alloc]initWithTitle:@"Oops" message:@"You cannot go back at this view" cancelButtonTitle:@"Okay"];
        [alert show];
    }
}

- (IBAction)showMore:(id)sender {
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"More functions" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Reload" otherButtonTitles:@"Cache the page", @"Remove cache", nil];
    actionsheet.tag = 0;
    [self.tabBarController setTabBarHidden:YES animated:YES ];
    [actionsheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 0) {
    NSLog(@"Button at index: %ld clicked\nIt's title is '%@'", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
        [self.tabBarController setTabBarHidden:NO animated:YES];
        switch (buttonIndex) {
            case 0:
                [self.StoreWebView reload];
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
                    [MMProgressHUD showWithTitle:@"Loading" status:@""];
                    NSString *urlToDownload = @"http://store.fistudio.net";
                    NSURL *url = [NSURL URLWithString:urlToDownload];
                    NSData *urlData = [NSData dataWithContentsOfURL:url];
                    if ( urlData )
                    {
                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                        NSString *documentsDirectory = [paths objectAtIndex:0];
                        
                        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"store.html"];
                        
                        
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
                NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"store.html"];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSURLCache sharedURLCache]removeAllCachedResponses];
}

@end
