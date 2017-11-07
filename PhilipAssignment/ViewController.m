//
//  ViewController.m
//  PhilipAssignment
//
//  Created by Amrendra on 13/10/17.
//  Copyright © 2017 Amrendra. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD.h>
#import <Reachability.h>
#import "Constants.h"
#import "GitServiceManager.h"
#import "RepositoryDM.h"
#import "RepositoryListViewController.h"

static NSString * const kRepositories = @"repositories";

@interface ViewController ()<UITextFieldDelegate, MBProgressHUDDelegate>
{
    NSMutableArray *arOfRepositories;
    MBProgressHUD *hudIndicator;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"search_screen_title", nil);
    
    //Add gesture, when user tap on screen Keyboard should be resign.
    UITapGestureRecognizer *tapGesutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tapGesutre];
    tapGesutre = nil;

    arOfRepositories = [[NSMutableArray alloc] init];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Present the keyboard when user landing on this screen.
    UITextField *textField = [self.view viewWithTag:99];
    [textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - Helper methods
- (void)dismissKeyboard:(UITapGestureRecognizer*)gesture
{
    [self.view endEditing:YES];
}

#pragma Mark - UITextField Delegate
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField.text.length>0) {
        if ([self isNetworkAviable]) {
            [self fetchRepositoriesFromGitForLanguage:textField.text testCompletionHandler:nil];
        }
    }else{
        //Display a message if language is not provided
        UIAlertController *alert = [Utitlity showAlertWithTitle:NSLocalizedString(@"error_title", nil) message:NSLocalizedString(@"search_text_empty", nil) cancelButton:NSLocalizedString(@"ok_title", nil) completionHandler:^(UIAlertAction *action) {
            [textField becomeFirstResponder];
        }];

        [self presentViewController:alert animated:YES completion:nil];
    }
    return YES;
}

#pragma mark- Helpher methods
- (BOOL)isNetworkAviable {
    
    BOOL isNetwork = NO;
    if ([Utitlity isNetworkReachable]) {
        //Add indicator when network call is in-progress
        hudIndicator = [[MBProgressHUD alloc] initWithView:self.view];
        hudIndicator.label.text = NSLocalizedString(@"please_wait", nil);;
        hudIndicator.delegate = self;
        [hudIndicator removeFromSuperViewOnHide];
        [hudIndicator showAnimated:YES];
        [self.view addSubview:hudIndicator];
        isNetwork = YES;
    }else{
        UIAlertController *alert = [Utitlity showAlertWithTitle:nil message:NSLocalizedString(@"no_network", nil) cancelButton:NSLocalizedString(@"cancel_title", nil) completionHandler:^(UIAlertAction *action) {
        }];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    return isNetwork;
    
}

/*
 @func: fetchRepositoriesFromGitForLanguage:(NSString*)language testCompletionHandler:(void(^)(NSData *data, NSError *error))testHandler
 @detail: Function that prepare url. And make a web service call and send call back on completion of web service.
 @input type: A language that is user want to list out all repository
 @input type: A completion handler for getting call back. This is use full for Test Case only. So we don’t need to write duplication code in Unit Test class.
 */

- (void)fetchRepositoriesFromGitForLanguage:(NSString*)language testCompletionHandler:(void(^)(NSData *data, NSError *error))testHandler {
    
    NSString *str = [NSString stringWithFormat:REPOSITORIES_URL,language];
    NSString *strUrl = [BASE_URL stringByAppendingFormat:@"%@",str];
    __weak ViewController *weakSelf = self;
    
    [[GitServiceManager sharedInstance] startDownloadWithURL:strUrl completionHandler:^(NSData *data, NSError *error) {
        
        if (testHandler) {
            testHandler(data, error);
        }
        else{
            //Finally remove progress indicator on success/fail
            dispatch_async(dispatch_get_main_queue(), ^{
                [hudIndicator hideAnimated:YES afterDelay:0.1];
            });
            
            if (!error) {
                id respons = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if ([respons isKindOfClass:[NSDictionary class]]) {
                    respons = (NSDictionary*)respons;
                    NSArray *arResults = [respons objectForKey:kRepositories];
                    [weakSelf getRepositoryModelsFromArray:arResults];
                }else if([respons isKindOfClass:[NSArray class]]) {
                    //respons = (NSArray*)respons;
                }
                NSLog(@"Repository Results = %@",respons);
            }else{
                UIAlertController *alert = [Utitlity showAlertWithTitle:NSLocalizedString(@"error_title", nil) message:error.localizedDescription withCancelButton:NSLocalizedString(@"ok_title", nil)];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
        
    }];

}
/*
 @func: - (void)getRepositoryModelsFromArray:(NSArray*)results
 @detail: Function that is parse all repository data and create models. And move to next screen to list-out all repository.
 @input type: an array
 */
- (void)getRepositoryModelsFromArray:(NSArray*)results {
    if (arOfRepositories.count) {
        [arOfRepositories removeAllObjects];
    }
    
    //Parsing- Create a list repositories
    for (NSDictionary *dict in results) {
        
        RepositoryDM *model = [[RepositoryDM alloc] initWithRepoistoryDictionary:dict];
        if (model) {
            [arOfRepositories addObject:model];
        }
        model = nil;
    }
   //Move to Repository list screen
    dispatch_async(dispatch_get_main_queue(), ^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RepositoryListViewController *viewController = (RepositoryListViewController*)[story instantiateViewControllerWithIdentifier:@"RepositoryListVC"];
        viewController.listOfRepository = arOfRepositories;
        [self.navigationController pushViewController:viewController animated:YES];

    });
    
    
}
    
@end
