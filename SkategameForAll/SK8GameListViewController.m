//
//  SK8GameListViewController.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 5..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SK8GameListViewController.h"
#import "SWRevealViewController.h"

@interface SK8GameListViewController ()
@property UIImage * Image_BlockMenuBarButton;
@property UIButton * Btn_ForCustomBarButtonItem;

@end

@implementation SK8GameListViewController
@synthesize  Image_BlockMenuBarButton, Btn_ForCustomBarButtonItem;

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
    
    // Image for Custom barButtonItem
    Image_BlockMenuBarButton = [UIImage imageNamed:@"block-menu.png"];
    
    // Set a button for Custom barButtonItem
    Btn_ForCustomBarButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn_ForCustomBarButtonItem setBackgroundImage:Image_BlockMenuBarButton forState:UIControlStateNormal];
    Btn_ForCustomBarButtonItem.frame = CGRectMake(0, 0, Image_BlockMenuBarButton.size.width, Image_BlockMenuBarButton.size.height);
    [Btn_ForCustomBarButtonItem addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barButtonItemToShowSideBarView = [[UIBarButtonItem alloc] initWithCustomView:Btn_ForCustomBarButtonItem];
    
    self.navigationItem.leftBarButtonItem = barButtonItemToShowSideBarView;
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
