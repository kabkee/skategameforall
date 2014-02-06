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
#import "SK8GameNewMaxPplCell.h"
#import "AppDelegate.h"

@interface SK8GameNewTableViewController ()
@property (strong, nonatomic) SK8GameNewTitleCell * titleCell;
@property (strong, nonatomic) SK8GameNewPasswordCell * passwordCell;
@property (strong, nonatomic) SK8GameNewStartDateCell * startDateCell;
@property (strong, nonatomic) SK8GameNewMaxPplCell * maxPplCell;
@property (strong, nonatomic) SK8GameNewLimitDayCell * attLimitDayCell;
@property (strong, nonatomic) SK8GameNewLimitDayCell * defLimitDayCell;
@property (strong, nonatomic) SK8GameNewAutoAttackOrderCell * autoAttackOrderCell;
@property (strong, nonatomic) NSDate * tempSavedDateTime;
@property (strong, nonatomic) NSString * tempSavedMaxPpl;
@property (strong, nonatomic) NSString * tempSavedAttLimitDay;
@property (strong, nonatomic) NSString * tempSavedDefLimitDay;
@property (strong, nonatomic) NSArray * cellArray;
@property (strong, nonatomic) NSArray * cellNibArray;
@property (strong, nonatomic) NSMutableArray * pickerViewDays;
@property (strong, nonatomic) NSMutableArray * pickerViewPpl;
@property (strong, nonatomic) NSMutableDictionary * goodForDone;
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
    
    self.cellArray = [[NSArray alloc]initWithObjects:@"titleCell", @"passwordCell", @"startAtCell", @"maxPplCell" @"limitDayCell", @"limitDayCell", @"autoAttCell", nil];
    self.cellNibArray = [[NSArray alloc]initWithObjects:@"SK8GameNewTitleCell", @"SK8GameNewPasswordCell", @"SK8GameNewStartDateCell", @"SK8GameNewMaxPplCell", @"SK8GameNewLimitDayCell", @"SK8GameNewLimitDayCell", @"SK8GameNewAutoAttackOrderCell", nil];

    self.pickerViewDays = [[NSMutableArray alloc]init];
    for (int i =0; i< 14; i++) {
        [self.pickerViewDays addObject:[NSString stringWithFormat:@"%d", i+1]];
    }
    self.pickerViewPpl = [[NSMutableArray alloc]init];
    for (int i =0; i< 5; i++) {
        [self.pickerViewPpl addObject:[NSString stringWithFormat:@"%d", i+1]];
    }
    
    if (!self.goodForDone) {
        self.goodForDone = [[NSMutableDictionary alloc] init];
    }
    [self.goodForDone setObject:@false forKey:kGoodForDoneTextFieldTitle];
    [self.goodForDone setObject:@false forKey:kGoodForDoneTextFieldPassword];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Switch method to Enable or Unenable of password textField
