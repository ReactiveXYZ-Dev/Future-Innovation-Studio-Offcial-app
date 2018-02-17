//
//  ContactViewController.m
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-4-8.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import "ContactViewController.h"
#import <MapKit/MapKit.h>
#define IS_OS_7_OR_EARLIER    ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
@interface ContactViewController (){
    NSArray *tableArray;
    NSArray *tableImgArray;
    MKPinAnnotationView *PinView;
    MKPointAnnotation *anno;
}

@end

@implementation ContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.locationPickerView.tableView deselectRowAtIndexPath:[self.locationPickerView.tableView indexPathForSelectedRow] animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    // The LocationPickerView can be created programmatically (see below) or
    // using Storyboards/XIBs (see Storyboard file).
        // Optional parameters
    
    self.locationPickerView.delegate = self;
    self.locationPickerView.shouldAutoCenterOnUserLocation = NO;
    self.locationPickerView.shouldCreateHideMapButton = YES;
    self.locationPickerView.pullToExpandMapEnabled = YES;
    if (IS_OS_7_OR_EARLIER) {
        self.locationPickerView.defaultMapHeight = self.view.bounds.size.height * 0.25;
    }else{
    self.locationPickerView.defaultMapHeight = self.view.bounds.size.height * 0.37;           // larger than normal
    }
    self.locationPickerView.parallaxScrollFactor = 0.3;         // little slower than normal.
    // Optional setup
    self.locationPickerView.mapViewDidLoadBlock = ^(LocationPickerView *locationPicker) {
        MKMapRect zoomRect = MKMapRectNull;
        for (id <MKAnnotation> annotation in locationPicker.mapView.annotations)
        {
            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 500, 500);
            if (MKMapRectIsNull(zoomRect)) {
                zoomRect = pointRect;
            } else {
                zoomRect = MKMapRectUnion(zoomRect, pointRect);
            }
        }
        [locationPicker.mapView setVisibleMapRect:zoomRect animated:YES];
        
    };
    self.locationPickerView.tableViewDidLoadBlock = ^(LocationPickerView *locationPicker) {
        locationPicker.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    };
    

    NSString*tablestring = @"Mail,Phone,Message,Facebook,Term,Logins";
    tableArray = [tablestring componentsSeparatedByString:@","];
    NSString*tableImgString = @"mail.png,phone.png,message.png,facebook.png,terms.png,logins.png";
    tableImgArray = [tableImgString componentsSeparatedByString:@","];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *stCellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:stCellIdentifier];
    
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stCellIdentifier];
    cell.textLabel.text = [tableArray objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:[tableImgArray objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.locationPickerView.tableView deselectRowAtIndexPath:[self.locationPickerView.tableView indexPathForSelectedRow] animated:YES];
    switch (indexPath.row) {
        case 0:{
            MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
            [mailComposer setMailComposeDelegate:self];
            [mailComposer setToRecipients:[NSArray arrayWithObject:@"jackiee1998@icloud.com"]];
            [mailComposer setMessageBody:@"<h2>To Future Innovation Studio</h2><br/><strong>Question:</Strong><br/><strong>Quote:</strong><br/>Project Budget:<br/>Project Plan:</br>Project brief:<br/>Project Contact:" isHTML:YES];
            [self presentViewController:mailComposer animated:YES completion:nil];
        }
            break;
        case 1:{
            UIAlertView *callAlert = [[UIAlertView alloc]initWithTitle:@"Call us!" message:@"You will be called +61451139800 and speak to one of us" delegate:self cancelButtonTitle:@"Back" otherButtonTitles:@"Call", nil];
            callAlert.tag = 0;
            [callAlert show];
        }
    
            break;
        case 2:{
            Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
            if ([messageClass canSendText]){
                MFMessageComposeViewController *messagecontroller = [[MFMessageComposeViewController alloc]init];
                [messagecontroller setMessageComposeDelegate:self];
                [messagecontroller setRecipients:[NSArray arrayWithObject:@"0405225015"]];
                [self presentViewController:messagecontroller animated:YES completion:nil];
            }else{
                NSLog(@"can't send text");
            }
            
        }

            
            break;
        case 3:{
            UIAlertView *webAlert = [[UIAlertView alloc]initWithTitle:@"View our Facebook page!" message:@"You will be directly to Safari for our offical facebook page, please like and support us!" delegate:self cancelButtonTitle:@"Back" otherButtonTitles:@"Go", nil];
            webAlert.tag = 1;
            [webAlert show];
        }
            
            break;
        case 4:{
            
        UIAlertView *TermAlert = [[UIAlertView alloc]initWithTitle:@"Terms and Service" message:@"In no event shall Future Innovation Studio or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption,) arising out of the use or inability to use the materials on Future Innovation Studio's Internet site, even if Future Innovation Studio or a Future Innovation Studio authorized representative has been notified orally or in writing of the possibility of such damage. Because some jurisdictions do not allow limitations on implied warranties, or limitations of liability for consequential or incidental damages, these limitations may not apply to you." delegate:self cancelButtonTitle:@"I Understand" otherButtonTitles:nil, nil];
          
            [TermAlert show];
    }
    
            break;
        case 5:
            [self performSegueWithIdentifier:@"LoginSegue" sender:self];
            break;
        default:
            break;
    }
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Mail" message:@"Send us an e-mail with your question or quote,usually respond within one business day" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }
            
            break;
        case 1:{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Call us" message:@"Call us to talk closely. Not always online, please understand." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }
            
            break;
        case 2:{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message us" message:@"Message us for a quick request or question, usually reply within an hour!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }
            
            break;
        case 3:{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook Page" message:@"You will be directly to Safari for our official Facebook page, Please support us" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
           
            [alert show];
        }
            
            break;
        case 4:{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Urgent terms" message:@"Make sure you read it before life ended:)" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case 5:{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Manage your logins" message:@"Manage your logins for our systems! Data always encrypted." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }

            
            break;
        default:
            break;
    }
}
#pragma mark - Message/Mail Delegate Method
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [ self dismissViewControllerAnimated:YES completion:^(void){}];
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (error) {
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Can't sent mail" message:[NSString stringWithFormat:@"error %@",[error description]] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
        [Alert show];
        [ self dismissViewControllerAnimated:YES completion:^(void){}];
        
    }
    else {
        [ self dismissViewControllerAnimated:YES completion:^(void){}];
        
    }
    
    
}
#pragma mark - AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 0:
            if (buttonIndex == 1) {
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:0061451139800"]];
            }
            break;
        case 1:
            if (buttonIndex == 1) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://www.facebook.com/pages/Future-Innovation-Studio-FIStudio/692270060804488"]];
               
            }
        default:
            break;
    }
}
#pragma mark - LocationPickerViewDelegate

