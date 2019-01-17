//
//  UIImage+KRClip.m
//  Nice9
//
//  Created by RK on 2018/12/23.
//  Copyright © 2018年 RK. All rights reserved.
//

#import "UIImage+KRClip.h"

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
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) >= 0xffffff00) {
            // 此处把白色背景颜色给变为透明
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }else{
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = 255; //0~255
            ptr[2] = 255;
            ptr[1] = 255;
            ptr[0] = 255;
        }
    }
    
    // 将内存转成image
    CGDataProviderRef dataProvider =CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast |kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true,kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
}

void ProviderReleaseData (void *info, const void *data, size_t size) {
    free((void*)data);
}

@end
