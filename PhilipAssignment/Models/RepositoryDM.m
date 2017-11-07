//
//  RepositoryDM.m
//  PhilipAssignment
//
//  Created by Amrendra on 13/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import "RepositoryDM.h"

#pragma mark- Data Model for Issues GIT API
static NSString * const kNumber = @"number";
static NSString * const kTitle = @"title";
static NSString * const kState = @"state";

@implementation IssuesDM

@synthesize issueNumber;
@synthesize issueTitle;
@synthesize issueState;

- (instancetype)initWithIssuesDictionary:(NSDictionary*)dict {
    self = [super init];
    
    self.issueNumber = [dict objectForKey:kNumber];
    self.issueTitle = [dict objectForKey:kTitle];
    self.issueState = [dict objectForKey:kState];
    
    return self;
}
@end

#pragma mark- Data Model for Contributors GIT API
static NSString * const kUserName = @"login";
static NSString * const kContributNumber = @"contributions";


@implementation ContributorsDM
@synthesize contributerName;
@synthesize contributionNumber;

- (instancetype)initWithConributorDictionary:(NSDictionary*)dict {
    self = [super init];
    
    self.contributerName = [dict objectForKey:kUserName];
    NSNumber *number = [dict objectForKey:kContributNumber];
    self.contributionNumber = number;

    return self;
}

@end



#pragma mark- Data Model for Repository GIT API
static NSString * const kName = @"name";
static NSString * const kDescription = @"description";
static NSString * const kNumberOfIssues = @"open_issues";
static NSString * const kOwnerName = @"owner";

@implementation RepositoryDM

@synthesize userName;
@synthesize repoDescription;
@synthesize numberOfIssues;
@synthesize ownerName;
@synthesize issuesList;
@synthesize  contributorsList;

- (instancetype)initWithRepoistoryDictionary:(NSDictionary*)dict
{
    self = [super init];
    
    self.userName = [dict objectForKey:kName];
    self.repoDescription = [dict objectForKey:kDescription];
    self.ownerName = [dict objectForKey:kOwnerName];
    NSNumber *issues = [dict objectForKey:kNumberOfIssues];
    self.numberOfIssues = issues;
    
    return self;
}
@end
