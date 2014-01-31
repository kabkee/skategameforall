//
//  SK8GameNewLimitDayCell.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 31..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SK8GameNewLimitDayCell.h"

@interface SK8GameNewLimitDayCell ()


@end

@implementation SK8GameNewLimitDayCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.numbersOfDays = [[NSMutableArray alloc]init];
        for (int i =0; i< 14; i++) {
            [self.numbersOfDays addObject:[NSString stringWithFormat:@"%d", i+1]];
        }
        if (!self.pickerViewForDays) {
            self.pickerViewForDays = [[UIPickerView alloc] init];
        }
        self.pickerViewForDays.delegate = self;
        self.pickerViewForDays.dataSource = self;
        
        NSLog(@"self.numbersOfDays.coun : %d", self.numbersOfDays.count);
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.numbersOfDays count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.labelLimitDays.text = [NSString stringWithFormat:@"%d", row];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSLog(@"title For row : %@", [self.numbersOfDays objectAtIndex:row]);
    return [self.numbersOfDays objectAtIndex:row];
}

@end
