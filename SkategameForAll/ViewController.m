//
//  ViewController.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 4..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"

@interface ViewController ()
@property UIImage * Image_BlockMenuBarButton;
@property UIButton * Btn_ForCustomBarButtonItem;

@end

@implementation ViewController
@synthesize Image_BlockMenuBarButton, barButtonItemToShowSideBarView, Btn_ForCustomBarButtonItem;


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self readyForSideBarViewTrigger];
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [loginVC checkIfCanAuthWithUserDefaults];
    if (![loginVC canAutholize]) {
        [self performSegueWithIdentifier:@"loginViewSegueModal" sender:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - readyForSideBarViewTrigger
- (void)readyForSideBarViewTrigger
{
    // Image for Custom barButtonItem
    Image_BlockMenuBarButton = [UIImage imageNamed:@"block-menu.png"];
    
    // Set a button for Custom barButtonItem
    Btn_ForCustomBarButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn_ForCustomBarButtonItem setBackgroundImage:Image_BlockMenuBarButton forState:UIControlStateNormal];
    Btn_ForCustomBarButtonItem.frame = CGRectMake(0, 0, Image_BlockMenuBarButton.size.width, Image_BlockMenuBarButton.size.height);
    [Btn_ForCustomBarButtonItem addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    barButtonItemToShowSideBarView = [[UIBarButtonItem alloc] initWithCustomView:Btn_ForCustomBarButtonItem];
    
    self.navigationItem.leftBarButtonItem = barButtonItemToShowSideBarView;
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}




@end
