//
//  RepositoryTableCell.h
//  PhilipAssignment
//
//  Created by Amrendra on 14/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepositoryDM.h"

@interface RepositoryTableCell : UITableViewCell
{
    __weak IBOutlet UILabel *nameLbl;
    __weak IBOutlet UILabel *numberOfIssuesLbl;
    __weak IBOutlet UILabel *descriptionLbl;
    
}

- (void)updateCellDataWith:(RepositoryDM*)model;


@end
