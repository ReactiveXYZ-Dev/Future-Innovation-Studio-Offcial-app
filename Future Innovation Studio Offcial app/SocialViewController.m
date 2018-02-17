//
//  SocialViewController.m
//  Future Innovation Studio Offcial app
//
//  Created by Jackie C on 14-2-16.
//  Copyright (c) 2014年 FIStudio. All rights reserved.
//

#import "SocialViewController.h"
#import "CXAlertView.h"
#import "CommunityViewController.h"
#import "UITabBarController+HideTabBar.h"
#import "SocialTableViewCell.h"
@interface SocialViewController ()

@end
@implementation SocialViewController
@synthesize SocialTable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
        
    }
    return self;
}
#pragma TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 0;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Cool Stuff";
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"More to Come";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 99;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    // create the label
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    footerLabel.backgroundColor = [UIColor clearColor];
    footerLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
    footerLabel.frame = CGRectMake(0, 0, 320, 40);
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.text = @"More to come \n Stay Tuned";
    footerLabel.textColor = [UIColor grayColor];
    footerLabel.numberOfLines = 0;
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    customView.backgroundColor = [UIColor clearColor];
    [customView addSubview:footerLabel];
    return customView;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *SocialTableIdentifier = @"Cell";
    
    SocialTableViewCell *cell = (SocialTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SocialTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SocialTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.TitleLabel.text = @"Social Network";
            cell.DescriptionLabel.text = @"Get around into our friend circle, Chat and have fun!";
            cell.SocialIcon.image = [UIImage imageNamed:@"SocialNetwork.png"];
            break;
        case 1:
            cell.TitleLabel.text = @"Forum";
            cell.DescriptionLabel.text = @"Have any queries? Go and ask us!";
            cell.SocialIcon.image =[UIImage imageNamed:@"Forum.png"];
            break;
        default:
            break;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self gotosocial];
            break;
        case 1:
            [self gotoforum];
            break;
        default:
            break;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [self.SocialTable deselectRowAtIndexPath:[self.SocialTable indexPathForSelectedRow] animated:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    SocialTable.delegate = self;
    SocialTable.dataSource = self;
}
-(void)viewDidAppear:(BOOL)animated{
    [self.tabBarController setTabBarHidden:NO animated:YES];
}


- (void)gotoforum{
    [self performSegueWithIdentifier:@"webpushforum" sender:self];
   
}
- (void)gotosocial{
    [self performSegueWithIdentifier:@"webpushsocial" sender:self];
}

//segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
    if ([segue.identifier  isEqual: @"webpushforum"]) {
        [segue.destinationViewController setValue:@"http://forum.fistudio.net" forKey:@"URLKey"];
        [segue.destinationViewController setValue:@"Forum" forKey:@"titleKey"];
    }
    if ([segue.identifier  isEqual: @"webpushsocial"]) {
        [segue.destinationViewController setValue:@"http://social.fistudio.net" forKey:@"URLKey"];
        [segue.destinationViewController setValue:@"Social" forKey:@"titleKey"];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSURLCache sharedURLCache]removeAllCachedResponses];
}

@end
