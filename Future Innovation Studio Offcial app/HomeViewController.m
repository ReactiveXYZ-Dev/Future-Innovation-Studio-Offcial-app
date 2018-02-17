//
//  HomeViewController.m
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-2-16.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import "HomeViewController.h"
#import "Reachability.h"
#import "CXAlertView.h"
#import "MMProgressHUD.h"
#import "MMProgressHUDOverlayView.h"
#import <QuartzCore/QuartzCore.h>
#define kDuration 0.7
#define IS_OS_7_OR_EARLIER    ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
@interface HomeViewController ()<UIScrollViewDelegate>{
    
  
}
@property (weak, nonatomic) IBOutlet UIWebView *HomeWebView;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic)  UIBarButtonItem *webBarBtn;
@property (strong, nonatomic)  UIBarButtonItem *ShareBarButton;
@property (weak, nonatomic) IBOutlet UIButton *QuoteBtn;
@property (weak, nonatomic) IBOutlet UIView *introView;


@end

@implementation HomeViewController

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
    if (IS_OS_7_OR_EARLIER) {
        _webBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"Website" style:UIBarButtonItemStyleBordered target:self action:@selector(loadWeb)];
        _ShareBarButton = [[UIBarButtonItem alloc]initWithTitle:@"Share" style:UIBarButtonItemStyleBordered target:self action:@selector(Share)];
        self.navigationItem.rightBarButtonItem = _webBarBtn;
        self.navigationItem.leftBarButtonItem = _ShareBarButton;
        self.introView.frame = CGRectMake(0, -44, self.view.frame.size.width, self.view.frame.size.height);
    }else{
        _webBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"safari.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(loadWeb)];
        _ShareBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"heart.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(Share)];
        
        self.navigationItem.rightBarButtonItem = _webBarBtn;
        self.navigationItem.leftBarButtonItem = _ShareBarButton;
       self.introView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height);
    }
}
-(void)viewWillAppear:(BOOL)animated  {
    
   }
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
    [MMProgressHUD showWithTitle:@"Loading"
                          status:@"Tap to cancel"
             confirmationMessage:@"Cancel loading?"
                     cancelBlock:^{
                         NSLog(@"Task was cancelled!");
                         [self.HomeWebView stopLoading];
                     }];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MMProgressHUD dismissWithSuccess:@"Success"];

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MMProgressHUD dismissWithError:@"Failed"];
   

}

- (void)loadWeb{
    //ripple effect
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";

    self.navigationController.navigationBar.hidden = YES;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.fistudio.net"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"loaded"]  isEqual: @"loaded"]) {
                _container.hidden = NO;
                
                
            }else{
            _container.hidden = NO;
            self.HomeWebView.delegate = self;
            
            self.HomeWebView.scrollView.delegate = self;
            [self.HomeWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.fistudio.net"]]];
            
            }
         });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            CXAlertView *alertViewMe = [[CXAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"") message:NSLocalizedString(@"Unreachable, Please check your Internet", @"") cancelButtonTitle:@"OK"];
            
            [alertViewMe show];
        });
    };
    [reach startNotifier];

}

- (IBAction)hideweb:(id)sender {
    [[NSUserDefaults standardUserDefaults]setObject:@"loaded" forKey:@"loaded"];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    _container.hidden = YES;
        self.navigationController.navigationBar.hidden = NO;
    [[self.view layer] addAnimation:animation forKey:@"animation"];
    
}
- (void)Share{
    SLComposeViewController *facebook = [[SLComposeViewController alloc]init];
    facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebook setInitialText:[NSString stringWithFormat:@"Future Innovation Studio is a nice studio focusing on Web design and mobile app development, check out their service and website at www.fistudio.net"]];
    [facebook addImage:[UIImage imageNamed:@"logo.jpg"]];
    [self presentViewController:facebook animated:YES completion:nil];
    [facebook setCompletionHandler:^(SLComposeViewControllerResult result){
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Fair Enough";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Thank you";
            default:
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show] ;
    }];

}
- (IBAction)QuoteOffer:(id)sender {
    [self.tabBarController setSelectedIndex:3];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSURLCache sharedURLCache]removeAllCachedResponses];
    }

@end
