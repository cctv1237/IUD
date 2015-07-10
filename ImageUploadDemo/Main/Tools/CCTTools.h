//
//  BSTools.h
//  OnEarth
//
//  Created by LF on 15/6/17.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>

#ifdef DEBUG
#define CCTLog(...) NSLog(__VA_ARGS__)
#else
#define CCTLog(...)
#endif

@interface CCTTools : NSObject

+ (NSAttributedString *)attributedPlaceholderWithName:(NSString *)name Color:(UIColor *)color;
+ (NSString *)stringWithUUID;
+ (UIColor *)stringTOColor:(NSString *)str;
+ (CGSize)sizeWithString:(NSString *)textString font:(UIFont *)font textMaxSize:(CGSize) textMaxSize;
+ (UILabel *) smallLableWithFrame:(UILabel *)lable labelText:(NSString *)text fontSize:(CGFloat)size textColor:(NSString *)color labelX:(CGFloat)x labelY:(CGFloat)y;

@end
