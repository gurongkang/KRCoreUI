//
//  UINib+KR.m
//  KRMoneyTip
//
//  Created by RK on 2018/12/8.
//  Copyright © 2018年 RK. All rights reserved.
//

#import "UINib+KR.h"

@implementation UINib (KR)

+ (UINib *)kr_nibWithNibName:(NSString *)nibName {
    return [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]];
}

@end
