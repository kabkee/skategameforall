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
                                   @{@"name": @"Kabkee's room1",
                                     @"status": @"playing",
                                     @"createDate": @"2014-01-13"},
                               @"room2":
                                   @{@"name": @"Kabkee's room2",
                                     @"status": @"poused",
                                     @"createDate": @"2014-01-23"}};
    
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
    
    NSData *jsonData = [self.jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * error;
    
    NSArray * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    //    XCTAssert([parsedData[0][0] isEqualToString: @"playing"], @"not equal");
    
//    NSLog(@" Room1's Status : %@", parsedData[0]);
    
}

@end
