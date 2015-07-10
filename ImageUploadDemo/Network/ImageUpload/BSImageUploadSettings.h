//
//  BSImageUploadSettings.h
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
#define UpLoadTokenAPI @"http://"ServersIP@"/storage/upload_token"
#define DownLoadURLAPI @"http://"ServersIP@"/storage/download_url"

@class BSNetworkManager;
@interface BSImageUploadSettings : NSObject 

+ (instancetype)settings;

- (void)upLoadImage:(UIImage *)image withName:(NSString *)name atView:(UIView *)view;
- (void)showDownloadImageIn:(UIImageView *)imageView withName:(NSString *)name;

@end
