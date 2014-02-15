//
//  SideBarSocialPictureViewController.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 2. 16..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "SideBarSocialPictureViewController.h"

@interface SideBarSocialPictureViewController ()

@end

@implementation SideBarSocialPictureViewController
@synthesize imgViewForSocialPicture;

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
    
    self.imgViewForSocialPicture.image = self.socialPicture;

    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeThisViewController)];
    tapGesture.numberOfTapsRequired = 1;
    [self.imgViewForSocialPicture setUserInteractionEnabled:YES];
    [self.imgViewForSocialPicture addGestureRecognizer:tapGesture];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)closeThisViewController
{
    [self dismissViewControllerAnimated:NO completion:Nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
