//
//  IssuesTableCell.h
//  PhilipAssignment
//
//  Created by Amrendra on 14/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepositoryDM.h"
@interface IssuesTableCell : UITableViewCell
{
    
    __weak IBOutlet UILabel *titleLbl;
    __weak IBOutlet UILabel *issueNumberLbl;
    __weak IBOutlet UILabel *statusLbl;

}

- (void)updateIssuesCellWith:(IssuesDM*)issue;

@end
