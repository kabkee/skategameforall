//
//  SK8GameListViewController.h
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 5..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SK8GameNewTableViewController.h"

@interface SK8GameListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SK8GameNewTableViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *BtnStarred;
@property (strong, nonatomic) IBOutlet UIButton *BtnGames;
@property (strong, nonatomic) IBOutlet UIButton *BtnSearch;
@property (strong, nonatomic) IBOutlet UITableView *TableViewGamelist;

- (IBAction)changeGameList:(id)sender;

- (void)didDismissedModalView;


@end
