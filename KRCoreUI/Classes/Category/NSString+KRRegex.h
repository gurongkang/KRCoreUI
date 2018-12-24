//
//  NSString+Regex.h
//  iOS-LQB
//
//  Created by RK on 2017/6/9.
//  Copyright © 2017年 顾荣康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KRRegex)

/**
 是否是纯数字
 
 @param num 校验的字符串
 @return YES 是 NO 否
 */
+ (BOOL)kr_isNumber:(NSString *)num;

/**
 是否是手机号

 @param mobileNum 手机号
 @return YES 是 NO 否
 */
+ (BOOL)kr_isMobileNumber:(NSString *)mobileNum;

/**
 是否是空串

 @param string 字符串
 @return YES 是 NO 否
 */
+ (BOOL)kr_isBlankString:(NSString *)string;

/**
 字符串是否是数字或字母组成

 @param num 字符串
 @return YES 是 NO 否
 */
+ (BOOL)isNumberOrLetter:(NSString *)num;

/**
 老版本密码，只能是数字字母8 - 20

 @param passWord 密码
 @return YES 是 NO 否
 */
+ (BOOL)kr_validatePassword:(NSString *)passWord;

/**
 新版本密码，数字字母同时存在 6 - 20

 @param passWord passWord 密码

 @return YES 是 NO 否
 */
+ (BOOL)kr_newValidatePassword:(NSString *)passWord;

/**
 是否是验证码

 @param code 验证码
 @return YES 是 NO 否
 */
+ (BOOL)kr_isCode:(NSString *)code;

/**
 是否是身份证号

 @param identityCard 身份证号
 @return YES 是 NO 否
 */
+ (BOOL)kr_isIdentityNum:(NSString *)identityCard;


/**
 输入的字母是身份证的

 @param identityChar 输入字符
 @return YES 是 NO 否
 */
+ (BOOL)kr_isIdentityNumChar:(NSString *)identityChar;

/**
 是否是银行卡

 @param cardNumber 银行卡号
 @return YES 是 NO 否
 */
+ (BOOL)kr_isBankCardNum:(NSString *)cardNumber;


/**
 根据银行卡号获取年龄 不判断银行卡是否正确，请确认输入正确的银行卡号
 
 @param identityCard 银行卡号
 @return 年龄
 */
+ (NSInteger)kr_ageFromIdentityNum:(NSString *)identityCard;
/**
 判断是否是有效的中文名
 
 @param realName 名字
 @return 如果是在如下规则下符合的中文名则返回`YES`，否则返回`NO`
 限制规则：
 1. 首先是名字要大于2个汉字，小于8个汉字
 2. 如果是中间带`{•|·}`的名字，则限制长度15位（新疆人的名字有15位左右的，之前公司实名认证就遇到过），如果有更长的，请自行修改长度限制
 3. 如果是不带小点的正常名字，限制长度为8位，若果觉得不适，请自行修改位数限制
 *PS: `•`或`·`具体是那个点具体处理需要注意*
 */
+ (BOOL)kr_isVaildRealName:(NSString *)realName;

@end
