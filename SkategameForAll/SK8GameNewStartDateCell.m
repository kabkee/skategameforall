//
//  SK8GameNewStartDateCell.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 30..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SK8GameNewStartDateCell.h"

@implementation SK8GameNewStartDateCell
@synthesize datePickerStartAt;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        if (!datePickerStartAt) {
            datePickerStartAt = [[UIDatePicker alloc] init];
        }
        datePickerStartAt.minimumDate = [[ NSDate alloc ] initWithTimeIntervalSinceNow: (NSTimeInterval) 0 ];
        datePickerStartAt.maximumDate = [NSDate dateWithTimeIntervalSinceNow: 24*60*60*365];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
