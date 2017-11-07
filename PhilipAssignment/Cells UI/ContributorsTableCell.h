//
//  ContributorsTableCell.h
//  PhilipAssignment
//
//  Created by Amrendra on 14/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepositoryDM.h"

@interface ContributorsTableCell : UITableViewCell
{
    
    __weak IBOutlet UILabel *contributorValueLbl;   
    __weak IBOutlet UILabel *contributionValueLbl;
    
}
- (void)updateContributorCellWith:(ContributorsDM*)contribut;
@end
