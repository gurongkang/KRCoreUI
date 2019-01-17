//
//  UIImage+KRClip.m
//  Nice9
//
//  Created by RK on 2018/12/23.
//  Copyright © 2018年 RK. All rights reserved.
//https://www.jianshu.com/p/619ef8423895
//https://www.jianshu.com/p/05e393f2d723

#import "UIImage+KRClip.h"

#define MaskB(x) ((x) & 0xFF)
#define R(x) (MaskB(x))
#define G(x) (MaskB(x >> 8))
#define B(x) (MaskB(x >> 16))
#define A(x) (MaskB(x >> 24))
#define RGBA(r,g,b,a) (MaskB(r) | MaskB(g)<<8 | MaskB(b) << 16 | MaskB(a) << 24)


@implementation UIImage (KRClip)

+ (UIImage *)kr_capture:(UIView *)view {
    UIImage *imageRet = [[UIImage alloc]init];
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageRet;
}

+ (UIImage *)kr_clip:(UIImage *)image frame:(CGRect)frame {
    UIImage *resultImg = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(image.CGImage, frame)];
    return resultImg;
}

- (UIImage *)kr_imageByResizeToSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage*)kr_maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    CGImageRelease(mask);
    UIImage *maskedImage = [UIImage imageWithCGImage:masked ];
    CGImageRelease(masked);
    return maskedImage;
}

+(UIImage *)creatImageWithBackimage:(UIImage *)Backimage andMaskImage:(UIImage *)MaskImage
{
    CGImageRef maskImage = MaskImage.CGImage;
    //    CGImageRef bgimage  = BgImage.CGImage;
    CGImageRef  mask = CGImageMaskCreate(CGImageGetWidth(maskImage), CGImageGetHeight(maskImage), CGImageGetBitsPerComponent(maskImage),  CGImageGetBitsPerPixel(maskImage), CGImageGetBytesPerRow(maskImage), CGImageGetDataProvider(maskImage),NULL, false);
    
    CGImageRef imageWithAlpha = Backimage.CGImage;
    CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);
    UIImage * newimage = [UIImage imageWithCGImage:masked];
    //    CGImageRelease(maskImage);
    //    CGImageRelease(imageWithAlpha);
    CGImageRelease(masked);
    return newimage;
}

+ (UIImage *)kr_alphaTransparent:(UIImage*)image {
    //第一步：确定图片的大小
    CGImageRef imageFef = image.CGImage;
    NSUInteger width = CGImageGetWidth(imageFef);
    NSUInteger height = CGImageGetHeight(imageFef);
    //第二部：创建颜色空间（开辟内存空间，目的：操作像素点）
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    //第三部：创建图片上下文
    UInt32 *inputPixels = (UInt32*)calloc(width * height, sizeof(UInt32));
    CGContextRef contextRef = CGBitmapContextCreate(inputPixels, width, height, 8, 4 * width, colorSpaceRef, kCGBitmapByteOrderDefault|kCGImageAlphaPremultipliedLast);
    //第四步：根据上下文绘制图片
    CGContextDrawImage(contextRef, CGRectMake(0, 0, width, height), imageFef);
    //循环便利图片像素点
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            //获取当前图片的像素点 -->指针位移  inputPixels数组的首地址，不会变
            UInt32 *currnetPixels = inputPixels + (i * width) + j;
            //获取我们像素点对应的颜色值（*取值 &取地址）
            UInt32 color = *currnetPixels;
            UInt32 thisR,thisG,thisB,thisA;
            thisR = 255;
            thisG = 255;
            thisB = 255;
            thisA = A(color);
            if (thisA == 0) {
                thisA = 255;
            } else {
                thisA = 0;
            }
            //修改像素点的值
            *currnetPixels = RGBA(thisR, thisG, thisB, thisA);
        }
    }
    
    //创建UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //第五步：释放内存
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(contextRef);
    CGImageRelease(newImageRef);
    free(inputPixels);
    return newImage;
}

@end
