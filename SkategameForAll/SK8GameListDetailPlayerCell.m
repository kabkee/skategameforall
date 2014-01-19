//
//  SK8GameListDetailPlayerCell.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 19..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SK8GameListDetailPlayerCell.h"

@implementation SK8GameListDetailPlayerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    self.lableS.text = @"S";
    self.lableK.text = @"K";
    self.lableA.text = @"A";
    self.lableT.text = @"T";
    self.lableE.text = @"E";
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
