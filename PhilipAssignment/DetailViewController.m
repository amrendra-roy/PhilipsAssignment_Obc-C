//
//  DetailViewController.m
//  PhilipAssignment
//
//  Created by Amrendra on 14/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import "DetailViewController.h"
#import "GitServiceManager.h"
#include "Constants.h"
#import "BasicInfoTableCell.h"
#import "TableHeaderView.h"
#import "IssuesTableCell.h"
#import "ContributorsTableCell.h"

enum SectionType {
    BasicInfoType = 0,
    IssueInfoType,
    ContributorType
};

static NSString * const kBasicInfoCellIdentifier = @"basicInfoTableCell";
static NSString * const kIssueInfoCellIdentifier = @"issuesTableCell";
static NSString * const kContributorCellIdentifier = @"contributorsTableCell";


@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    __weak IBOutlet UITableView *tblView;
    
}
@end

@implementation DetailViewController
@synthesize repoModel;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"detail_scren_title", nil);
    
    tblView.rowHeight = UITableViewAutomaticDimension;
    tblView.estimatedRowHeight = 60;
    
    //Get Issue list and Contributor detail form GIT
    if ([Utitlity isNetworkReachable])
    {
        if (!self.repoModel.issuesList.count) {
            [self fetchIssuesListWithTestHandler:nil];
        }
        if (!self.repoModel.contributorsList.count) {
            [self fetchContributorsListWithTestHandler:nil];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc
{
    self.repoModel = nil;
}
#pragma mark - Methods
/*
 @func: - (void)fetchIssuesListWithTestHandler:(void(^)(NSData *data, NSError *error))testHandler
 @detail: Function that prepare url for Git Issues. And make a web service call for getting Issue list and send call back on completion of web service.
 @input type: A completion handler for getting call back. This is use full for Test Case only. So we don’t need to write duplication code in Unit Test class.
 */
- (void)fetchIssuesListWithTestHandler:(void(^)(NSData *data, NSError *error))testHandler {
    
    NSString *str = [NSString stringWithFormat:ISSUES_URL,self.repoModel.ownerName, self.repoModel.userName];
    NSString *strURL = [BASE_URL stringByAppendingString:str];
    __weak DetailViewController *weakSelf = self;

    [[GitServiceManager sharedInstance] startDownloadWithURL:strURL completionHandler:^(NSData *data, NSError *error) {
       
        if (testHandler) {
            testHandler(data, error);
        }
        else{
            if (!error) {
                id respons = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if ([respons isKindOfClass:[NSArray class]]) {
                    respons = (NSArray*)respons;
                    [weakSelf parseIssuesListFrom:respons];
                }else {
                    //Do as per requriement
                }
                NSLog(@"fetchIssuesList Repository Results = %@",respons);
            }else{
                NSLog(@"fetchIssuesList Issue list API fail");
            }
        }
    }];
}

/*
 @func: - (void)fetchContributorsListWithTestHandler:(void(^)(NSData *data, NSError *error))testHandler
 @detail: Function that prepare url for Git Contributor. And make a web service call for getting Contributor details and send call back on completion of web service.
 @input type: A completion handler for getting call back. This is use full for Test Case only. So we don’t need to write duplication code in Unit Test class.
 */
- (void)fetchContributorsListWithTestHandler:(void(^)(NSData *data, NSError *error))testHandler {
    NSString *str = [NSString stringWithFormat:CONTRIBUTORS_URL,self.repoModel.ownerName, self.repoModel.userName];
    NSString *strURL = [BASE_URL stringByAppendingString:str];
    __weak DetailViewController *weakSelf = self;
    [[GitServiceManager sharedInstance] startDownloadWithURL:strURL completionHandler:^(NSData *data, NSError *error) {
        if (testHandler) {
            testHandler(data, error);
        }else{
            if (!error) {
                id respons = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if ([respons isKindOfClass:[NSArray class]]) {
                    respons = (NSArray*)respons;
                    [weakSelf parseContributorsListFrom:respons];
                }else {
                    //Do as per requriement
                }
                NSLog(@"fetchContributorsList Results = %@",respons);
            }else{
                NSLog(@"fetchContributorsList contributor list API fail");
            }
        }
    }];
}
/*
 @func: - (void)parseIssuesListFrom:(NSArray*)arr
 @detail: Function that perform parsing issues data in models and reload the issues table section.
 @input type: An Array of issues
 */

- (void)parseIssuesListFrom:(NSArray*)arr
{
    NSMutableArray *issueArr = [[NSMutableArray alloc] initWithCapacity:arr.count];
    NSInteger count = (arr.count >3) ? 3 : arr.count; //take only top 3 array
    for (int i = 0; i < count; i++) {
        NSDictionary *dict = [arr objectAtIndex:i];
        IssuesDM *issue = [[IssuesDM alloc] initWithIssuesDictionary:dict];
        [issueArr addObject:issue];
        issue = nil;
    }
    self.repoModel.issuesList = issueArr;//It will update main Repository issuesList array property
    issueArr = nil;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [tblView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    });
}
/*
 @func: - (void)parseContributorsListFrom:(NSArray*)arr
 @detail: Function that perform parsing contributors data in models and reload the contributor table section.
 @input type: An Array of conributors
 */
- (void)parseContributorsListFrom:(NSArray*)arr
{
    NSMutableArray *contributeArr = [[NSMutableArray alloc] initWithCapacity:arr.count];
    NSInteger count = (arr.count >3) ? 3 : arr.count; //take only top 3 array
    for(int i = 0; i < count; i++)
    {
        NSDictionary *dict = [arr objectAtIndex:i];
        ContributorsDM *contri = [[ContributorsDM alloc] initWithConributorDictionary:dict];
        [contributeArr addObject:contri];
        contri = nil;
    }
    self.repoModel.contributorsList = contributeArr;//It will update main Repository contributorsList array property
    contributeArr = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        [tblView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    });
}
/*
 @func: - (void)dataStatusFor:(NSArray*)arr onView:(TableHeaderView*)view
 @detail: A function that is decide the error message on issues, contribution section. If web service is fail it will show the error message based on upon response.
 @input type: Table header view section
 */
