//
//  UIView+KRExt.h
//  KRMoneyTip
//
//  Created by RK on 2018/12/8.
//  Copyright © 2018年 RK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KRExt)

@property(nonatomic) CGFloat kr_originX;

@property(nonatomic) CGFloat kr_originY;

@property(nonatomic) CGFloat kr_rightX;

@property(nonatomic) CGFloat kr_bottomY;

@property(nonatomic) CGFloat kr_width;

@property(nonatomic) CGFloat kr_height;

@property(nonatomic) CGFloat kr_centerX;

@property(nonatomic) CGFloat kr_centerY;

@property(nonatomic) CGPoint kr_origin;

@property(nonatomic) CGSize kr_size;

@end

NS_ASSUME_NONNULL_END
