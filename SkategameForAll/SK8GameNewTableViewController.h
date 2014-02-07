//
//  SK8GameNewTableViewController.h
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 29..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SK8GameNewTableViewControllerDelegate <NSObject>
@required
- (void)didDismissedModalView;
@end

@interface SK8GameNewTableViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) id <SK8GameNewTableViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *barBtnLeftCancel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barBtnRightDone;

- (IBAction)ClickedBarBtnLeftCancel:(id)sender;
- (IBAction)ClickedBarBtnRightDone:(id)sender;

@end



