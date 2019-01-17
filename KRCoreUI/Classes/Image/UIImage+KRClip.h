//
//  UIImage+KRClip.h
//  Nice9
//
//  Created by RK on 2018/12/23.
//  Copyright © 2018年 RK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KRClip)

/**
 UIView 截图为UIImage

 @param view 视图
 @return 截图
 */
+ (UIImage *)kr_capture:(UIView *)view;

/**
 图片裁剪

 @param image 图片
 @param frame 裁剪区域
 @return 裁剪图片
 */
+ (UIImage *)kr_clip:(UIImage *)image frame:(CGRect)frame;

/**
 调整图片大小

 @param size 目标大小
 @return f调整后的图片大小
 */
- (nullable UIImage *)kr_imageByResizeToSize:(CGSize)size;

/**
 图片设置蒙版图片

 @param image 底部图片
 @param maskImage 蒙版图片
 @return 处理后的图片
 */
+ (UIImage *)kr_maskImage:(UIImage *)image withMask:(UIImage *)maskImage;

+(UIImage *)creatImageWithBackimage:(UIImage *)Backimage andMaskImage:(UIImage *)MaskImage;

/**
 *  图片alpha处理，有颜色的变成透明的，透明的变成白色
 *
 *  @param image 图片源
 *
 *  @return 更改后的图片
 */
+ (UIImage *)kr_alphaTransparent:(UIImage*)image;

@end

NS_ASSUME_NONNULL_END
