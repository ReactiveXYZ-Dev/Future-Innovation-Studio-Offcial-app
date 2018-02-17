//
//  LoginsNoteViewController.m
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-4-11.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import "LoginsNoteViewController.h"
#import "GRRequestsManager.h"
#import <QuartzCore/QuartzCore.h>
//HUD
#import "MMProgressHUD.h"
#import "MMProgressHUDOverlayView.h"
@interface LoginsNoteViewController ()<GRRequestsManagerDelegate,UITextViewDelegate>{
    NSString*host;
    NSString*username;
    NSString*password;
}
@property (nonatomic, strong) GRRequestsManager *requestsManager;


@end

@implementation LoginsNoteViewController
@synthesize LoginText,NameText;
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
    LoginText.layer.borderColor = [UIColor blueColor].CGColor;
    LoginText.layer.borderWidth = 1.2;
    LoginText.layer.cornerRadius = 10;
    [LoginText becomeFirstResponder];
    LoginText.delegate = self;
    NameText.delegate =self;
    NameText.layer.borderColor = [UIColor blueColor].CGColor;
    NameText.layer.borderWidth = 1.2;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"NameID"]!=nil) {
        NameText.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"NameID"];
    }
    //CONFIGURE FTP SERVICE
    host = @"ftp.fistudio.net";
    username = @"fistudionet";
    password = @"Gyzrw@520";
    //read file
   /* NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[[NSString stringWithFormat:@"logins-%@",NameText.text]stringByAppendingPathExtension:@".txt" ]];
    NSLog(@"%@",filePath);
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
    //no need start
        NSString *tmpdata = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:nil];
        NSData *decryptedData = [[tmpdata dataUsingEncoding:NSASCIIStringEncoding ] AESDecryptWithPassphrase:@"fistudio"];
        NSString* decryptedStr = [[NSString alloc] initWithData:decryptedData encoding:NSASCIIStringEncoding];
        LoginText.text = decryptedStr;
    //no need end
        NSError *error;
        NSString *tmpstring = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        LoginText.text = tmpstring;
    }*/
    if ( [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"logins-%@",NameText.text]]!=nil) {
        LoginText.text = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"logins-%@",NameText.text]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Button Actions
- (IBAction)Finish:(id)sender {
    UIAlertView *finishupAlert = [[UIAlertView alloc]initWithTitle:@"Done?" message:@"You are about to save your logins locally. It will be removed as soon as your app is reinstalled. You can choose to upload tp server, Always remember your Name ID!" delegate:self cancelButtonTitle:@"Wait!" otherButtonTitles:@"I'm done", nil];
    finishupAlert.tag = 0;
    [finishupAlert show];
}
- (IBAction)More:(id)sender {
    UIActionSheet*moreActions = [[UIActionSheet alloc]initWithTitle:@"More Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Discard" otherButtonTitles:@"Upload to server",@"Retrieve From Server",@"Delete from Server", nil];
    [moreActions showInView:self.view];
}
#pragma mark - UIAlertView & UIActionView delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 0) {
        if (buttonIndex == 1) {
            //Ready to save data...
            /*NSData *Data = [LoginText.text dataUsingEncoding: NSASCIIStringEncoding];
            NSData *EncryptedData = [Data AESEncryptWithPassphrase:@"fistudio"];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[[NSString stringWithFormat:@"Logins-%@",NameText.text]stringByAppendingPathExtension:@"txt"]];
            NSString *encryptedString = [[NSString alloc]initWithData:EncryptedData encoding:NSASCIIStringEncoding];
            NSLog(@"%@",encryptedString);
            NSError *error = nil;
            BOOL ok=[encryptedString writeToFile:filePath  atomically:NO encoding:NSASCIIStringEncoding error:&error];
            if (!ok) {
                NSLog(@"Fail: %@", [error localizedDescription]);
            }*/
            /*NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
            
            NSError *error;
            BOOL succeed = [LoginText.text writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"logins-%@",NameText.text]]
                                      atomically:YES encoding:NSUTF8StringEncoding error:&error];
            if (!succeed){
                // Handle error here
                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:[NSString stringWithFormat:@"Sorry, error %@ occurs",error] delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] ;
                [alert show];
            }*/
             [[NSUserDefaults standardUserDefaults]setObject:LoginText.text forKey:[NSString stringWithFormat:@"logins-%@",NameText.text]];
            //dismiss VC
           
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:{
            if (NameText.text.length <= 2) {
                UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Please fill up your name ID with some more characters!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] ;
                [alert show];
            }else{
            [self _setupManager];
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
                
                NSError *error;
                BOOL succeed = [LoginText.text writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"logins-%@.txt",NameText.text] ]
                                                atomically:YES encoding:NSUTF8StringEncoding error:&error];
                //NSLog(@"%@",[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"logins-%@.txt",NameText.text]]);
                if (!succeed){
                    // Handle error here
                    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:[NSString stringWithFormat:@"Sorry, error %@ occurs",error] delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] ;
                    [alert show];
                }else{
                     NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Logins-%@.txt",NameText.text]];
                    NSLog(@"%@",filePath);
                 if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                    [self.requestsManager addRequestForUploadFileAtLocalPath:filePath toRemotePath:[NSString stringWithFormat:@"dir/Logins-%@.txt",NameText.text]];
                    [self.requestsManager startProcessingRequests];
                    
                 }
                }
            }
        }
            break;
        case 2:{
            [self _setupManager];
            NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *localFilePath = [documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Logins-%@.txt",NameText.text]];
            
            [self.requestsManager addRequestForDownloadFileAtRemotePath:[NSString stringWithFormat:@"dir/Logins-%@.txt",NameText.text] toLocalPath:localFilePath];
            [self.requestsManager startProcessingRequests];
            
        }
            
            break;
        case 3:{
            [self _setupManager];
            [self.requestsManager addRequestForDeleteFileAtPath:[NSString stringWithFormat:@"dir/Logins-%@.txt",NameText.text]];
            [self.requestsManager startProcessingRequests];
            
        }
            
            break;
        default:
            break;
    }
}
#pragma mark - textfield delegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [[NSUserDefaults standardUserDefaults]setObject:NameText.text forKey:@"NameID"];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[NSUserDefaults standardUserDefaults]setObject:NameText.text forKey:@"NameID"];
    return YES;
}
#pragma mark - FTPDelegate
#pragma mark - Private Methods

