//
//  SK8GameNewMaxPplCell.h
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 2. 6..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SK8GameNewMaxPplCell : UITableViewCell <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelMaxPpl;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerViewForPpl;

@property NSMutableArray * numberOfPpl;

@end
