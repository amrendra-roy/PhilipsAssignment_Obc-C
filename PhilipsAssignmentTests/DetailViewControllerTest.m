//
//  DetailViewControllerTest.m
//  PhilipAssignment
//
//  Created by Amrendra on 15/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DetailViewController.h"
#import "RepositoryDM.h"

@interface DetailViewController(Test) {
    
}
- (void)fetchIssuesListWithTestHandler:(void(^)(NSData *data, NSError *error))testHandler;
- (void)fetchContributorsListWithTestHandler:(void(^)(NSData *data, NSError *error))testHandler;
@end


@interface DetailViewControllerTest : XCTestCase
@property(nonatomic, strong) DetailViewController *detailVC;
@end

@implementation DetailViewControllerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.detailVC = [[DetailViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.detailVC = nil;
}
#pragma mark - Testing with live data
- (void)testIsseuListGitPerformance {
    
    [self configurRequiredDataModelForRequest];
    
    [self measureBlock:^{
        [self.detailVC fetchIssuesListWithTestHandler:^(NSData *data, NSError *error) {
            
            XCTAssertNotNil(data, @"Issue Git API is Fail for owner = istornz; name = iPokeGo");
            id respons = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            NSLog(@"data is testIsseuListGitPerformance = %@",respons);
            NSLog(@"Error in testIsseuListGitPerformance = %@",error);
            
        }];
        
    }];
}
- (void)testIssueListGitExpectation {
    [self configurRequiredDataModelForRequest];

    XCTestExpectation *expectation = [self expectationWithDescription:@"Issue Request"];
    [self.detailVC fetchIssuesListWithTestHandler:^(NSData *data, NSError *error) {
        
        //If Data is Nil, than fail
        XCTAssertNotNil(data, @"Getting Issue Git API is Fail");
        id respons = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSLog(@"data is testIssueListGitExpectation = %@",respons);
        NSLog(@"Error in testIssueListGitExpectation = %@",error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10.0 handler:nil];///To Fail/Success change the time value
}

#pragma mark - Off-line testing
//We have perform testing with live data. But for contributions and Contributor list will use .json file which is already in available in main bundle.
- (void)testContributorDataPass {
    
    NSData *data = [self getDataFromFile:@"Contribution_Pass"];
    id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *arr = (NSArray*)result;
    for (NSDictionary *dict in arr) {
        ContributorsDM *model = [[ContributorsDM alloc] initWithConributorDictionary:dict];
        
        XCTAssertNotNil(model.contributerName, @"Contribution name is nil");
        XCTAssertGreaterThanOrEqual(model.contributionNumber, [NSNumber numberWithInt:1], @"Contributor number is less than Zero");
    }
}
- (void)testContributorDataFail {
    
    NSData *data = [self getDataFromFile:@"Contribution_Fail"];
    id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *arr = (NSArray*)result;
    for (NSDictionary *dict in arr) {
        ContributorsDM *model = [[ContributorsDM alloc] initWithConributorDictionary:dict];
        
        XCTAssertNotNil(model.contributerName, @"Contribution name is nil");
        XCTAssertGreaterThanOrEqual(model.contributionNumber, [NSNumber numberWithInt:1], @"Contributor number is less than Zero");
    }
}

#pragma mark - Helper method
/*
 @func: - (void)configurRequiredDataModelForRequest
 @detail: A function that is prepare all required data to make a web service.
 */
- (void)configurRequiredDataModelForRequest {
    NSDictionary *dict = @{@"owner":@"istornz", @"name":@"iPokeGo"};//owner = istornz; name = iPokeGo;
    RepositoryDM *model = [[RepositoryDM alloc] initWithRepoistoryDictionary:dict];
    self.detailVC.repoModel = model;
    model = nil;
}
/*
 @func: - (NSData*)getDataFromFile:(NSString*)fileName
 @detail: Get local file path Unit Test
 @input type: file name
 */
- (NSData*)getDataFromFile:(NSString*)fileName
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    return data;
}
@end
