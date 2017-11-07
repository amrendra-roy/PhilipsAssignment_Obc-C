//
//  GitServiceManager.m
//  PhilipAssignment
//
//  Created by Amrendra on 13/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import "GitServiceManager.h"

@interface GitServiceManager()<NSURLSessionDelegate>
{
    
}
@property(nonatomic, strong)NSURLSession *session;
@end


@implementation GitServiceManager
@synthesize session;


+ (instancetype)sharedInstance
{
    static GitServiceManager *sharedIns = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedIns = [[self alloc] init];
        
    });
    return sharedIns;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}
- (void)dealloc
{
    self.session = nil;
}
#pragma Mark- Methods
- (void)startDownloadWithURL:(NSString*)strURL
                     completionHandler:(void(^)(NSData *data, NSError *error))handler
{
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"Downloading url is = %@",url);
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!data) {
            handler(nil, error);
        }else{
           handler(data, error);
        }
    }];
    [task resume];
}
    
    
    
    
@end