/** Called when the mapView is about to be expanded (made fullscreen).
 Use this to perform custom animations or set attributes of the map/table. */
- (void)locationPicker:(LocationPickerView *)locationPicker
     mapViewWillExpand:(MKMapView *)mapView
{
    
    [self openAnnotation:anno];
}

/** Called when the mapView was expanded (made fullscreen). Use this to
 perform custom animations or set attributes of the map/table. */
- (void)locationPicker:(LocationPickerView *)locationPicker
      mapViewDidExpand:(MKMapView *)mapView
{
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:locationPicker action:@selector(toggleMapView:)];
    
    self.navigationItem.rightBarButtonItem = closeBtn;
}

/** Called when the mapView is about to be hidden (made tiny). Use this to
 perform custom animations or set attributes of the map/table. */
- (void)locationPicker:(LocationPickerView *)locationPicker
   mapViewWillBeHidden:(MKMapView *)mapView
{
   
}

/** Called when the mapView was hidden (made tiny). Use this to
 perform custom animations or set attributes of the map/table. */
- (void)locationPicker:(LocationPickerView *)locationPicker
      mapViewWasHidden:(MKMapView *)mapView
{
    UIBarButtonItem *showBtn = [[UIBarButtonItem alloc]initWithTitle:@"Show" style:UIBarButtonItemStyleBordered target:locationPicker action:@selector(toggleMapView:)];
    
    self.navigationItem.rightBarButtonItem = showBtn;
}

- (void)locationPicker:(LocationPickerView *)locationPicker mapViewDidLoad:(MKMapView *)mapView
{
    
    CLLocationCoordinate2D coord;
    coord.latitude = -37.797246;
    coord.longitude = 144.956088;
    anno = [[MKPointAnnotation alloc]init ];
    anno.coordinate = coord;
    anno.title = @"Future Innovation Studio";
    anno.subtitle = @"Hello world, we are here";
    
    
    [mapView addAnnotation: anno];
}

- (void)locationPicker:(LocationPickerView *)locationPicker tableViewDidLoad:(UITableView *)tableView
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}
- (void)openAnnotation:(id)annotation;
{
    //mv is the mapView
    [self.locationPickerView.mapView selectAnnotation:annotation animated:YES];
    
}
@end