- (void)passwordCellSwitchChanged
{
    SK8GameNewPasswordCell * passwordCell = (SK8GameNewPasswordCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (!passwordCell.switchPasswordEnable.on) {
        passwordCell.backgroundColor = [UIColor lightGrayColor];
        passwordCell.textFieldPassword.text = Nil;
        passwordCell.labelPassword.textColor = [UIColor blackColor];
        [self.goodForDone setObject:@true forKey:kGoodForDoneTextFieldPassword];
    }else{
        passwordCell.backgroundColor = [UIColor whiteColor];
        if ([passwordCell.textFieldPassword.text isEqualToString:@""] || passwordCell.textFieldPassword.text == NULL) {
            passwordCell.labelPassword.textColor = [UIColor redColor];
        }

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
    NSString *CellIdentifier;
    if (indexPath.row == 0) {
        CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; //@"titleCell"
        self.titleCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (self.titleCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: [self.cellNibArray objectAtIndex:indexPath.row] owner:self options:nil];
            self.titleCell = [nib objectAtIndex:0];
        }
        self.titleCell.textFieldTitle.delegate = self;
        [self.titleCell.textFieldTitle addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        self.titleCell.labelTitle.textColor = [UIColor redColor];
        
        return self.titleCell;
    }
    if (indexPath.row == 1) {
        CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; //@"passwordCell";
        self.passwordCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (self.passwordCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: [self.cellNibArray objectAtIndex:indexPath.row] owner:self options:nil];
            self.passwordCell = [nib objectAtIndex:0];
        }
        
        self.passwordCell.textFieldPassword.delegate = self;
        [self.passwordCell.switchPasswordEnable addTarget:self action:@selector(passwordCellSwitchChanged) forControlEvents:UIControlEventTouchUpInside];
        self.passwordCell.backgroundColor = [UIColor lightGrayColor];
        
        [self.passwordCell.textFieldPassword addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];

        return self.passwordCell;
        
    }
    if (indexPath.row == 2) {
        CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; // @"startAtCell"
        self.startDateCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (self.startDateCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: [self.cellNibArray objectAtIndex:indexPath.row] owner:self options:nil];
            self.startDateCell = [nib objectAtIndex:0];
        }
        
        self.startDateCell.datePickerStartAt.minimumDate = [[ NSDate alloc ] initWithTimeIntervalSinceNow: (NSTimeInterval) 60*30 ];
        self.startDateCell.datePickerStartAt.maximumDate = [NSDate dateWithTimeIntervalSinceNow: 24*60*60*365];
        
        if (self.tempSavedDateTime) {
            self.startDateCell.labelStartAt.text = [self changeNSDateToString:self.tempSavedDateTime];
            self.startDateCell.datePickerStartAt.date = self.tempSavedDateTime;
        }else{
            [self dateTimePickedAndValueChanged];
        }
        
        [self.startDateCell.datePickerStartAt addTarget:self action:@selector(dateTimePickedAndValueChanged)  forControlEvents:UIControlEventValueChanged];
        
        return self.startDateCell;
    }
    if (indexPath.row == 3) {
        CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; // @"maxPplCell"
        self.maxPplCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (self.maxPplCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: [self.cellNibArray objectAtIndex:indexPath.row] owner:self options:nil];
            self.maxPplCell= [nib objectAtIndex:0];
        }
        
        self.maxPplCell.pickerViewForPpl.delegate = self;
        self.maxPplCell.pickerViewForPpl.dataSource = self;
        
        [self.maxPplCell.pickerViewForPpl selectRow:4 inComponent:0 animated:YES];
        
        if (self.tempSavedMaxPpl) {
            self.maxPplCell.labelMaxPpl.text = self.tempSavedMaxPpl;
            [self.maxPplCell.pickerViewForPpl selectRow:[self.tempSavedMaxPpl integerValue]-1 inComponent:0 animated:YES];
        }
        return self.maxPplCell;
    }
    if (indexPath.row == 4 || indexPath.row == 5) {
        CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; // @"limitDayCell"
        SK8GameNewLimitDayCell * limitDayCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (limitDayCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: [self.cellNibArray objectAtIndex:indexPath.row] owner:self options:nil];
            limitDayCell = [nib objectAtIndex:0];
        }

        limitDayCell.pickerViewForDays.delegate = self;
        limitDayCell.pickerViewForDays.dataSource = self;

        [limitDayCell.pickerViewForDays selectRow:6 inComponent:0 animated:YES];
        [self pickerView:limitDayCell.pickerViewForDays didSelectRow:6 inComponent:0];
        
        if (indexPath.row == 4) {   // Attack : cell optimizer
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
    if (indexPath.row == 6) {
        CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; // @"autoAttCell"
        self.autoAttackOrderCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (self.autoAttackOrderCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: [self.cellNibArray objectAtIndex:indexPath.row] owner:self options:nil];
            self.autoAttackOrderCell = [nib objectAtIndex:0];
        }
        return self.autoAttackOrderCell;
    }
    // Default Cell
    CellIdentifier = @"cell";
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
    if (self.lastSelectedRow == indexPath.row && (indexPath.row==2 || indexPath.row==3 || indexPath.row==4 || indexPath.row==5)) {
        return 206;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 ) {
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

    [self.passwordCell.textFieldPassword resignFirstResponder];
    [self.titleCell.textFieldTitle resignFirstResponder];
}

#pragma mark - Picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.maxPplCell.pickerViewForPpl) {
        return self.pickerViewPpl.count;
    }
    return self.pickerViewDays.count;
}

