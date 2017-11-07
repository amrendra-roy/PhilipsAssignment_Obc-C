//
//  Utitlity.m
//  PhilipAssignment
//
//  Created by Amrendra on 13/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import "Utitlity.h"
#import <Reachability/Reachability.h>

@implementation Utitlity

//Show alert view and don't need to perform any action on clicked
+ (UIAlertController*)showAlertWithTitle:(NSString*)title
                                 message:(NSString*)message
                        withCancelButton:(NSString*)btnTitle
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        
    }];
    [alert addAction:okAction];

    return alert;
}
//Show alert view and call back on click action
+ (UIAlertController*)showAlertWithTitle:(NSString*)title
                                 message:(NSString*)message
                            cancelButton:(NSString*)btnTitle
                       completionHandler:(void(^)(UIAlertAction *action))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        handler(action);//Call back when click the button
    }];
    [alert addAction:okAction];
    
    return alert;

}
#pragma mark- Network Status
+(BOOL)isNetworkReachable
{
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    BOOL Status = [self updateInterfaceWithReachability:internetReach];
    return Status;
    
}
+ (BOOL)updateInterfaceWithReachability:(Reachability*) curReach
{
    BOOL status = [self getInternetStatus: curReach];
    return status;
}
+(BOOL)getInternetStatus:(Reachability*) curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    BOOL connectionRequired= [curReach connectionRequired];
    switch (netStatus)
    {
        case NotReachable:
            connectionRequired= NO;
            break;
            
        case ReachableViaWWAN:
            connectionRequired= YES;
            break;
        case ReachableViaWiFi:
            connectionRequired= YES;
            break;
    }
    return connectionRequired;
}
@end
