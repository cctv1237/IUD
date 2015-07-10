//
//  BSNetworkManager.m
//  OnEarth
//
//  Created by LF on 15/7/7.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "BSNetworkManager.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import "CCTTools.h"

@interface BSNetworkManager ()

@end

@implementation BSNetworkManager

+ (void)BSPOST:(NSString *)URLString
    parameters:(id)parameters
        atView:(UIView *)view
       success:(void (^)(id responseObject))success
       failure:(void (^)(id responseObject))failure {
    
    //设置网络
    AFHTTPRequestOperationManager *mgrAFN = [AFHTTPRequestOperationManager manager];
    [[self class] setHeadOfOAuthRequest:mgrAFN];
    
    //传输
    CCTLog(@"发送\n%@",parameters);
    [self showHUDToView:view];
    [mgrAFN POST:URLString
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             CCTLog(@"成功\n%@",responseObject);
             [self hideHUDToView:view];
             success(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSDictionary *responseDict = [[NSDictionary alloc] init];
             if (operation.responseData) {
                 responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:&error];
             }
             CCTLog(@"失败\n%@",[error.userInfo valueForKey:@"NSLocalizedDescription"]);
             CCTLog(@"%@",responseDict);
             [self hideHUDToView:view];
             failure(responseDict);
         }];
    
}

+ (void)BSPUT:(NSString *)URLString
   parameters:(id)parameters
       atView:(UIView *)view
      success:(void (^)(id responseObject))success
      failure:(void (^)(id responseObject))failure {
    
    //设置网络
    AFHTTPRequestOperationManager *mgrAFN = [AFHTTPRequestOperationManager manager];
    [[self class] setHeadOfOAuthRequest:mgrAFN];
    
    //传输
    CCTLog(@"发送\n%@",parameters);
    [self showHUDToView:view];
    [mgrAFN PUT:URLString
     parameters:parameters
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            CCTLog(@"成功\n%@",responseObject);
            [self hideHUDToView:view];
            success(responseObject);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSDictionary *responseDict = [[NSDictionary alloc] init];
            if (operation.responseData) {
                responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:&error];
            }
            CCTLog(@"失败\n%@",[error.userInfo valueForKey:@"NSLocalizedDescription"]);
            CCTLog(@"%@",responseDict);
            [self hideHUDToView:view];
            failure(responseDict);
        }];

}

+ (void)BSGET:(NSString *)URLString
   parameters:(id)parameters
       atView:(UIView *)view
      success:(void (^)(id responseObject))success
      failure:(void (^)(id responseObject))failure {
    
    //设置网络
    AFHTTPRequestOperationManager *mgrAFN = [AFHTTPRequestOperationManager manager];
    [[self class] setHeadOfOAuthRequest:mgrAFN];
    
    //传输
    CCTLog(@"发送\n%@",parameters);
    [self showHUDToView:view];
    [mgrAFN GET:URLString
     parameters:parameters
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            CCTLog(@"成功\n%@",responseObject);
            [self hideHUDToView:view];
            success(responseObject);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSDictionary *responseDict = [[NSDictionary alloc] init];
            if (operation.responseData) {
                responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:&error];
            }
            CCTLog(@"失败\n%@",[error.userInfo valueForKey:@"NSLocalizedDescription"]);
            CCTLog(@"%@",responseDict);
            [self hideHUDToView:view];
            failure(responseDict);
        }];

}

#pragma - mark Private

+ (void)setHeadOfOAuthRequest:(AFHTTPRequestOperationManager *)mgr {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [mgr.requestSerializer setValue:ContentTypeValue forHTTPHeaderField:@"Content-Type"];
    NSString *requestID = [CCTTools stringWithUUID];
    [mgr.requestSerializer setValue:requestID forHTTPHeaderField:@"X-Request-ID"];
    [mgr.requestSerializer setValue:[NSString stringWithFormat:@"%@", [userDefault objectForKey:@"accessToken"]]
                 forHTTPHeaderField:@"Authorization"];
    mgr.requestSerializer.timeoutInterval = 10;
}

+ (void)showHUDToView:(UIView *)view {
    if (view) {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
}
+ (void)hideHUDToView:(UIView *)view {
    if (view) {
        [MBProgressHUD hideHUDForView:view animated:YES];
    }
}

@end
