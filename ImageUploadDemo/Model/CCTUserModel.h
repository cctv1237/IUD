//
//  CCTUserModel.h
//  ShaiMei
//
//  Created by LF on 15/4/22.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCTUserAvatar;
@interface CCTUserModel : NSObject

@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *confirmPassword;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,strong) CCTUserAvatar *avatar;

//Model initialize method
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)listWithDict:(NSDictionary *)dict;


@end
