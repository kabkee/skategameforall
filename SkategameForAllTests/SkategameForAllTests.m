//
//  SkategameForAllTests.m
//  SkategameForAllTests
//
//  Created by Kabkee Moon on 2014. 1. 4..
//  Copyright (c) 2014년 Kabkee Moon. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SkategameForAllTests : XCTestCase
@property NSString * jsonString;

@end

@implementation SkategameForAllTests


- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    NSError * error;
    NSDictionary *jsonInfo = @{@"room1":
                                   @{
                                     //roomDetail
                                     @"createDate": @"2014-01-13", //dateTime
                                     @"status": @"playing", // [ready, playing, paused, ended]
                                     @"name": @"Kabkee's room1", //string
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
                                     @"statusOfOrAtt":@YES, //booean Att=YES, Def=NO
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
                                       @"status": @"playing", // [ready, playing, paused, ended]
                                       @"name": @"Kabkee's room2", //string
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
                                       @"statusOfOrAtt":@YES, //booean Att=YES, Def=NO
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
                               };
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonInfo options:NSJSONWritingPrettyPrinted error: &error];
    
    if (error) {
        NSLog(@"Error : @%@", [error description]);
    }else{
        self.jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testJsonSerializationToString
{
    //    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    NSLog(@"Json : %@", self.jsonString);
    
    NSData *jsonData = [self.jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error;
    NSDictionary *jsonInfo = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    XCTAssert([[[jsonInfo valueForKey:@"room1"] valueForKey:@"status"] isEqualToString: @"playing"], @"not equal");
    
    NSLog(@" Room1's Status : %@", [[jsonInfo valueForKey:@"room1"] valueForKey:@"status"]);
    
}

- (void)testJsonSerializationToArry
{
    //    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    NSLog(@"Json : %@", self.jsonString);
    
//    NSData *jsonData = [self.jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSError * error;
    
//    NSArray * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    //    XCTAssert([parsedData[0][0] isEqualToString: @"playing"], @"not equal");
    
//    NSLog(@" Room1's Status : %@", parsedData[0]);
    
}

@end
