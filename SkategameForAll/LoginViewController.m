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
@property (strong, nonatomic) NSDictionary * userProfile;
@property (strong, nonatomic)  NSUserDefaults * skategameForAllDefaults;

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
    
    // activityIndicator
    [self.actvtIndicator stopAnimating];
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
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"en"
                                                       forKey:@"hl"];
    viewController.signIn.additionalAuthorizationParameters = params;
    viewController.signIn.shouldFetchGoogleUserProfile = YES;

    // Optional: display some html briefly before the sign-in page loads
    NSString *html = @"<html><body bgcolor=silver><div align=center>Loading sign-in page...</div></body></html>";
    viewController.initialHTMLString = html;

    [[self navigationController] pushViewController:viewController animated:YES];
    [self.actvtIndicator startAnimating];
}


- (void)signOut
{
    // remove the token from Google's servers
    [GTMOAuth2ViewControllerTouch revokeTokenForGoogleAuthentication:self.auth];
    
    // remove the stored Google authentication from the keychain, if any
    [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:kKeyChainItemName];
    
    // Discard our retained authentication object.
    self.auth = nil;
    
    self.skategameForAllDefaults = [NSUserDefaults standardUserDefaults];
    [self.skategameForAllDefaults removeObjectForKey:kGoogleUserData];
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
        [self signOut];
    } else {
        // save the authentication object
        self.auth = auth;
        NSLog(@"%@", @"login Success");

        NSDictionary *userProfile = viewController.signIn.userProfile;
        self.userProfile = userProfile;
        self.skategameForAllDefaults = [NSUserDefaults standardUserDefaults];
        [self.skategameForAllDefaults setObject:userProfile forKey:kGoogleUserData];

//        NSLog(@"before checking auth.parameters : %@", self.userProfile);
        [self checkIfCanAuthWithUserDefaults];
        
        [[self navigationController] setNavigationBarHidden:NO];
        [[self navigationController] popViewControllerAnimated:YES];
        [self.actvtIndicator stopAnimating];
        
//        NSLog(@"LoginView userProfile : %@", self.userProfile);
    }
}


#pragma mark - checkIfCanAuthWithUserDefaults
- (void)checkIfCanAuthWithUserDefaults
{
    self.skategameForAllDefaults = [NSUserDefaults standardUserDefaults];
    [self.skategameForAllDefaults setObject:GoogleClientID forKey: kGoogleClientIDKey];
    [self.skategameForAllDefaults setObject:GoogleClientSecret forKey: kGoogleClientSecretKey];
    
    GTMOAuth2Authentication * auth = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeyChainItemName clientID:kGoogleClientIDKey clientSecret:kGoogleClientSecretKey];

    NSDictionary * userProfile = [self.skategameForAllDefaults objectForKey:kGoogleUserData];
//    NSLog(@"LoginView checkif : %@", userProfile);

    if (!userProfile || !auth.canAuthorize) {
        [self.skategameForAllDefaults removeObjectForKey:kGoogleUserData];
        self.canAutholize = NO;
    }else{
        self.canAutholize = YES;
    }
//    NSLog(@"LoginView checkif after : %@", userProfile);
}

@end
