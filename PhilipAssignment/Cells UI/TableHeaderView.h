//
//  TableHeaderView.h
//  PhilipAssignment
//
//  Created by Amrendra on 14/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeaderView : UIView
{
    

    __weak IBOutlet UILabel *headerTitleLbl;
}
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLbl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (void)updateSectionHeader:(NSString*)title;
@end
