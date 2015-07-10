//
//  BSAccessTokenHTTPSettings.m
//  OnEarth
//
//  Created by LF on 15/7/7.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "BSAccessTokenSettings.h"
#import "BSNetworkManager.h"
#import "CCTDeviceModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "CCTTools.h"

@implementation BSAccessTokenSettings

+ (instancetype)settings {
    
    static BSAccessTokenSettings *settings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[BSAccessTokenSettings alloc] init];
    });
    return settings;
}

- (void)getBasicTokenByJSON:(CCTDeviceModel *)json {
    
    NSUserDefaults __block *userDefault = [NSUserDefaults standardUserDefaults];
    NSString __block *basicToken = [[NSString alloc] init];
    
    [BSNetworkManager BSPOST:OAuthBasicTokenAPI
                  parameters:json.keyValues
                      atView:nil
                     success:^(id responseObject) {
                        basicToken = [responseObject valueForKey:@"accessToken"];
                        [userDefault setObject:basicToken forKey:@"accessToken"];
                        [userDefault synchronize];
                     }
                     failure:^(id responseObject) {
                     }];
}

- (void)refreshBearerTokenIfExpired:(id)responseObject atView:(UIView *)view {
    if ([[responseObject valueForKey:@"id"] isEqualToString:@"expired_access_token"] ||
        [[responseObject valueForKey:@"id"] isEqualToString:@"invalid_access_token"]) {
        [self refreshBearerTokenAtView:view];
    }
}

- (void)refreshBearerTokenAtView:(UIView *)view {
    
    NSUserDefaults __block *userDefault = [NSUserDefaults standardUserDefaults];
    NSString __block *bearerToken = [[NSString alloc] init];
    NSString __block *refreshToken = [[NSString alloc] init];
    
    [BSNetworkManager BSPUT:RefreshBearerTokenAPI
             parameters:@{@"refreshToken":[userDefault objectForKey:@"refreshToken"]}
                 atView:view
                success:^(id responseObject) {
                    bearerToken = [responseObject valueForKey:@"accessToken"];
                    [userDefault setObject:bearerToken forKey:@"accessToken"];
                    refreshToken = [responseObject valueForKey:@"refreshToken"];
                    [userDefault setObject:refreshToken forKey:@"refreshToken"];
                    [userDefault synchronize];
                    [self.delegate DidRefreshedBearerTokenAtView:view];
                }
                failure:^(id responseObject) {
                    [self refreshBearerTokenAtView:view];
                }];
}


@end
