//
//  UIView+KRExt.m
//  KRMoneyTip
//
//  Created by RK on 2018/12/8.
//  Copyright © 2018年 RK. All rights reserved.
//

#import "UIView+KRExt.h"

@implementation UIView (KRExt)

- (CGFloat)kr_originX {
    return self.frame.origin.x;
}

- (void)setKr_originX:(CGFloat)originX {
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
    return;
}

- (CGFloat)kr_originY {
    return self.frame.origin.y;
}

- (void)setKr_originY:(CGFloat)originY {
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
    return;
}

- (CGFloat)kr_rightX {
    return [self kr_originX] + [self kr_width];
}

- (void)setKr_rightX:(CGFloat)rightX {
    CGRect frame = self.frame;
    frame.origin.x = rightX - [self kr_width];
    self.frame = frame;
    return;
}

- (CGFloat)kr_bottomY {
    return [self kr_originY] + [self kr_height];
}

- (void)setKr_bottomY:(CGFloat)bottomY {
    CGRect frame = self.frame;
    frame.origin.y = bottomY - [self kr_height];
    self.frame = frame;
    return;
}

- (CGFloat)kr_centerX {
    return self.center.x;
}

- (void)setKr_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
    return;
}

- (CGFloat)kr_centerY {
    return self.center.y;
}

- (void)setKr_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
    return;
}

- (CGFloat)kr_width {
    return self.frame.size.width;
}

- (void)setKr_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    return;
}

- (CGFloat)kr_height {
    return self.frame.size.height;
}

- (void)setKr_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    return;
}

- (CGPoint)kr_origin {
    return self.frame.origin;
}

- (void)setKr_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
    return;
}

- (CGSize)kr_size {
    return self.frame.size;
}

- (void)setKr_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    return;
}

@end
