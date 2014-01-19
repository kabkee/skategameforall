//
//  SK8GameListDetailCell.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 18..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SK8GameListDetailCell.h"

@implementation SK8GameListDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:231 green:0 blue:141 alpha:1];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
