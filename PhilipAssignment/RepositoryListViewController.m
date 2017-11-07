//
//  RepositoryListViewController.m
//  PhilipAssignment
//
//  Created by Amrendra on 14/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import "RepositoryListViewController.h"
#import "RepositoryTableCell.h"
#import "RepositoryDM.h"
#import "DetailViewController.h"

static NSString * const kRepoCellIdentifier = @"repoCellIdentifier";

@interface RepositoryListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    
    __weak IBOutlet UITableView *tblView;
}
@end

@implementation RepositoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tblView.rowHeight = UITableViewAutomaticDimension;
    tblView.estimatedRowHeight = 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc
{
    self.listOfRepository = nil;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"repositoryListVC"]) {
        DetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *index = (NSIndexPath*)sender;
        RepositoryDM *model = [self.listOfRepository objectAtIndex:index.row];
        detailVC.repoModel = model;
    }
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}

#pragma mark- UITableview Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listOfRepository.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RepositoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kRepoCellIdentifier forIndexPath:indexPath];
    RepositoryDM *model = [self.listOfRepository objectAtIndex:indexPath.row];
    [cell updateCellDataWith:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"repositoryListVC" sender:indexPath];
}
@end



