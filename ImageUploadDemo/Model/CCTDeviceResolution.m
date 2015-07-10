//
//  CCTDeviceResolution.m
//  ShaiMei
//
//  Created by LF on 15/4/24.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "CCTDeviceResolution.h"

@implementation CCTDeviceResolution

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)listWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
