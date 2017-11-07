//
//  IssuesTableCell.m
//  PhilipAssignment
//
//  Created by Amrendra on 14/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import "IssuesTableCell.h"

@implementation IssuesTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateIssuesCellWith:(IssuesDM*)issue
{
    titleLbl.text = issue.issueTitle;
    issueNumberLbl.text = [NSString stringWithFormat:@"Issues Number: %@",issue.issueNumber];
    statusLbl.text = [NSString stringWithFormat:@"Issue Status: %@",issue.issueState];
}

@end
