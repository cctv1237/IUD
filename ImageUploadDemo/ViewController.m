//
//  ViewController.m
//  ImageUploadDemo
//
//  Created by LF on 15/7/9.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import "BSImageUploadSettings.h"
#import "BSAccessTokenSettings.h"
#import "BSSignHTTPSettings.h"
#import "CCTDeviceModel.h"
#import "CCTUserModel.h"
#import "CCTSignupModel.h"
#import <MBProgressHUD.h>

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BSAccessTokenSettings *accessTokenSettings = [BSAccessTokenSettings settings];
    [accessTokenSettings getBasicTokenByJSON:[[CCTDeviceModel alloc] init]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self login];
    });
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView1];
    [self.scrollView addSubview:self.imageView2];
    [self.scrollView addSubview:self.imageView3];
}

- (void)login {
    BSSignHTTPSettings *signHTTPSettings = [BSSignHTTPSettings settings];
    CCTSignupModel *signupModel = [[CCTSignupModel alloc] init];
    CCTUserModel *userModel = [[CCTUserModel alloc] init];
    userModel.mobile = @"+86-18611111111";
    userModel.password = @"qqqqqq";
    signupModel.user = userModel;
    signupModel.device = [[CCTDeviceModel alloc] init];
    [signHTTPSettings signonWithJSON:signupModel atView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self upload];
    });
}

- (void)upload {
    BSImageUploadSettings *imageUploadSettings = [BSImageUploadSettings settings];
    [imageUploadSettings upLoadImage:[UIImage imageNamed:@"1"] withName:@"1" atView:self.view];
    [imageUploadSettings upLoadImage:[UIImage imageNamed:@"2"] withName:@"2" atView:self.view];
    [imageUploadSettings upLoadImage:[UIImage imageNamed:@"3"] withName:@"3" atView:self.view];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self download];
    });
}

- (void)download {
    BSImageUploadSettings *imageUploadSettings = [BSImageUploadSettings settings];
    [imageUploadSettings showDownloadImageIn:self.imageView1 withName:@"1"];
    [imageUploadSettings showDownloadImageIn:self.imageView2 withName:@"2"];
    [imageUploadSettings showDownloadImageIn:self.imageView3 withName:@"3"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.frame;
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
    }
    return _scrollView;
}

- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] init];
        _imageView1.frame = CGRectMake(0, 0, 150, 150);
        _imageView1.backgroundColor = [UIColor redColor];
    }
    return _imageView1;
}

- (UIImageView *)imageView2 {
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] init];
        _imageView2.frame = CGRectMake(0, 200, 150, 150);
        _imageView2.backgroundColor = [UIColor redColor];
    }
    return _imageView2;
}

- (UIImageView *)imageView3 {
    if (!_imageView3) {
        _imageView3 = [[UIImageView alloc] init];
        _imageView3.frame = CGRectMake(0, 400, 150, 150);
        _imageView3.backgroundColor = [UIColor redColor];
    }
    return _imageView3;
}

@end
