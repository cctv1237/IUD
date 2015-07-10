//
//  BSNetworkSettings.h
//  OnEarth
//
//  Created by LF on 15/6/17.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  APIs
 */
#define SignupAPI @"http://"ServersIP@"/users"
#define LoginAPI @"http://"ServersIP@"/users/actions/login"
#define IsUserExistAPI @"http://"ServersIP@"/users/"
#define CaptChaAPI @"http://"ServersIP@"/sms/ios_credential"
#define AvatarDownLoadURLAPIWithSpec @"http://"ServersIP@"/users/current/avatar/"


@class AFHTTPRequestOperation, CCTSignupModel, CCTDeviceModel, BSNetworkManager;

@protocol BSSignHTTPSettingsDelegate <NSObject>
@optional
- (void)successedWithResponse:(id)responseObject;
- (void)failedWithResponse:(AFHTTPRequestOperation *)operation;

@end

@interface BSSignHTTPSettings : NSObject

@property (nonatomic, weak) id<BSSignHTTPSettingsDelegate> delegate;

+ (instancetype)settings;

- (void)signupWithJSON:(CCTSignupModel *)json atView:(UIView *)view;
- (void)signonWithJSON:(CCTSignupModel *)json atView:(UIView *)view;
- (void)isExistByUser:(NSString *)mobilePhone atView:(UIView *)view;
+ (void)getCaptChaCredential;
- (void)getAvatarDownLoadURLWithSpec:(NSString *)spec atView:(UIView *)view;

@end
