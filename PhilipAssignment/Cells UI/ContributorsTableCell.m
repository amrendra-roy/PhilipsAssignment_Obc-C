//
//  ContributorsTableCell.m
//  PhilipAssignment
//
//  Created by Amrendra on 14/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import "ContributorsTableCell.h"

@implementation ContributorsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateContributorCellWith:(ContributorsDM*)contribut
{
    contributorValueLbl.text = contribut.contributerName;
    contributionValueLbl.text = [NSString stringWithFormat:@"%@",contribut.contributionNumber];
}
@end
