//
//  CCTSignupModel.h
//  ShaiMei
//
//  Created by LF on 15/4/24.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCTUserModel;
@class CCTDeviceModel;
@interface CCTSignupModel : NSObject

@property (nonatomic,strong) CCTUserModel *user;
@property (nonatomic,strong) CCTDeviceModel *device;

@end
