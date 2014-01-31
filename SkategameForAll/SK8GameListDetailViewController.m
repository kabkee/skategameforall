//
//  SK8GameListDetailViewController.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 18..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SK8GameListDetailViewController.h"
#import "SK8GameListDetailCell.h"
//#import "AppDelegate.h"
#import "SK8GameListDetailStatusCell.h"
#import "SK8GameListDetailPlayerCell.h"

@interface SK8GameListDetailViewController ()
@property NSArray * sectionTitleArray;
@end

@implementation SK8GameListDetailViewController


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
    if(!self.tableViewGameDetail){
        self.tableViewGameDetail = [[UITableView alloc]init];
    }
    self.tableViewGameDetail.delegate = self;
    self.tableViewGameDetail.dataSource = self;
    
    self.sectionTitleArray = @[@"Status", @"Participants", @"Watchers"];
//    NSLog(@"roomDetails : %@", self.roomDetails);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int i = 0;
    switch (section) {
        case 0: // status, [ready, playing, paused, ended]
            return i=1;
            break;
        case 1: // participants, players
            return i= [[self.roomDetails objectForKey:@"players"] count];
            break;
        case 2: // participants, watchers
            return i= [[self.roomDetails objectForKey:@"watchers"] count];
        default:
            break;
    }
    return i;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self.sectionTitleArray objectAtIndex:section];
    
    if (section == 1) {
        sectionTitle = [NSString stringWithFormat:@"%@ (%d)",[self.sectionTitleArray objectAtIndex:section], [[self.roomDetails objectForKey:@"players"] count]];
    }
    if (section == 2) {
        sectionTitle = [NSString stringWithFormat:@"%@ (%d)",[self.sectionTitleArray objectAtIndex:section], [[self.roomDetails objectForKey:@"watchers"] count]];
    }
   
    return sectionTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        static NSString *cellIdentifier = @"statusCell";
        SK8GameListDetailStatusCell *statusCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (statusCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: @"SK8GameListDetailStatusCell" owner:self options:nil];
            statusCell = [nib objectAtIndex:0];
        }
        NSString *imgName = [self.roomDetails valueForKey:@"status"];
        statusCell.imgGameStatus.image = [UIImage imageNamed: [NSString stringWithFormat:@"%@.png", imgName]];
        statusCell.labelActualStatus.text = imgName;
        return statusCell;
    }
    
    if (indexPath.section == 1) {
        // specify playerCells
        static NSString *cellIdentifier = @"playerCell";
        SK8GameListDetailPlayerCell *playerCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (playerCell ==nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: @"SK8GameListDetailPlayerCell" owner:self options:nil];
            playerCell = [nib objectAtIndex:0];
        }
        NSArray * players = [self.roomDetails valueForKey:@"players"];
        playerCell.lablePlayer.text = players[[indexPath row]];
        NSDictionary * scores = [self.roomDetails valueForKey:@"scores"];
        int playerScore = [[scores valueForKey:players[[indexPath row]]] integerValue];
        NSArray *labelArrayForScore = [[NSArray alloc] initWithObjects: playerCell.lableS, playerCell.lableK, playerCell.lableA, playerCell.lableT, playerCell.lableE, nil];

        for (int i = 0; i < playerScore; i++) {
            UILabel *labelScore = (UILabel *) labelArrayForScore[i];
            labelScore.textColor = [UIColor redColor];
        }
        return playerCell;
    }
    if (indexPath.section ==2) {
        // specify watcherCells
        static NSString *cellIdentifier = @"watcherCell";
        SK8GameListDetailCell *watcherCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(watcherCell == nil){
            watcherCell = [[SK8GameListDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
        }
        NSArray * watchers = [self.roomDetails valueForKey:@"watchers"];
        watcherCell.lableWatcher.text = watchers[[indexPath row]];
        return watcherCell;

    }
    SK8GameListDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[SK8GameListDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
        
    }
    return cell;
}



@end
