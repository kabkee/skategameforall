//
//  SK8GameListCell.h
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 18..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SK8GameListCell : UITableViewCell

// conver to Image
//@property (strong, nonatomic) IBOutlet UILabel *roomStatus;

@property (strong, nonatomic) IBOutlet UILabel *roomTitle;
@property (strong, nonatomic) IBOutlet UILabel *roomCreateDate;
@property (strong, nonatomic) IBOutlet UILabel *roomStartDate;
@property (strong, nonatomic) IBOutlet UIImageView *roomStatusImg;
@end
