//
//  SK8GameListViewController.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 5..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SK8GameListViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "SK8GameListCell.h"
#import "SK8GameListDetailViewController.h"

@interface SK8GameListViewController ()
@property UIImage * Image_BlockMenuBarButton;
@property UIButton * Btn_ForCustomBarButtonItem;
@property NSDictionary * DicGameList;
@property NSDictionary * RoomDetails;
@property NSString *RoomDetailTitle; // roomTitle for roomDetailTableView
@property UITableViewController * tableViewControllerForRefreshControl;

@end

@implementation SK8GameListViewController
@synthesize  Image_BlockMenuBarButton, Btn_ForCustomBarButtonItem;
@synthesize BtnGames, BtnSearch, BtnStarred;
@synthesize TableViewGamelist;

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
    
    // Image for Custom barButtonItem Left - SideBarView
    Image_BlockMenuBarButton = [UIImage imageNamed:@"block-menu.png"];
    // Set a button for Custom barButtonItem
    Btn_ForCustomBarButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn_ForCustomBarButtonItem setBackgroundImage:Image_BlockMenuBarButton forState:UIControlStateNormal];
    Btn_ForCustomBarButtonItem.frame = CGRectMake(0, 0, Image_BlockMenuBarButton.size.width, Image_BlockMenuBarButton.size.height);
    [Btn_ForCustomBarButtonItem addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barButtonItemToShowSideBarView = [[UIBarButtonItem alloc] initWithCustomView:Btn_ForCustomBarButtonItem];
    self.navigationItem.leftBarButtonItem = barButtonItemToShowSideBarView;
    
    // BarbuttonItem Right - New Room
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonSystemItemAdd target:self action:@selector(showUpNewRoomModal)];
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    //data source
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.DicGameList = appDelegate.tempGameList;
    
    self.TableViewGamelist.dataSource = self;
    self.TableViewGamelist.delegate = self;
    
    
    // UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init]; [refreshControl addTarget:self action:@selector(updateDataSource) forControlEvents:UIControlEventValueChanged];
    
    self.tableViewControllerForRefreshControl = [[UITableViewController alloc] init];
    self.tableViewControllerForRefreshControl.tableView = self.TableViewGamelist;
    self.tableViewControllerForRefreshControl.refreshControl = refreshControl;
    
}

- (void)updateDataSource
{
    [self.TableViewGamelist reloadData];
    [self.tableViewControllerForRefreshControl.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NewRoom Modal
- (void)showUpNewRoomModal
{
    [self performSegueWithIdentifier:@"SK8GameNewModal" sender:self];
}

#pragma mark - TableView DataSource
- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DicGameList.count;
}

#pragma mark - TableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    SK8GameListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[SK8GameListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
        
    }
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithArray:[self.DicGameList allKeys]];
    NSInteger row = [indexPath row];
    
    if (![keys[row] isEqualToString:@""]) {
        
        if( [self.DicGameList valueForKey:keys[row]]){
            NSDictionary * dic = [self.DicGameList valueForKey:keys[row]];
            
            //createDate, status, title, gameStartTime
            cell.roomCreateDate.text = [dic valueForKey:@"createDate"];
            cell.roomStartDate.text = [dic valueForKey:@"gameStartTime"];
            //        cell.roomStatus.text = [dic valueForKey:@"status"];
            cell.roomTitle.text = [dic valueForKey:@"title"];
            NSString *imgName = [dic valueForKey:@"status"];
            cell.roomStatusImg.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@.png", imgName]];
        }
    }else{
        UITableViewCell * defaultCell = [[UITableViewCell alloc] init];
        defaultCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return defaultCell;
    }
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

#pragma mark - PrepareForSegue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // passing room detail data to Sk8GameDetailViewController
    if([segue.identifier isEqualToString:@"SK8GameDetail"]){
        SK8GameListCell *cell = sender;
        UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
        destViewController.title = cell.roomTitle.text;
        SK8GameListDetailViewController * sk8vc = [segue destinationViewController];
        NSIndexPath * idxPath = [self.TableViewGamelist indexPathForCell:sender];
        NSMutableArray *keys = [[NSMutableArray alloc] initWithArray:[self.DicGameList allKeys]];
        NSInteger row = [idxPath row];
        self.RoomDetails = [self.DicGameList valueForKey:keys[row]];
        sk8vc.roomDetails = self.RoomDetails;
    }else if ([segue.identifier isEqualToString:@"SK8GameNewModal"]){
        
    }
    
    
}

@end
