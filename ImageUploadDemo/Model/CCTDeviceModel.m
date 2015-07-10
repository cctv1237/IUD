//
//  CCTDeviceModel.m
//  ShaiMei
//
//  Created by LF on 15/4/22.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "CCTDeviceModel.h"
#import "CCTTools.h"
#import "CCTDeviceResolution.h"

@interface CCTDeviceModel ()

@end

NSDictionary *iPhoneTypeDefine;

@implementation CCTDeviceModel

- (NSDictionary *)iPhoneTypeDefine{
    if (!iPhoneTypeDefine) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"iPhoneTypeDefine.plist" ofType:nil];
        iPhoneTypeDefine = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return iPhoneTypeDefine;
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)listWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.resolution = [[CCTDeviceResolution alloc] init];
        [self deviceResolutionChoose];
        
        NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        self.type = @"ios";
        self.imei = idfv;
        self.imsi = idfv;
        self.model = [self.iPhoneTypeDefine valueForKeyPath:deviceName()];
        self.os = UIDevice.currentDevice.systemVersion;
        self.rom = UIDevice.currentDevice.model;
        
    }
    return self;
}



- (void)deviceResolutionChoose {
    
    if ([deviceName() isEqualToString:@"iPod1,1"] ||
        [deviceName() isEqualToString:@"iPod2,1"] ||
        [deviceName() isEqualToString:@"iPod3,1"] ||
        [deviceName() isEqualToString:@"iPhone1,1"] ||
        [deviceName() isEqualToString:@"iPhone1,2"] ||
        [deviceName() isEqualToString:@"iPhone2,1"]) {
        
        self.resolution.width = @"320";
        self.resolution.height = @"480";
        self.ppi = @"163";
    }
    else if ([deviceName() isEqualToString:@"iPod4,1"] ||
             [deviceName() isEqualToString:@"iPhone3,1"] ||
             [deviceName() isEqualToString:@"iPhone3,3"] ||
             [deviceName() isEqualToString:@"iPhone4,1"]) {
        
        self.resolution.width = @"640";
        self.resolution.height = @"960";
        self.ppi = @"326";
    }
    else if ([deviceName() isEqualToString:@"iPhone5,1"] ||
             [deviceName() isEqualToString:@"iPhone5,2"] ||
             [deviceName() isEqualToString:@"iPhone5,3"] ||
             [deviceName() isEqualToString:@"iPhone5,4"] ||
             [deviceName() isEqualToString:@"iPhone6,1"] ||
             [deviceName() isEqualToString:@"iPhone6,2"]) {
        
        self.resolution.width = @"640";
        self.resolution.height = @"1136";
        self.ppi = @"326";
    }
    else if ([deviceName() isEqualToString:@"iPhone7,1"]) {
        
        self.resolution.width = @"1080";
        self.resolution.height = @"1920";
        self.ppi = @"401";
    }
    else if ([deviceName() isEqualToString:@"iPhone7,2"]) {
        
        self.resolution.width = @"750";
        self.resolution.height = @"1334";
        self.ppi = @"326";
    }
    else if ([deviceName() isEqualToString:@"iPad1,1"] ||
             [deviceName() isEqualToString:@"iPad2,1"]) {
        
        self.resolution.width = @"768";
        self.resolution.height = @"1024";
        self.ppi = @"132";
    }
    else if ([deviceName() isEqualToString:@"iPad3,1"] ||
             [deviceName() isEqualToString:@"iPad3,4"] ||
             [deviceName() isEqualToString:@"iPad4,1"] ||
             [deviceName() isEqualToString:@"iPad4,2"]) {
        
        self.resolution.width = @"1536";
        self.resolution.height = @"2048";
        self.ppi = @"264";
    }
    else if ([deviceName() isEqualToString:@"iPad2,5"]) {
        
        self.resolution.width = @"768";
        self.resolution.height = @"1024";
        self.ppi = @"163";
    }
    else if ([deviceName() isEqualToString:@"iPad4,4"] ||
             [deviceName() isEqualToString:@"iPad4,5"]) {
        
        self.resolution.width = @"1536";
        self.resolution.height = @"2048";
        self.ppi = @"326";
    }
    
    else {
        
        self.resolution.width = @"640";
        self.resolution.height = @"960";
        self.ppi = @"264";
    }
    
    
}

#pragma mark - C Func

NSString *deviceName(){
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

@end
