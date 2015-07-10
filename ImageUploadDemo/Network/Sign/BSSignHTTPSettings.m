//
//  BSNetworkSettings.m
//  OnEarth
//
//  Created by LF on 15/6/17.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "BSSignHTTPSettings.h"
#import "AppDelegate.h"
#import "CCTTools.h"
#import "CCTSignupModel.h"
#import "CCTDeviceModel.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <QiniuSDK.h>
#import <MBProgressHUD.h>
#import "BSNetworkManager.h"

@implementation BSSignHTTPSettings

+ (instancetype)settings {
    
    static BSSignHTTPSettings *settings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[BSSignHTTPSettings alloc] init];
    });
    return settings;
}

- (void)signupWithJSON:(CCTSignupModel *)json atView:(UIView *)view {
    
    NSUserDefaults __block *userDefault = [NSUserDefaults standardUserDefaults];
    NSString __block *bearerToken = [[NSString alloc] init];
    NSString __block *refreshToken = [[NSString alloc] init];
    
    [BSNetworkManager BSPOST:SignupAPI
                  parameters:json.keyValues
                      atView:view
                     success:^(id responseObject) {
                         bearerToken = [responseObject valueForKey:@"accessToken"];
                         [userDefault setObject:bearerToken forKey:@"accessToken"];
                         refreshToken = [responseObject valueForKey:@"refreshToken"];
                         [userDefault setObject:refreshToken forKey:@"refreshToken"];
                         [userDefault synchronize];
                         [self getAvatarDownLoadURLWithSpec:@"180" atView:view];

                     }
                     failure:^(id responseObject) {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Signup Failed" message:@"Try another phone number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         alert.tag = 2;
                         [alert show];
                     }];
}

- (void)signonWithJSON:(CCTSignupModel *)json atView:(UIView *)view{

    NSUserDefaults __block *userDefault = [NSUserDefaults standardUserDefaults];
    NSString __block *bearerToken = [[NSString alloc] init];
    NSString __block *refreshToken = [[NSString alloc] init];

    [BSNetworkManager BSPUT:LoginAPI
                 parameters:json.keyValues
                     atView:view
                    success:^(id responseObject) {
                        bearerToken = [responseObject valueForKey:@"accessToken"];
                        [userDefault setObject:bearerToken forKey:@"accessToken"];
                        refreshToken = [responseObject valueForKey:@"refreshToken"];
                        [userDefault setObject:refreshToken forKey:@"refreshToken"];
                        [userDefault synchronize];
                        [self getAvatarDownLoadURLWithSpec:@"180" atView:view];
                        
                    }
                    failure:^(id responseObject) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warnning" message:@"account or password wrong" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }];
}

- (void)isExistByUser:(NSString *)mobilePhone atView:(UIView *)view {
    
    [BSNetworkManager BSGET:[NSString stringWithFormat:@"%@%@",IsUserExistAPI, mobilePhone]
                 parameters:nil
                     atView:view
                    success:^(id responseObject) {
                        [self.delegate successedWithResponse:responseObject];
                    }
                    failure:^(id responseObject) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warnning" message:@"Phone must be 11 numbers" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }];
    
}

+ (void)getCaptChaCredential {
    
    NSUserDefaults __block *userDefault = [NSUserDefaults standardUserDefaults];
    NSString __block *appKey = [[NSString alloc] init];
    NSString __block *appSecret = [[NSString alloc] init];
    
    [BSNetworkManager BSGET:CaptChaAPI
                 parameters:nil
                     atView:nil
                    success:^(id responseObject) {
                        appKey = [responseObject valueForKey:@"appKey"];
                        appSecret = [responseObject valueForKey:@"appSecret"];
                        [userDefault setObject:appKey forKey:@"appKey"];
                        [userDefault setObject:appSecret forKey:@"appSecret"];
                        [userDefault synchronize];
                    }
                    failure:^(id responseObject) {
                        
                    }];

}

- (void)getAvatarDownLoadURLWithSpec:(NSString *)spec atView:(UIView *)view{
    
    NSUserDefaults __block *userDefault = [NSUserDefaults standardUserDefaults];
    NSString __block *downLoadURL = [[NSString alloc] init];
    
    [BSNetworkManager BSPOST:[NSString stringWithFormat:@"%@%@",AvatarDownLoadURLAPIWithSpec, spec]
                  parameters:nil
                      atView:nil
                     success:^(id responseObject) {
                         downLoadURL = [responseObject valueForKey:@"downloadUrl"];
                         [userDefault setObject:downLoadURL forKey:@"downLoadURL_avatar"];
                         [userDefault synchronize];
                         [self.delegate successedWithResponse:responseObject];
                         
                     }
                     failure:^(id responseObject) {
                         
                     }];
}


@end
