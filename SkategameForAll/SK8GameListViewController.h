//
//  SK8GameListViewController.h
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 5..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SK8GameListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *BtnStarred;
@property (strong, nonatomic) IBOutlet UIButton *BtnGames;
@property (strong, nonatomic) IBOutlet UIButton *BtnSearch;
@property (strong, nonatomic) IBOutlet UITableView *TableViewGamelist;



@end
