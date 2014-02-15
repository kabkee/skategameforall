//
//  SideBarViewController.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 5..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SideBarViewController.h"
#import "SWRevealViewController.h"
#import "GTMOAuth2Authentication.h"
#import "LoginViewController.h"
#import "SideBarSocialIDCell.h"
#import "SideBarSocialPictureViewController.h"

static NSString *const kGoogleUserData = @"GoogleUserData";
static NSString *const kSkateGameForAllDefaults = @"skateGameForAllDefaults";
static NSString *const defaultSocialName = @"Log in needed";

@interface SideBarViewController ()
@property NSDictionary * userData;
@property NSUserDefaults * skategameForAllDefaults;
@property LoginViewController * loginViewController;
@property SideBarSocialIDCell * socialIDCell;
@property UIImage * defaultUserImage;
@end

@implementation SideBarViewController
@synthesize menuItems;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.defaultUserImage = [UIImage imageNamed:@"glyphicons_004_girl.png"];
    self.loginViewController = [[LoginViewController alloc]init];

    self.skategameForAllDefaults = [NSUserDefaults standardUserDefaults];
    NSNotificationCenter * nfCenter = [NSNotificationCenter defaultCenter];
    [nfCenter addObserver:self selector:@selector(defaultValueChanged:) name:NSUserDefaultsDidChangeNotification object:nil];
    
    menuItems = [[NSArray alloc] initWithObjects: @"SocialID" ,@"Home", @"Sk8Game List", @"LogOut", nil];
}

-(void)defaultValueChanged:(NSNotification *)notification
{
    NSUserDefaults * defaults = (NSUserDefaults *)[notification object];
    self.userData = [defaults objectForKey: kGoogleUserData];
//    NSLog(@"SideBarView defaults value changed : %@", self.userData);
    if (self.userData) {
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    int sectionCount = 0;
//    switch (section) {
//        case 0:
//            sectionCount = 1;
//            break;
//        case 1:
//            sectionCount = 2;
//            break;
//        case 2:
//            sectionCount = 1;
//            break;
//        default:
//            break;
//    }
    return [menuItems count];
}

//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    NSArray * titles = [[NSArray alloc] initWithObjects:@"", @"SkateGame For All", @"Log Out",nil];
//    return titles;
//}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    if (indexPath.row == 0) {
            self.socialIDCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if (!self.socialIDCell) {
            self.socialIDCell = [[SideBarSocialIDCell alloc] init];
        }

        if (self.userData) {
            self.socialIDCell.labelSocialID.text = [self.userData objectForKey:@"name"];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.userData objectForKey:@"picture"]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Update the UI
                    [self.socialIDCell.imgViewlSocialPic setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                });
            });
            self.socialIDCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            self.socialIDCell.labelSocialID.text = defaultSocialName;
            self.socialIDCell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        return self.socialIDCell;
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    if (indexPath.row == 0) {
        [self.tableView reloadData];
    }
    if (indexPath.row == 3) {
        [self.loginViewController signOut];
        [self.socialIDCell.imgViewlSocialPic setBackgroundImage:self.defaultUserImage forState:UIControlStateNormal];
        self.socialIDCell.labelSocialID.text = defaultSocialName;
        [self.tableView reloadData];
        [self performSegueWithIdentifier:@"goingToHomeSegue" sender:nil];
    }
}

#pragma mark - PrepareForSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

    NSString * destVCTitle;
    switch (indexPath.row) {
        case 0:
            break;
        case 1:
            destVCTitle = @"SkateGame For All";
            break;
        case 2:
            destVCTitle = @"List";
            break;
        default:
            break;
    }
    destViewController.title = [destVCTitle capitalizedString];
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
    }
    if ([[segue identifier] isEqualToString:@"showSocialPicture"]) {
        SideBarSocialPictureViewController * destSocialPictureViewController = (SideBarSocialPictureViewController *) [segue destinationViewController];
        UIImage * currentBackgroundImage = self.socialIDCell.imgViewlSocialPic.currentBackgroundImage;
        destSocialPictureViewController.socialPicture = currentBackgroundImage;
        destSocialPictureViewController.imgViewForSocialPicture.backgroundColor = [UIColor clearColor];
    }
}


@end
