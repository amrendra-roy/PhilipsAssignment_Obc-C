//
//  BasicInfoTableCell.m
//  PhilipAssignment
//
//  Created by Amrendra on 14/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import "BasicInfoTableCell.h"

@implementation BasicInfoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateBasicCellWith:(RepositoryDM*)model
{
    titleLbl.text = model.userName;
    discriptionLbl.text = model.repoDescription;
}
@end
