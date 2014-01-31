//
//  SK8GameNewTableViewController.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 29..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//
//  Written by Moon
//  - All the class implementations don't work at all
//  - For the every delegate and data source should be re-impelementated very single time, especially with initWithNib

#import "SK8GameNewTableViewController.h"
#import "SK8GameNewTitleCell.h"
#import "SK8GameNewPasswordCell.h"
#import "SK8GameNewStartDateCell.h"
#import "SK8GameNewLimitDayCell.h"

@interface SK8GameNewTableViewController ()
@property (strong, nonatomic) SK8GameNewStartDateCell * startDateCell;
@property (strong, nonatomic) SK8GameNewLimitDayCell * attLimitDayCell;
@property (strong, nonatomic) SK8GameNewLimitDayCell * defLimitDayCell;
@property NSDate * tempSavedDateTime;
@property NSString * tempSavedAttLimitDay;
@property NSString * tempSavedDefLimitDay;
@property NSArray * cellArray;
@property NSArray * cellNibArray;
@property NSMutableArray * pickerViewDays;

@property BOOL dateTimeCellHidden;
@property BOOL attLimitCellHidden;
@property BOOL defLimitCellHidden;


@end

@implementation SK8GameNewTableViewController
@synthesize barBtnLeftCancel, barBtnRightDone;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cellArray = [[NSArray alloc]initWithObjects:@"titleCell", @"passwordCell", @"startAtCell", @"limitDayCell", @"limitDayCell", nil];
    self.cellNibArray = [[NSArray alloc]initWithObjects:@"SK8GameNewTitleCell", @"SK8GameNewPasswordCell", @"SK8GameNewStartDateCell", @"SK8GameNewLimitDayCell", @"SK8GameNewLimitDayCell", nil];

    self.pickerViewDays = [[NSMutableArray alloc]init];
    for (int i =0; i< 14; i++) {
        [self.pickerViewDays addObject:[NSString stringWithFormat:@"%d", i+1]];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Switch method to Enable or Unenable of password textField
- (void)switchChanged
{
    SK8GameNewPasswordCell * passwordCell = (SK8GameNewPasswordCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (!passwordCell.switchPasswordEnable.on) {
        passwordCell.backgroundColor = [UIColor lightGrayColor];
        
    }else{
        passwordCell.backgroundColor = [UIColor whiteColor];
    }
    passwordCell.textFieldPassword.enabled = passwordCell.switchPasswordEnable.on;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellArray count];
}

#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSString *CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; //@"titleCell"
        SK8GameNewTitleCell * titleCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (titleCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: [self.cellNibArray objectAtIndex:indexPath.row] owner:self options:nil];
            titleCell = [nib objectAtIndex:0];
        }
        titleCell.textFieldTitle.delegate = self;
        
        return titleCell;
    }
    if (indexPath.row == 1) {
        NSString *CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; //@"passwordCell";
        SK8GameNewPasswordCell * passwordCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (passwordCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: [self.cellNibArray objectAtIndex:indexPath.row] owner:self options:nil];
            passwordCell = [nib objectAtIndex:0];
        }
        
        passwordCell.textFieldPassword.delegate = self;
        [passwordCell.switchPasswordEnable addTarget:self action:@selector(switchChanged) forControlEvents:UIControlEventTouchUpInside];
        passwordCell.backgroundColor = [UIColor lightGrayColor];
        
        return passwordCell;
        
    }
    if (indexPath.row == 2) {
        NSString *CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; // @"startAtCell"
        SK8GameNewStartDateCell * startDateCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (startDateCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: [self.cellNibArray objectAtIndex:indexPath.row] owner:self options:nil];
            startDateCell = [nib objectAtIndex:0];
        }
        
        startDateCell.datePickerStartAt.minimumDate = [[ NSDate alloc ] initWithTimeIntervalSinceNow: (NSTimeInterval) 60*30 ];
        startDateCell.datePickerStartAt.maximumDate = [NSDate dateWithTimeIntervalSinceNow: 24*60*60*365];
        
        self.startDateCell = startDateCell;
        if (self.tempSavedDateTime) {
            self.startDateCell.labelStartAt.text = [self changeNSDateToString:self.tempSavedDateTime];
            self.startDateCell.datePickerStartAt.date = self.tempSavedDateTime;
        }else{
            [self dateTimePickedAndValueChanged];
        }
        
        [self.startDateCell.datePickerStartAt addTarget:self action:@selector(dateTimePickedAndValueChanged)  forControlEvents:UIControlEventValueChanged];
        
        return startDateCell;
    }
    if (indexPath.row == 3 || indexPath.row == 4) {
        NSString *CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; // @"limitDayCell"
        SK8GameNewLimitDayCell * limitDayCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (limitDayCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: [self.cellNibArray objectAtIndex:indexPath.row] owner:self options:nil];
            limitDayCell = [nib objectAtIndex:0];
        }

        limitDayCell.pickerViewForDays.delegate = self;
        limitDayCell.pickerViewForDays.dataSource = self;

        [limitDayCell.pickerViewForDays selectRow:6 inComponent:0 animated:YES];
        [self pickerView:limitDayCell.pickerViewForDays didSelectRow:6 inComponent:0];
        
        if (indexPath.row == 3) {   // Attack : cell optimizer
            limitDayCell.labelDefenceOrAttackMention.text = @"Attack Limit Days";
            if (self.tempSavedAttLimitDay) {
                limitDayCell.labelLimitDays.text = self.tempSavedAttLimitDay;
                [limitDayCell.pickerViewForDays selectRow:[self.tempSavedAttLimitDay integerValue]-1 inComponent:0 animated:YES];
            }
            self.attLimitDayCell = limitDayCell;
        }else{                      // Defence : cell optimizer
            limitDayCell.labelDefenceOrAttackMention.text = @"Defence Limit Days";
            if (self.tempSavedDefLimitDay) {
                limitDayCell.labelLimitDays.text = self.tempSavedDefLimitDay;
                [limitDayCell.pickerViewForDays selectRow:[self.tempSavedDefLimitDay integerValue]-1 inComponent:0 animated:YES];
            }
            self.defLimitDayCell = limitDayCell;
        }
        
        return limitDayCell;
    }

    // Default Cell
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    
    return cell;
}

