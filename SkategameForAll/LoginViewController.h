//
//  LoginViewController.h
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 2. 8..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTMOAuth2Authentication;

@interface LoginViewController : UIViewController

@property GTMOAuth2Authentication * auth;
@property BOOL canAutholize;

@property (strong, nonatomic) IBOutlet UIButton *btn_GoogleLogin;
@property (strong, nonatomic) IBOutlet UIButton *btn_FacebookLogin;
@property (strong, nonatomic) IBOutlet UIButton *btn_TwitterLogin;
@property (strong, nonatomic) IBOutlet UIButton *btn_Signin;
@property (strong, nonatomic) IBOutlet UIButton *btn_Login;

- (IBAction)loginToGoogle:(id)sender;

- (void)signOut;
- (void)checkIfCanAuthWithUserDefaults;
@end
