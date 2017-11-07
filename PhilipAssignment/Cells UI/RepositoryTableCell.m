//
//  RepositoryTableCell.m
//  PhilipAssignment
//
//  Created by Amrendra on 14/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import "RepositoryTableCell.h"

@implementation RepositoryTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateCellDataWith:(RepositoryDM*)model
{
    nameLbl.text = model.userName;
    numberOfIssuesLbl.text = [NSString stringWithFormat:@"Open issues: %@", model.numberOfIssues];
    descriptionLbl.text = model.repoDescription;
}
@end