- (void)_setupManager
{
    self.requestsManager = [[GRRequestsManager alloc] initWithHostname:host
                                                                  user:username
                                                              password:password];
    self.requestsManager.delegate = self;
}


#pragma mark - GRRequestsManagerDelegate

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didScheduleRequest:(id<GRRequestProtocol>)request
{
    NSLog(@"requestsManager:didScheduleRequest:");
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
    [MMProgressHUD showWithTitle:@"Processing" status:@"Doing something cool"];
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteListingRequest:(id<GRRequestProtocol>)request listing:(NSArray *)listing
{
    NSLog(@"requestsManager:didCompleteListingRequest:listing: \n%@", listing);
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteCreateDirectoryRequest:(id<GRRequestProtocol>)request
{
    NSLog(@"requestsManager:didCompleteCreateDirectoryRequest:");
    
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteDeleteRequest:(id<GRRequestProtocol>)request
{
    
    NSLog(@"requestsManager:didCompleteDeleteRequest:");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Your file is deleted" delegate:self cancelButtonTitle:@"okay" otherButtonTitles:nil, nil];
    
    [alert show];
    [MMProgressHUD dismissWithSuccess:@"Success"];
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompletePercent:(float)percent forRequest:(id<GRRequestProtocol>)request
{
    NSLog(@"requestsManager:didCompletePercent:forRequest: %f", percent);
    
    

}
#pragma mark -


- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteUploadRequest:(id<GRDataExchangeRequestProtocol>)request
{
    NSLog(@"requestsManager:didCompleteUploadRequest:");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Your file is uploaded" delegate:self cancelButtonTitle:@"okay" otherButtonTitles:nil, nil];
    [alert show];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"logins-%@.txt",NameText.text]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError*error;
       
        [[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
    }
    [MMProgressHUD dismissWithSuccess:@"Success"];
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteDownloadRequest:(id<GRDataExchangeRequestProtocol>)request
{
    NSLog(@"requestsManager:didCompleteDownloadRequest:");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Your file is retrieved" delegate:self cancelButtonTitle:@"okay" otherButtonTitles:nil, nil];
    
    [alert show];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"logins-%@.txt",NameText.text]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError*error;
        NSString *tmpstring = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        LoginText.text = tmpstring;
        [[NSUserDefaults standardUserDefaults]setObject:tmpstring forKey:[NSString stringWithFormat:@"logins-%@",NameText.text]];
        [[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
    }
    [MMProgressHUD dismissWithSuccess:@"Success"];
    
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didFailWritingFileAtPath:(NSString *)path forRequest:(id<GRDataExchangeRequestProtocol>)request error:(NSError *)error
{
    NSLog(@"requestsManager:didFailWritingFileAtPath:forRequest:error: \n %@", error);
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"writing failed, please check your internet connection" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] ;
    [alert show];
    [MMProgressHUD dismissWithError:@"Failed"];
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didFailRequest:(id<GRRequestProtocol>)request withError:(NSError *)error
{
    NSLog(@"requestsManager:didFailRequest:withError: \n %@", error);
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Request failed, please check your internet connection or whether your file is uploaded on server?" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] ;
    [alert show];
    [MMProgressHUD dismissWithError:@"Failed"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
