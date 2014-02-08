//
//  LoginViewController.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 2. 8..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "LoginViewController.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTMOAuth2SignIn.h"

static NSString *const kKeyChainItemName           = @"SkateGameForAll";
static NSString *const kGoogleClientIDKey          = @"GoogleClientID";
static NSString *const kGoogleClientSecretKey      = @"GoogleClientSecret";
static NSString *const GoogleClientID = @"433777687178.apps.googleusercontent.com";
static NSString *const GoogleClientSecret = @"ZdlMSq6ZWY1GgQDvFnJpnHwN";
static NSString *const kGoogleUserData = @"GoogleUserData";

@interface LoginViewController ()

@end

@implementation LoginViewController

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
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginToGoogle:(id)sender {
    [self signOut];
    
    NSString *scope = @"https://www.googleapis.com/auth/plus.me";
    
    // Display the autentication view.
    SEL finishedSel = @selector(viewController:finishedWithAuth:error:);
    
    GTMOAuth2ViewControllerTouch *viewController;
    viewController = [GTMOAuth2ViewControllerTouch controllerWithScope:scope
                                                              clientID:GoogleClientID
                                                          clientSecret:GoogleClientSecret
                                                      keychainItemName:kKeyChainItemName
                                                              delegate:self
                                                      finishedSelector:finishedSel];

    // using BCP 47 language codes, display language
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"ko"
                                                       forKey:@"hl"];
    viewController.signIn.additionalAuthorizationParameters = params;
    
    // Optional: display some html briefly before the sign-in page loads
    NSString *html = @"<html><body bgcolor=silver><div align=center>Loading sign-in page...</div></body></html>";
    viewController.initialHTMLString = html;

//    [self dismissViewControllerAnimated:NO completion:^{
//        [[self navigationController] pushViewController:viewController animated:YES];
//    }];
    [[self navigationController] pushViewController:viewController animated:YES];
}


- (void)signOut
{
    // remove the token from Google's servers
    [GTMOAuth2ViewControllerTouch revokeTokenForGoogleAuthentication:self.auth];
    
    // remove the stored Google authentication from the keychain, if any
    [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:kKeyChainItemName];
    
    // Discard our retained authentication object.
    self.auth = nil;
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)auth
                 error:(NSError *)error {
    if (error != nil) {
        // Authentication failed (perhaps the user denied access, or closed the
        // window before granting access)
        NSLog(@"Authentication error: %@", error);
        NSData *responseData = [[error userInfo] objectForKey:@"data"]; // kGTMHTTPFetcherStatusDataKey
        if ([responseData length] > 0) {
            // show the body of the server's authentication failure response
            NSString *str = [[NSString alloc] initWithData:responseData
                                                   encoding:NSUTF8StringEncoding];
            NSLog(@"%@", str);
        }
        self.auth = nil;
    } else {
        // save the authentication object
        self.auth = auth;
        NSLog(@"%@", @"login Success");
        [self checkIfCanAuthWithUserDefaults];
        [[self navigationController] setNavigationBarHidden:NO];
        [[self navigationController] popViewControllerAnimated:YES];
    }
}


#pragma mark - checkIfCanAuthWithUserDefaults
- (void)checkIfCanAuthWithUserDefaults
{
    NSUserDefaults * skategameForAllDefaults = [NSUserDefaults standardUserDefaults];
    [skategameForAllDefaults setObject:GoogleClientID forKey: kGoogleClientIDKey];
    [skategameForAllDefaults setObject:GoogleClientSecret forKey: kGoogleClientSecretKey];
    
    GTMOAuth2Authentication * auth = nil;
    auth = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeyChainItemName clientID:kGoogleClientIDKey clientSecret:kGoogleClientSecretKey];
    if (auth.canAuthorize) {
        self.canAutholize = YES;
        [skategameForAllDefaults setObject:auth.parameters forKey:kGoogleUserData];
    }else{
        self.canAutholize = NO;
        [skategameForAllDefaults removeObjectForKey:kGoogleUserData];
    }
}

@end
