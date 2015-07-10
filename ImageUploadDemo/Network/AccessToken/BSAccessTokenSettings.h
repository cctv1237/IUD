//
//  BSAccessTokenHTTPSettings.h
//  OnEarth
//
//  Created by LF on 15/7/7.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  APIs
 */
#define OAuthBasicTokenAPI @"http://"ServersIP@"/oauth/basic_token"
#define RefreshBearerTokenAPI @"http://"ServersIP@"/oauth/bearer_token"

@class BSNetworkManager, CCTDeviceModel;

@protocol BSAccessTokenSettingsDelegate <NSObject>
@required
- (void)DidRefreshedBearerTokenAtView:(UIView *)view;

@end

@interface BSAccessTokenSettings : NSObject

@property (nonatomic, weak) id<BSAccessTokenSettingsDelegate> delegate;

+ (instancetype)settings;

- (void)getBasicTokenByJSON:(CCTDeviceModel *)json;
- (void)refreshBearerTokenIfExpired:(id)responseObject atView:(UIView *)view;
- (void)refreshBearerTokenAtView:(UIView *)view;

@end
