//
//  AppDelegate.h
//  SkategameForAll
//
//  Created by Kabkee Moon on 2014. 1. 4..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property NSMutableDictionary * RawDataForGameListFromServer;

// Only for Test, For production please delete all the below;
@property BOOL onlineOn;

- (void)addData:(NSDictionary *)data;
- (void)updateData:(NSDictionary *)data;
- (void)removeData:(NSString *)key;



@end
