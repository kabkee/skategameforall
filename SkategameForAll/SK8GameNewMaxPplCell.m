//
//  SK8GameNewMaxPplCell.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 2. 6..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SK8GameNewMaxPplCell.h"

@implementation SK8GameNewMaxPplCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.numberOfPpl = [[NSMutableArray alloc]init];
        for (int i =0; i< 5; i++) {
            [self.numberOfPpl addObject:[NSString stringWithFormat:@"%d", i+1]];
        }
        if (!self.pickerViewForPpl) {
            self.pickerViewForPpl = [[UIPickerView alloc] init];
        }
        self.pickerViewForPpl.delegate = self;
        self.pickerViewForPpl.dataSource = self;
        
        NSLog(@"self.numbersOfPpl.count : %d", self.numberOfPpl.count);

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
    return [self.numberOfPpl count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.labelMaxPpl.text = [NSString stringWithFormat:@"%d", row];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSLog(@"title For row : %@", [self.numberOfPpl objectAtIndex:row]);
    return [self.numberOfPpl objectAtIndex:row];
}


@end
