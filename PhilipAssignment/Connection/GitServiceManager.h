//
//  GitServiceManager.h
//  PhilipAssignment
//
//  Created by Amrendra on 13/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GitServiceManager : NSObject
{
        
}


/*
 @func: + (instancetype)sharedInstance
 @detail: Create singleton instance and save download session instance for every where in appliction
 @input type: No
 @retur type: self instance
 */
+ (instancetype)sharedInstance;


/*
 @func: - (void)startDownloadWithURL:(NSString*)strURL completionHandler:(void(^)(NSData *data, NSError *error))handler;
 @detail: A function which make provide the interface to start a web service call.
 @input type: Take download url string as input and completion hander to get call back it could be for ViewController Or TestViewController
 @retur type: Completion hander for call back
 */
- (void)startDownloadWithURL:(NSString*)strURL
           completionHandler:(void(^)(NSData *data, NSError *error))handler;
    

@end