- (NSString *)changeNSDateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    NSString * formattedDateString = [dateFormatter stringFromDate:date];
    dateFormatter = NULL;
    return formattedDateString;
}

- (void)dateTimePickedAndValueChanged
{
    if (self.tempSavedDateTime != self.startDateCell.datePickerStartAt.date || self.tempSavedDateTime ==nil) {
        self.startDateCell.labelStartAt.text = [self changeNSDateToString:self.startDateCell.datePickerStartAt.date];
        self.tempSavedDateTime = self.startDateCell.datePickerStartAt.date;
    }else{
        // Nothing to do
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        if (self.dateTimeCellHidden) {
            return 206;
        }else{
            return 44;
        }
            
    }else if (indexPath.row == 3){
        if (self.attLimitCellHidden) {
            return 206;
        }else{
            return 44;
        }
    }else if (indexPath.row == 4){
        if (self.defLimitCellHidden) {
            return 206;
        }else{
            return 44;
        }
    }
    // Default height of cells
    return  44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row ==4) {
        [self changeCellHidden: indexPath.row];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
        [tableView cellForRowAtIndexPath:indexPath].selected =NO;
    }else {
        // Nothing to do
    }

}

-(void)changeCellHidden: (int)row
{
    switch (row) {
        case 2:
            if(self.dateTimeCellHidden){
                self.dateTimeCellHidden = NO;
            }else{
                self.dateTimeCellHidden = YES;
            }
            break;
        case 3:
            if(self.attLimitCellHidden){
                self.attLimitCellHidden = NO;
            }else{
                self.attLimitCellHidden = YES;
            }
            break;
        case 4:
            if(self.defLimitCellHidden){
                self.defLimitCellHidden = NO;
            }else{
                self.defLimitCellHidden = YES;
            }
            break;
        default:
            break;
    }
}

#pragma mark - Picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerViewDays.count;
}

#pragma mark - Picker view delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerViewDays objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString * stringRow = [NSString stringWithFormat:@"%d", row+1];
    SK8GameNewLimitDayCell * tempCell;
    
    if (pickerView == self.attLimitDayCell.pickerViewForDays) {
        tempCell = self.attLimitDayCell;
        self.tempSavedAttLimitDay = stringRow;
    }else if (pickerView == self.defLimitDayCell.pickerViewForDays ){
        tempCell = self.defLimitDayCell;
        self.tempSavedDefLimitDay = stringRow;
    }
    tempCell.labelLimitDays.text = stringRow;
}

#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - IBAction Clicked bar Button item
- (IBAction)ClickedBarBtnLeftCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)ClickedBarBtnRightDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
