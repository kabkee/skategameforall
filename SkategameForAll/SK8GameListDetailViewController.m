//
//  SK8GameListDetailViewController.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 18..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SK8GameListDetailViewController.h"
#import "SK8GameListDetailCell.h"
#import "AppDelegate.h"

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
    NSLog(@"roomDetails : %@", self.roomDetails);
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
    return [self.sectionTitleArray objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    SK8GameListDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[SK8GameListDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
        
    }
    return cell;
}



@end
