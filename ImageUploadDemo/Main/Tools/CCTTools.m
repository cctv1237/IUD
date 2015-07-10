//
//  BSTools.m
//  OnEarth
//
//  Created by LF on 15/6/17.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "CCTTools.h"

@implementation CCTTools

+ (NSAttributedString *)attributedPlaceholderWithName:(NSString *)name Color:(UIColor *)color {
    return [[NSAttributedString alloc] initWithString:name attributes:@{NSForegroundColorAttributeName: color}];
}

+ (NSString *)stringWithUUID {
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

+ (UIColor *)stringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

+ (CGSize)sizeWithString:(NSString *)textString font:(UIFont *)font textMaxSize:(CGSize) textMaxSize{
    
    NSDictionary *fontDict = @{NSFontAttributeName: font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size = [textString boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil].size;
    return size;
    
}


+ (UILabel *) smallLableWithFrame:(UILabel *)lable labelText:(NSString *)text fontSize:(CGFloat)size textColor:(NSString *)color labelX:(CGFloat)x labelY:(CGFloat)y{
    
    lable.text = text;
    lable.font = [UIFont systemFontOfSize:size];
    lable.textColor = [[self class] stringTOColor:color];
    CGSize labelSize = [[self class] sizeWithString:lable.text font:lable.font textMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat labelWidth = labelSize.width;
    CGFloat labelHight = labelSize.height;
    lable.frame = CGRectMake(x, y, labelWidth, labelHight);
    
    return lable;
}


@end
