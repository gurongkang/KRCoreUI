//
//  NSString+Regex.m
//  iOS-LQB
//
//  Created by RK on 2017/6/9.
//  Copyright © 2017年 顾荣康. All rights reserved.
//

#import "NSString+KRRegex.h"

@implementation NSString (KRRegex)

+ (BOOL)kr_isNumber:(NSString *)num {
    NSString *number = @"0123456789";
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:number] invertedSet];
    NSString *filtered = [[num componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [num isEqualToString:filtered];
    return basic;
}

+ (BOOL)kr_isMobileNumber:(NSString *)mobileNum {
    NSString * mobile = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    if ([regextestmobile evaluateWithObject:mobileNum] == YES) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL)kr_isBlankString:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    //判断字符串是否全部为空格（[NSCharacterSet whitespaceAndNewlineCharacterSet]去掉字符串两端的空格)
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
        return YES;
    }
    return NO;
}

+ (BOOL)isNumberOrLetter:(NSString *)num {
    NSString *numberOrLetter = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:numberOrLetter] invertedSet];
    NSString *filtered = [[num componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [num isEqualToString:filtered];
    return basic;
}

+ (BOOL)kr_validatePassword:(NSString *)passWord {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

+ (BOOL)kr_newValidatePassword:(NSString *)passWord {
    NSString *passWordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

+ (BOOL)kr_isCode:(NSString *)code {
    NSString *codeRegex = @"^\\d{6}$";
    NSPredicate *codePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    return [codePredicate evaluateWithObject:code];
}

+ (BOOL)kr_isIdentityNum:(NSString *)identityCard {
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    return YES;
}

+ (NSInteger)kr_ageFromIdentityNum:(NSString *)identityCard {
    //当前时间
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents *comp = [gregorian components: unitFlags
                                          fromDate:dt];
    //当前年月日
    NSInteger curentYear = comp.year;
    NSInteger currentMonth = comp.month;
    NSInteger currentDay = comp.day;
    //身份证年月日
    NSInteger cardYear = [[identityCard substringWithRange: NSMakeRange(6, 4)] integerValue];
    NSInteger cardMonth = [[identityCard substringWithRange: NSMakeRange(10, 2)] integerValue];
    NSInteger cardDay = [[identityCard substringWithRange: NSMakeRange(12, 2)] integerValue];
    
    int  age = 0;
    //当前月份 > 出生月份 已过生日
    if (currentMonth > cardMonth) {
        age = curentYear - cardYear;
        //当前月份 == 出生月份 并且 当前日期 >= 出生日期 已过生日
    } else if (currentMonth == cardMonth && currentDay >= cardDay) {
        age = curentYear - cardYear;
    } else {
        // 没过生日
        age = curentYear - cardYear - 1;
    }
    return age;
}

+ (BOOL)kr_isIdentityNumChar:(NSString *)identityChar {
    NSString *number = @"0123456789xX";
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:number] invertedSet];
    NSString *filtered = [[identityChar componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [identityChar isEqualToString:filtered];
    return basic;
}

+ (BOOL)kr_isBankCardNum:(NSString *)cardNumber {
    NSString *bank = @"^([\\d]{16,19})$";
    NSPredicate *regextestBank = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", bank];
    if ([regextestBank evaluateWithObject:cardNumber] == YES) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL)kr_isVaildRealName:(NSString *)realName {
    if (realName.length == 0) return NO;
    
    NSRange range1 = [realName rangeOfString:@"·"];
    NSRange range2 = [realName rangeOfString:@"•"];
    if(range1.location != NSNotFound ||   // 中文 ·
       range2.location != NSNotFound )    // 英文 •
    {
        //一般中间带 `•`的名字长度不会超过15位，如果有那就设高一点
        if ([realName length] < 2 || [realName length] > 15) {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+[·•][\u4e00-\u9fa5]+$" options:0 error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:realName options:0 range:NSMakeRange(0, [realName length])];
        
        NSUInteger count = [match numberOfRanges];
        
        return count == 1;
    }
    else {
        //一般正常的名字长度不会少于2位并且不超过8位，如果有那就设高一点
        if ([realName length] < 2 || [realName length] > 8) {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+$" options:0 error:NULL];
        
        NSTextCheckingResult *match = [regex firstMatchInString:realName options:0 range:NSMakeRange(0, [realName length])];
        
        NSUInteger count = [match numberOfRanges];
        
        return count == 1;
    }
}

@end
