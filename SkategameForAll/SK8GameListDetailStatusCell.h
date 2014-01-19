//
//  SK8GameListDetailStatusCell.h
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 19..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SK8GameListDetailStatusCell : UITableViewCell
@property UILabel * gameStatusStatic;
@property (strong, nonatomic) IBOutlet UIImageView *imgGameStatus;
@property (strong, nonatomic) IBOutlet UILabel *labelActualStatus;

@end
