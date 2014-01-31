//
//  SK8GameNewLimitDayCell.h
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 31..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SK8GameNewLimitDayCell : UITableViewCell <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *labelDefenceOrAttackMention;
@property (strong, nonatomic) IBOutlet UILabel *labelLimitDays;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerViewForDays;

// only for unit test
@property NSMutableArray * numbersOfDays;


@end
