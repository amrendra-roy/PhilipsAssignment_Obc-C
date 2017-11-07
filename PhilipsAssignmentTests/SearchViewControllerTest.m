//
//  SearchViewControllerTest.m
//  PhilipAssignment
//
//  Created by Amrendra on 15/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ViewController.h"

#pragma mark - Create private Category of ViewController to define private methods for Unit Test only
@interface ViewController(Test)
{
    
}
- (void)fetchRepositoriesFromGitForLanguage:(NSString*)language
                      testCompletionHandler:(void(^)(NSData *data, NSError *error))testHandler;
@end




@interface SearchViewControllerTest : XCTestCase
@property(nonatomic, strong) ViewController *viewController;

@end

@implementation SearchViewControllerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewController = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.viewController = nil;

    [super tearDown];
}

#pragma mark - Testing with live data
//Test for performance.
- (void)testRepositoryGitPerformance {
    [self measureBlock:^{
        [self.viewController fetchRepositoriesFromGitForLanguage:@"Objective-C" testCompletionHandler:^(NSData *data, NSError *error) {
            
            XCTAssertNotNil(data, @"Getting repository Git API is Fail");
            id respons = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

            NSLog(@"data is testRepositoryGitPerformance = %@",respons);
            NSLog(@"Error in testRepositoryGitPerformance = %@",error);
        }];
    }];
}
//Test for Asynchronous based on your expectaion
- (void)testRepositoryGitAPIExpectation
{
    __weak SearchViewControllerTest *weakSelf = self;
    XCTestExpectation* expectation = [self expectationWithDescription:@"Repository request"];
    [self.viewController fetchRepositoriesFromGitForLanguage:@"Objective-C" testCompletionHandler:^(NSData *data, NSError *error) {
       
        //If Data is Nil, than fail
        XCTAssertNotNil(data, @"Getting repository Git API is Fail");
        
        id respons = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        respons = (NSDictionary*)respons;
        NSArray *arResults = [respons objectForKey:@"repositories"];
        [weakSelf dataValidationOfSearchAPI:arResults];//Data validate
        
        NSLog(@"data is testRepositoryGitDataResponse = %@",respons);
        NSLog(@"Error in testRepositoryGitDataResponse = %@",error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];/////To Fail/Success change its time value
}

#pragma mark- Helper method to test Data is valid or not
/*
 @func: - (void)dataValidationOfSearchAPI:(NSArray*)results
 @detail: Function that validate the server data, what we are getting from server it should be proper, means all mandatory property should be available.
 @input type: An array of response
 */
- (void)dataValidationOfSearchAPI:(NSArray*)results {
    
    XCTAssertTrue(results.count, @"Search API has zero response");
    
    //Parsing data validation for repositories data
    for (NSMutableDictionary *dict in results) {

        ////Validate only mandatory data
        XCTAssertNotNil([dict objectForKey:@"name"], @"name property is not available for = %@",dict);
        XCTAssertNotNil([dict objectForKey:@"owner"], @"owner property is not available for = %@",dict);
    }
}
@end
