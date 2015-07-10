//
//  CCTDeviceResolution.h
//  ShaiMei
//
//  Created by LF on 15/4/24.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCTDeviceResolution : NSObject

@property (nonatomic,copy) NSString *width;
@property (nonatomic,copy) NSString *height;

//Model initialize method
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)listWithDict:(NSDictionary *)dict;


@end
