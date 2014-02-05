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
#import "SK8GameNewAutoAttackOrderCell.h"

@interface SK8GameNewTableViewController ()
@property (strong, nonatomic) SK8GameNewStartDateCell * startDateCell;
@property (strong, nonatomic) SK8GameNewLimitDayCell * attLimitDayCell;
@property (strong, nonatomic) SK8GameNewLimitDayCell * defLimitDayCell;
@property (strong, nonatomic) UITextField * textFieldTitle;
@property (strong, nonatomic) UITextField * textFieldPassword;
@property (strong, nonatomic) UILabel * labelTitle;
@property (strong, nonatomic) UILabel * labelPassword;
@property NSDate * tempSavedDateTime;
@property NSString * tempSavedAttLimitDay;
@property NSString * tempSavedDefLimitDay;
@property NSArray * cellArray;
@property NSArray * cellNibArray;
@property NSMutableArray * pickerViewDays;
@property NSDictionary * goodForDone;
@property int lastSelectedRow;

@end

@implementation SK8GameNewTableViewController
@synthesize barBtnLeftCancel, barBtnRightDone;

static NSString * kTextFieldTitleValueChanged = @"textFieldTitleValueChange";
static NSString * kTextFieldPasswordEnabled = @"textFieldPasswordEnabled";

static NSString * kGoodForDoneTextFieldTitle = @"textFieldTitle";
static NSString * kGoodForDoneTextFieldPassword = @"textFieldPassword";

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
    
    self.cellArray = [[NSArray alloc]initWithObjects:@"titleCell", @"passwordCell", @"startAtCell", @"limitDayCell", @"limitDayCell", @"autoAttCell", nil];
    self.cellNibArray = [[NSArray alloc]initWithObjects:@"SK8GameNewTitleCell", @"SK8GameNewPasswordCell", @"SK8GameNewStartDateCell", @"SK8GameNewLimitDayCell", @"SK8GameNewLimitDayCell", @"SK8GameNewAutoAttackOrderCell", nil];

    self.pickerViewDays = [[NSMutableArray alloc]init];
    for (int i =0; i< 14; i++) {
        [self.pickerViewDays addObject:[NSString stringWithFormat:@"%d", i+1]];
    }
    
    self.goodForDone = @{
                         kGoodForDoneTextFieldTitle: @false,
                         kGoodForDoneTextFieldPassword: @false
                         };
    
//    [self.textFieldTitle addObserver:self forKeyPath:kTextFieldTitleValueChanged options:NSKeyValueObservingOptionNew context:NULL];
//    [self.textFieldPassword addObserver:self forKeyPath:kTextFieldPasswordEnabled options:NSKeyValueObservingOptionNew context:NULL];

    self.textFieldTitle = [[UITextField alloc] init];
    self.textFieldPassword = [[UITextField alloc] init];
    
    [self.textFieldTitle addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.textFieldPassword addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
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
        passwordCell.textFieldPassword.text = Nil;
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
        [titleCell.textFieldTitle addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        
        self.textFieldTitle = titleCell.textFieldTitle;
        self.labelTitle = titleCell.labelTitle;
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
        self.textFieldPassword = passwordCell.textFieldPassword;
        self.labelPassword = passwordCell.labelPassword;
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
    if (indexPath.row == 5) {
        NSString *CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; // @"autoAttCell"
        SK8GameNewAutoAttackOrderCell * autoAttCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (autoAttCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: [self.cellNibArray objectAtIndex:indexPath.row] owner:self options:nil];
            autoAttCell = [nib objectAtIndex:0];
        }
        return autoAttCell;
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
    if (self.lastSelectedRow == indexPath.row && (indexPath.row==2 || indexPath.row==3 || indexPath.row==4)) {
        return 206;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
        // User tap expanded row
        if (self.lastSelectedRow == indexPath.row) {
            self.lastSelectedRow = -1;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            return;
        }
        // User tap different row
        if (self.lastSelectedRow == -1) {
            NSIndexPath * prevPath = [NSIndexPath indexPathForRow:self.lastSelectedRow inSection:0];
            self.lastSelectedRow = indexPath.row;
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationFade];
            return;
        }
        // User tap new row
        self.lastSelectedRow = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }

    [self.textFieldPassword resignFirstResponder];
    [self.textFieldTitle resignFirstResponder];
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
    NSString * msg;
    
    if([self.goodForDone[kGoodForDoneTextFieldTitle] isEqual:@false] && [self.goodForDone[kGoodForDoneTextFieldPassword] isEqual:@false]){
        msg = @"Fill the Title and Password";
    }else if ([self.goodForDone[kGoodForDoneTextFieldTitle] isEqual:@false]) {
        msg = @"Fill the Title";
    }else if ([self.goodForDone[kGoodForDoneTextFieldPassword] isEqual:@false]){
        msg = @"Fill the Password";
    }else{
        msg = @"non of the cases";
    }
    if (msg) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Not Enough" message:msg delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    

}

#pragma mark - Observer act when recieving changed data
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    NSLog(@"Value changed");
//    if ([keyPath isEqualToString:kTextFieldTitleValueChanged]) {
//        NSLog(@"Title Value changed");
//
//        if ([self.textFieldTitle.text isEqualToString:@""] || self.textFieldTitle.text == NULL) {
//            self.labelTitle.textColor = [UIColor redColor];
//            [self.goodForDone setValue:@false forKey:kGoodForDoneTextFieldTitle];
//            
//        }else{
//            self.labelTitle.textColor = [UIColor blackColor];
//            [self.goodForDone setValue:@true forKey:kGoodForDoneTextFieldTitle];
//        }
//    }else if ([keyPath isEqualToString:kTextFieldPasswordEnabled]){
//        if ( self.textFieldPassword.enabled && ([self.textFieldPassword.text isEqualToString:@""] || self.textFieldPassword.text == NULL)) {
//            self.labelPassword.textColor = [UIColor redColor];
//            [self.goodForDone setValue:@false forKey:kGoodForDoneTextFieldPassword];
//        }else{
//            self.labelPassword.textColor = [UIColor blackColor];
//            [self.goodForDone setValue:@true forKey:kGoodForDoneTextFieldPassword];
//        }
//    }
//}

- (void)textFieldValueChanged: (UITextField *)sender
{
        NSLog(@"Value changed");
    if (sender == self.textFieldTitle) {
        NSLog(@"Title Value changed");
        if ([self.textFieldTitle.text isEqualToString:@""] || self.textFieldTitle.text == NULL) {
            self.labelTitle.textColor = [UIColor redColor];
            [self.goodForDone setValue:@false forKey:kGoodForDoneTextFieldTitle];
        }else{
            self.labelTitle.textColor = [UIColor blackColor];
            [self.goodForDone setValue:@true forKey:kGoodForDoneTextFieldTitle];
        }

    }else if (sender == self.textFieldPassword){
        if ( self.textFieldPassword.enabled && ([self.textFieldPassword.text isEqualToString:@""] || self.textFieldPassword.text == NULL)) {
            self.labelPassword.textColor = [UIColor redColor];
            [self.goodForDone setValue:@false forKey:kGoodForDoneTextFieldPassword];
        }else{
            self.labelPassword.textColor = [UIColor blackColor];
            [self.goodForDone setValue:@true forKey:kGoodForDoneTextFieldPassword];
        }
    }
}

@end
