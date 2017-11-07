//
//  Constants.h
//  PhilipAssignment
//
//  Created by Amrendra on 13/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import "Utitlity.h"

#define BASE_URL @"https://api.github.com"
#define REPOSITORIES_URL @"/legacy/repos/search/Go?language=%@"
//#define REPOSITORIES_URL @"/search/repositories?q=language:%@"
#define ISSUES_URL @"/repos/%@/%@/issues"
#define SINGLE_ISSUE_URL @"/repos/%@/%@/issues/%@"
#define CONTRIBUTORS_URL @"/repos/%@/%@/contributors"






//Below both request sending with limit number like 100 or 30
//#define REPOSITORIES_URL @"/search/repositories?q=language:%@&per_page=100"  //per page
//https://api.github.com/legacy/repos/search/Go?language=Objective-C
//https://api.github.com/search/repositories?q=language:Objective-C
