//
//  SK8GameListDetailViewController.h
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 18..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SK8GameListDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableViewGameDetail;
@property NSDictionary * roomDetails;

@end
