//
//  SK8GameNewTableViewController.h
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 29..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SK8GameNewTableViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *barBtnLeftCancel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barBtnRightDone;

- (IBAction)ClickedBarBtnLeftCancel:(id)sender;
- (IBAction)ClickedBarBtnRightDone:(id)sender;


@end
