//
//  SK8GameNewTableViewController.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 29..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SK8GameNewTableViewController.h"
#import "SK8GameNewTitleCell.h"
#import "SK8GameNewPasswordCell.h"
#import "SK8GameNewStartDateCell.h"

@interface SK8GameNewTableViewController ()
@property (strong, nonatomic) SK8GameNewStartDateCell * startDateCell;
@property (strong, nonatomic) NSDate * tempSavedDateTime;
@property (strong, nonatomic) NSArray * cellArray;
@property BOOL startDateCellHidden;


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
    
    self.cellArray = [[NSArray alloc]initWithObjects:@"titleCell", @"passwordCell", @"startAtCell", nil];
    
    
    if (!self.startDateCell) {
        self.startDateCell = [[SK8GameNewStartDateCell alloc] init];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    if (indexPath.row == 0) {
        NSString *CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; //@"titleCell"
        SK8GameNewTitleCell * titleCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (titleCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: @"SK8GameNewTitleCell" owner:self options:nil];
            titleCell = [nib objectAtIndex:0];
        }
        titleCell.textFieldTitle.delegate = self;
        
        return titleCell;
    }
    if (indexPath.row == 1) {
        NSString *CellIdentifier = [self.cellArray objectAtIndex:indexPath.row]; //@"passwordCell";
        SK8GameNewPasswordCell * passwordCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (passwordCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: @"SK8GameNewPasswordCell" owner:self options:nil];
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
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed: @"SK8GameNewStartDateCell" owner:self options:nil];
            startDateCell = [nib objectAtIndex:0];
        }
        
        // minimum && maximum dateTime - class init doesn't work at all
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
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
    if (indexPath.row == 0 || indexPath.row ==1) {
        return 44;
    }else if (indexPath.row ==2){
        if (self.startDateCellHidden) {
            return 206;
        }else{
            return  44;
        }
    }
    // Default height of cells
    return  44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        SK8GameNewStartDateCell * startDateCell = (SK8GameNewStartDateCell *)[tableView cellForRowAtIndexPath:indexPath];
        startDateCell.selected = NO;
        if (self.startDateCellHidden) {
            self.startDateCellHidden = NO;
        }else{
            self.startDateCellHidden = YES;
        }
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}

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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)ClickedBarBtnLeftCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)ClickedBarBtnRightDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
