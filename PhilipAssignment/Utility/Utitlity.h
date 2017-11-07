//
//  Utitlity.h
//  PhilipAssignment
//
//  Created by Amrendra on 13/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 class: Utitlity
 detail: A class which contains the all basic utility method/functionality which access through all classes. It contains like a template for display a message with call back, access network reachability.
 */
@interface Utitlity : NSObject
{
    
}
//Show alert view and don't need to perform any action on clicked
+ (UIAlertController*)showAlertWithTitle:(NSString*)title
                                 message:(NSString*)message
                        withCancelButton:(NSString*)btnTitle;

//Show alert view and call back on click action
+ (UIAlertController*)showAlertWithTitle:(NSString*)title
                                 message:(NSString*)message
                            cancelButton:(NSString*)btnTitle
                       completionHandler:(void(^)(UIAlertAction *action))handler;

+ (BOOL)isNetworkReachable;
@end