#pragma mark - Picker view delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.maxPplCell.pickerViewForPpl) {
        return [self.pickerViewPpl objectAtIndex:row];
    }
    return [self.pickerViewDays objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString * stringRow = [NSString stringWithFormat:@"%d", row+1];
    SK8GameNewLimitDayCell * tempCell;

    if (pickerView == self.maxPplCell.pickerViewForPpl) {
        self.tempSavedMaxPpl = stringRow;
        self.maxPplCell.labelMaxPpl.text = stringRow;
    }else{
        if (pickerView == self.attLimitDayCell.pickerViewForDays) {
            tempCell = self.attLimitDayCell;
            self.tempSavedAttLimitDay = stringRow;
        }else if (pickerView == self.defLimitDayCell.pickerViewForDays ){
            tempCell = self.defLimitDayCell;
            self.tempSavedDefLimitDay = stringRow;
        }
        tempCell.labelLimitDays.text = stringRow;
    }
    
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
    if([self.goodForDone[kGoodForDoneTextFieldTitle] isEqual:@false] && [self.goodForDone[kGoodForDoneTextFieldPassword] isEqual:@false] && self.passwordCell.textFieldPassword.enabled){
        msg = @"Fill the Title and Password";
    }else{
        if ([self.goodForDone[kGoodForDoneTextFieldTitle] isEqual:@false]) {
            msg = @"Fill the Title";
        }else if(self.passwordCell.textFieldPassword.enabled){
            msg = @"Fill the Password";
        }else{
            msg = NULL;
        }
    }
    if (msg) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Not Enough" message:msg delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        // Do save all the info of new room
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

  @{@"room1":
        @{
            //roomDetail
            @"createDate": @"2014-01-13", //dateTime
            @"status": @"Playing", // [Ready, Playing, Paused, Ended]
            @"title": @"Kabkee's room1", //string
            @"gameStartTime": @"2014-01-15", //dateTime
            @"maxPpl":@5, // max 5 ppl
            @"players":@[@"kabkee",@"Gomsun2", @"Minsu"], //array // attOrder
            @"watchers":@[@"kabkeeWC",@"Gomsun2WC", @"MinsuWC", @"SuminWC", @"DanbeeWC", @"HyojuWC"], // array
            @"clikingNo":@100, // int
            @"starred":@[@"kabkeeST",@"Gomsun2ST", @"MinsuST", @"SuminST", @"DanbeeST", @"HyojuST"], // array
            @"attLimitDay":@7, // int Days
            @"defLimitDay":@7, // int Days
            @"orderAttAutomate":@NO, //boolean
            //gameDetail
            @"statusOfAtt":@YES, //booean Att=YES, Def=NO
            @"attacker":@"kabkee",
            @"defender":@[@"Gomsun2"], // who uploaded def video
            @"videos":@[
                    @{@"statusOfAtt": @YES,
                      @"videoAdd":@"http://urlAtt.com",
                      @"regTime":@"2014-01-14",
                      @"title":@"kickflip",
                      @"player":@"kabkee"},
                    @{@"statusOfAtt": @NO,
                      @"videoAdd":@"http://urlDef.com",
                      @"regTime":@"2014-01-15",
                      @"title":@"kickflip",
                      @"player":@"Gomsun2"}
                    ],
            @"scores":@{@"kabkee": @2,
                        @"Gomsun2": @3,
                        @"Minsu": @5} // S(1), K(2), A(3), T(4), E(5)= over
            },
    };
        
        static NSString * kRoomDataCreateDate = @"createDate";
        static NSString * kRoomDataStatus = @"status";
        static NSString * kRoomDataTitle = @"title";
        static NSString * kRoomDataGameStartTime = @"gameStartTime";
        static NSString * kRoomDataMaxPpl = @"maxPpl";
        static NSString * kRoomDataPlayers = @"players";
        static NSString * kRoomDataAttLimitDay = @"attLimitDay";
        static NSString * kRoomDataDefLimitDay = @"defLimitDay";
        static NSString * kRoomDataOrderAttAutomate = @"orderAttAutomate";
        static NSString * kRoomDataWatchers = @"watchers";
        static NSString * kRoomDataClickingNo = @"clickingNo";
        static NSString * kRoomDataStarred = @"starred";
        
        NSDictionary *newRoom = @{
                                  @"key": [NSString stringWithFormat:@"%@+%@+%@",self.startDateCell.labelStartAt.text, self.titleCell.textFieldTitle.text, [NSDate new]],
                                  @"value":
                                      @{ kRoomDataCreateDate: [NSString stringWithFormat:@"%@",[NSDate new]],
                                         kRoomDataStatus: @"Ready",
                                         kRoomDataTitle: self.titleCell.textFieldTitle.text,
                                         kRoomDataGameStartTime: self.startDateCell.labelStartAt.text,
                                         kRoomDataMaxPpl: self.maxPplCell.labelMaxPpl.text,
                                         kRoomDataPlayers: @[
                                                    // SOCIAL NETWORK ID
                                                 ],
                                         kRoomDataAttLimitDay: self.attLimitDayCell.labelLimitDays.text,
                                         kRoomDataDefLimitDay: self.defLimitDayCell.labelLimitDays.text,
                                         kRoomDataOrderAttAutomate: [self autoAttackOrderCellSwitchOnToNSBool]
                                        }
                                  };
    
    
        [appDelegate addData:newRoom];
    
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (id)autoAttackOrderCellSwitchOnToNSBool{
    if (self.autoAttackOrderCell.switchAutoAttackOrder.on) {
        return @true;
    }
    return @false;
}

#pragma mark - Observer act when recieving changed data
- (void)textFieldValueChanged: (UITextField *)sender
{
    if (sender == self.titleCell.textFieldTitle) {
        if ([sender.text isEqualToString:@""] || sender.text == NULL) {
            self.titleCell.labelTitle.textColor = [UIColor redColor];
            [self.goodForDone setObject:@false forKey:kGoodForDoneTextFieldTitle];
        }else{
            self.titleCell.labelTitle.textColor = [UIColor blackColor];
            [self.goodForDone setObject:@true forKey:kGoodForDoneTextFieldTitle];
        }

    }else if (sender == self.passwordCell.textFieldPassword){
        if ( self.passwordCell.textFieldPassword.enabled && ([self.passwordCell.textFieldPassword.text isEqualToString:@""] || self.passwordCell.textFieldPassword.text == NULL)) {
            self.passwordCell.labelPassword.textColor = [UIColor redColor];
            [self.goodForDone setObject:@false forKey:kGoodForDoneTextFieldPassword];
        }
        if( self.passwordCell.textFieldPassword.enabled && ![self.passwordCell.textFieldPassword.text isEqualToString:@""]){
            self.passwordCell.labelPassword.textColor = [UIColor blackColor];
            [self.goodForDone setObject:@true forKey:kGoodForDoneTextFieldPassword];
        }
    }
}

@end
