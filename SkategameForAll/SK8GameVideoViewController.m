//
//  SK8GameVideoViewController.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 2. 15..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SK8GameVideoViewController.h"

@interface SK8GameVideoViewController ()
@property NSArray * videoObject;
@end

@implementation SK8GameVideoViewController
@synthesize roomDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    /*
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
     */
    self.videoObject = [self.roomDetails objectForKey:@"videos"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}



@end
