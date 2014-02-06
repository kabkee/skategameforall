//
//  AppDelegate.m
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 4..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize gameRoomList;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    // if Online Mode = YES, if NOT = NO;
    self.onlineOn = NO;
    
    if(!gameRoomList){
        gameRoomList = [[NSMutableDictionary alloc]init];
        NSDictionary *jsonInfo = @{@"room1":
                                       @{
                                           //roomDetail
                                           @"createDate": @"2014-01-13", //dateTime
                                           @"status": @"Playing", // [Ready, Playing, Paused, Ended]
                                           @"title": @"Kabkee's room1", //string
                                           @"gameStartTime": @"2014-01-15", //dateTime
                                           @"maxPpl":@5, // max 5 ppl
                                           @"players":@[@"kabkee",@"Gomsun2", @"Minsu"], //array // attOrder
                                           @"watchers":@[@"kabkeeWC",@"Gomsun2WC", @"MinsuWC", @"SuminWC", @"DanbeeWC", @"HyojuWC"], // array
                                           @"clikingNo":@100, // int
                                           @"starred":@[@"kabkeeST",@"Gomsun2ST", @"MinsuST", @"SuminST", @"DanbeeST", @"HyojuST"], // array
                                           @"attLimitDay":@7, // int Days
                                           @"defLimitDay":@7, // int Days
                                           @"orderAttAutomate":@NO, //boolean
                                           //gameDetail
                                           @"statusOfAtt":@YES, //booean Att=YES, Def=NO
                                           @"attacker":@"kabkee",
                                           @"defender":@[@"Gomsun2"], // who uploaded def video
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
                                           @"scores":@{@"kabkee": @2,
                                                       @"Gomsun2": @3,
                                                       @"Minsu": @5} // S(1), K(2), A(3), T(4), E(5)= over
                                           },
                                   @"room2":
                                       @{
                                           //roomDetail
                                           @"createDate": @"2014-01-20", //dateTime
                                           @"status": @"Paused", // [Ready, Playing, Paused, Ended]
                                           @"title": @"Gomsun2's room2", //string
                                           @"gameStartTime": @"2014-01-21", //dateTime
                                           @"maxPpl":@3, // max 5 ppl
                                           @"players":@[@"kabkee",@"Gomsun2"], //array // attOrder
                                           @"watchers":@[@"DanbeeWC2", @"HyojuWC2"], // array
                                           @"clikingNo":@100, // int
                                           @"starred":@[@"SuminST2", @"DanbeeST2", @"HyojuST2"], // array
                                           @"attLimitDay":@7, // int Days
                                           @"defLimitDay":@7, // int Days
                                           @"orderAttAutomate":@NO, //boolean
                                           //gameDetail
                                           @"statusOfAtt":@YES, //booean Att=YES, Def=NO
                                           @"attacker":@"kabkee",
                                           @"defender":@[@"Gomsun2"], // who uploaded def video
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
                                           @"scores":@{@"kabkee": @4,
                                                       @"Gomsun2": @4} // S(1), K(2), A(3), T(4), E(5)= over
                                           },
                                   @"room3":
                                       @{
                                           //roomDetail
                                           @"createDate": @"2014-01-31", //dateTime
                                           @"status": @"Ready", // [Ready, Playing, Paused, Ended]
                                           @"title": @"NoOne's room2", //string
                                           @"gameStartTime": @"2014-02-21", //dateTime
                                           @"maxPpl":@5, // max 5 ppl
                                           @"players":@[@"kabkee",@"Gomsun2"], //array // attOrder
                                           @"watchers":@[@"DanbeeWC2", @"HyojuWC2"], // array
                                           @"clikingNo":@100, // int
                                           @"starred":@[@"SuminST2", @"DanbeeST2", @"HyojuST2"], // array
                                           @"attLimitDay":@7, // int Days
                                           @"defLimitDay":@7, // int Days
                                           @"orderAttAutomate":@NO, //boolean
                                           //gameDetail
                                           @"statusOfAtt":@YES, //booean Att=YES, Def=NO
                                           @"attacker":@"kabkee",
                                           @"defender":@[@"Gomsun2"], // who uploaded def video
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
                                           @"scores":@{@"kabkee": @4,
                                                       @"Gomsun2": @4} // S(1), K(2), A(3), T(4), E(5)= over
                                           }
                                   };
        

        NSData * jsonData;
        NSError * error;
        
        if (self.onlineOn != NO) {
            NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:5000/getRoom"]];
            jsonData = [NSData dataWithContentsOfURL:url];
            if (!jsonData) {
                // Just for insurance
                [gameRoomList setObject:@"" forKey:@""];
                return YES;
            }
        }else{
         
            jsonData = [NSJSONSerialization dataWithJSONObject:jsonInfo options:NSJSONWritingPrettyPrinted error: &error];
            if (error) {
                NSLog(@"Error : @%@", [error description]);
            }else{
                // Nothing to do
            }
        }
        [gameRoomList setDictionary:[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error]];
//        gameRoomList= [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
    }
    return YES;
}

- (void)addData:(NSDictionary *)data
{
    [gameRoomList setObject:data[@"value"] forKey:data[@"key"]];
}

- (void)updateData:(NSDictionary *)data
{
    [gameRoomList setValue:data[@"value"] forKey:data[@"key"]];
}
- (void)removeData:(NSString *)key
{
    [gameRoomList removeObjectForKey:key];
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
