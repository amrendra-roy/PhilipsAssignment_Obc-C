//
//  RepositoryDM.h
//  PhilipAssignment
//
//  Created by Amrendra on 13/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 class: IssuesDM
 detail: A class that is contain the Issues details
 */
#pragma mark- Data Model for Issues GIT API
@interface IssuesDM : NSObject


@property(nonatomic, strong) NSString *issueNumber;
@property(nonatomic, strong) NSString *issueTitle;
@property(nonatomic, strong) NSString *issueState;

- (instancetype)initWithIssuesDictionary:(NSDictionary*)dict;

@end


/*
 class: ContributorsDM
 detail: A class that is contain the Contributor details
 */
#pragma mark- Data Model for Contributors GIT API
@interface ContributorsDM : NSObject

@property(nonatomic, strong) NSString *contributerName;
@property(nonatomic, strong) NSNumber *contributionNumber;

- (instancetype)initWithConributorDictionary:(NSDictionary*)dict;
@end

/*
 class: RepositoryDM
 detail: A model which contains the all data regarding repository like name, owner, description, issues list, contributor list.
 */
#pragma mark- Data Model for Repository GIT API
@interface RepositoryDM : NSObject


- (instancetype)initWithRepoistoryDictionary:(NSDictionary*)dict;

@property(nonatomic, strong) NSString *userName;
@property(nonatomic, strong) NSString *ownerName;
@property(nonatomic, strong) NSString *repoDescription;
@property(nonatomic, strong) NSNumber *numberOfIssues;
@property(nonatomic, strong) NSMutableArray *issuesList;//Will contain IssuesDM modes array
@property(nonatomic, strong) NSMutableArray *contributorsList;//Will contain ContributorsDM modes array
@end
