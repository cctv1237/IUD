//
//  BSNetworkManager.h
//  OnEarth
//
//  Created by LF on 15/7/7.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ServersVersion @"/v1"
#define ServersIP @"192.168.100.50:8080"ServersVersion

/**
 *  header
 */
#define ContentTypeValue @"application/json;charset=UTF-8"

@interface BSNetworkManager : NSObject

+ (void)BSPOST:(NSString *)URLString parameters:(id)parameters atView:(UIView *)view success:(void (^)(id responseObject))success failure:(void (^)(id responseObject))failure;
+ (void)BSPUT:(NSString *)URLString parameters:(id)parameters atView:(UIView *)view success:(void (^)(id responseObject))success failure:(void (^)(id responseObject))failure;
+ (void)BSGET:(NSString *)URLString parameters:(id)parameters atView:(UIView *)view success:(void (^)(id responseObject))success failure:(void (^)(id responseObject))failure;

@end
