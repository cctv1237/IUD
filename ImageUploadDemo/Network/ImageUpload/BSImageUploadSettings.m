//
//  BSImageUploadSettings.m
//  OnEarth
//
//  Created by LF on 15/7/7.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "BSImageUploadSettings.h"
#import "BSNetworkManager.h"
#import "CCTDeviceModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <QiniuSDK.h>
#import <MBProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "CCTTools.h"
#import "BSAccessTokenSettings.h"

@interface BSImageUploadSettings () <BSAccessTokenSettingsDelegate>

@property (nonatomic, copy) NSString *downloadName;
@property (nonatomic, strong) UIImageView *imageViewToShow;

@end

@implementation BSImageUploadSettings

- (instancetype)init {
    if (self = [super init]) {
        _downloadName = [[NSString alloc] init];
        _imageViewToShow = [[UIImageView alloc] init];
    }
    return self;

}

+ (instancetype)settings {
    
    static BSImageUploadSettings *settings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[BSImageUploadSettings alloc] init];
    });
    return settings;
}

- (void)upLoadImage:(UIImage *)image withName:(NSString *)name atView:(UIView *)view {

    NSUserDefaults __block *userDefault = [NSUserDefaults standardUserDefaults];
    NSString __block *upLoadToken = [[NSString alloc] init];
    
    [BSNetworkManager BSPOST:UpLoadTokenAPI
                  parameters:nil
                      atView:view
                     success:^(id responseObject) {
                         
                         [MBProgressHUD showHUDAddedTo:view animated:YES];
                         upLoadToken = [responseObject valueForKey:@"uploadToken"];
                         QNUploadManager *upManager = [[QNUploadManager alloc] init];
                         NSData *data = UIImagePNGRepresentation(image);
                         [upManager putData:data
                                        key:nil
                                      token:upLoadToken
                                   complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                                       
                                       CCTLog(@"上传成功\n%@", resp);
                                       
                                       [userDefault setObject:[resp valueForKey:@"key"]
                                                       forKey:[NSString stringWithFormat:@"downLoadKey_%@",name]];
                                       [userDefault setObject:[resp valueForKey:@"hash"]
                                                       forKey:[NSString stringWithFormat:@"downLoadHash_%@",name]];
                                       [userDefault synchronize];
                                       [MBProgressHUD hideHUDForView:view animated:YES];
                                       
                                   } option:nil];
                     } failure:^(id responseObject) {
                         
                     }];
}

- (void)getDownLoadURLByName:(NSString *)name success:(void (^)(id downLoadURL))success failure:(void (^)(id responseObject))failure {
    
    NSUserDefaults __block *userDefault = [NSUserDefaults standardUserDefaults];
    NSString __block *downLoadURL = [[NSString alloc] init];
    
    [BSNetworkManager BSPOST:DownLoadURLAPI
                  parameters:@{@"key":[userDefault objectForKey:[NSString stringWithFormat:@"downLoadKey_%@",name]]}
                      atView:nil
                     success:^(id responseObject) {
                         downLoadURL = [responseObject valueForKey:@"downloadUrl"];
                         [userDefault setObject:downLoadURL forKey:[NSString stringWithFormat:@"downLoadURL_%@",name]];
                         [userDefault synchronize];
                         success(downLoadURL);
                     }
                     failure:^(id responseObject) {
                         failure(responseObject);
                     }];
    
}

- (void)showDownloadImageIn:(UIImageView *)imageView withName:(NSString *)name {
    
    BSAccessTokenSettings *accessTokenSettings = [BSAccessTokenSettings settings];
    accessTokenSettings.delegate = self;
    self.downloadName = name;
    self.imageViewToShow = imageView;
    
    [self getDownLoadURLByName:name success:^(id downLoadURL) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:downLoadURL] placeholderImage:[UIImage imageNamed:@"guide_pitch-on_btn_cyan"]];
    } failure:^(id responseObject) {
        [accessTokenSettings refreshBearerTokenIfExpired:responseObject atView:nil];
    }];
}


#pragma mark - BSAccessTokenSettingsDelegate

- (void)DidRefreshedBearerTokenAtView:(UIView *)view {
    [self showDownloadImageIn:self.imageViewToShow withName:self.downloadName];
}


@end