- (void)dataStatusFor:(NSArray*)arr onView:(TableHeaderView*)view {
    if (!arr) {//Network is not stated yet
        [view.activityIndicator startAnimating];
    }else if(arr.count == 0) {//Network call has done but no data vailable
        [view.activityIndicator stopAnimating];
        view.errorMessageLbl.text = NSLocalizedString(@"no_data_available", nil);
        view.errorMessageLbl.hidden = NO;
    }else{//Network call has done
        [view.activityIndicator stopAnimating];
    }
    
}
#pragma mark - UITableView delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [Utitlity isNetworkReachable] ? 3 : 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRow = 0;
    switch (section) {
        case BasicInfoType:
        {
            numberOfRow = 1;
        }
            break;
        case IssueInfoType:
        {
            numberOfRow = (self.repoModel.issuesList.count) ? self.repoModel.issuesList.count : 0 ;
        }
            break;
        case ContributorType:
        {
            numberOfRow = (self.repoModel.contributorsList.count) ? self.repoModel.contributorsList.count : 0 ;

        }
            break;
    }
    return numberOfRow;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case BasicInfoType:
        {
            BasicInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kBasicInfoCellIdentifier forIndexPath:indexPath];
            [cell updateBasicCellWith:self.repoModel];
            return cell;
        }
            break;
        case IssueInfoType:
        {
            IssuesTableCell *cell = (IssuesTableCell*)[tableView dequeueReusableCellWithIdentifier:kIssueInfoCellIdentifier forIndexPath:indexPath];
            IssuesDM *model = [self.repoModel.issuesList objectAtIndex:indexPath.row];
            [cell updateIssuesCellWith:model];
            return cell;
        }
            break;
        case ContributorType:
        {
            ContributorsTableCell *cell = (ContributorsTableCell*) [tableView dequeueReusableCellWithIdentifier:kContributorCellIdentifier forIndexPath:indexPath];
            ContributorsDM *model = [self.repoModel.contributorsList objectAtIndex:indexPath.row];
            [cell updateContributorCellWith:model];
            
            return cell;
        }
            break;
    }
    return [[UITableViewCell alloc] init];
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    @autoreleasepool {
        TableHeaderView *view = (TableHeaderView*)[[NSBundle mainBundle] loadNibNamed:@"TableHeaderView" owner:self options:nil][0];
        view.errorMessageLbl.text = nil;
        view.errorMessageLbl.hidden = YES;
        switch (section) {
            case BasicInfoType:
            {
                [view.activityIndicator stopAnimating];
                [view updateSectionHeader:NSLocalizedString(@"basic_info_header_title", nil)];
            }
                break;
            case IssueInfoType:
            {
                [self dataStatusFor:self.repoModel.issuesList onView:view];
                [view updateSectionHeader:NSLocalizedString(@"issues_cell_header_title", nil)];
            }
                break;
            case ContributorType:
            {
                [self dataStatusFor:self.repoModel.contributorsList onView:view];
                [view updateSectionHeader:NSLocalizedString(@"contributor_cell_header_title", nil)];
            }
                break;
        }
        return view;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
@end
