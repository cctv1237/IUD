//
//  CCTDeviceModel.h
//  ShaiMei
//
//  Created by LF on 15/4/22.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCTDeviceResolution;
@interface CCTDeviceModel : NSObject

@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *model;
@property (nonatomic,copy) NSString *os;
@property (nonatomic,copy) NSString *rom;
@property (nonatomic,copy) NSString *ppi;
@property (nonatomic,copy) NSString *imei;
@property (nonatomic,copy) NSString *imsi;
@property (nonatomic,strong) CCTDeviceResolution *resolution;

//Model initialize method
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)listWithDict:(NSDictionary *)dict;


@end
